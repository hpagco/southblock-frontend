#!/usr/bin/env python3
"""
Download open-licensed photos (Wikimedia Commons) for every menu item and, optionally,
bake them into ONE Dart file so the app needs no network for pictures.

It reuses the app's own data, so names always match:
  - search terms: the _rules map in lib/services/image_service.dart (longest match wins)
  - items:        lib/services/menu_data.dart

Only images with a free license are kept (CC0, public domain, CC BY, CC BY-SA).
Items that share a search term get DIFFERENT photos. Credits go to
assets/images/menu/CREDITS.md (CC BY / BY-SA require attribution: keep that file
or show credits in the app).

Usage (run from the project root; needs Python 3.8+, no extra packages):
  python tools/fetch_commons_photos.py --list                       # show item -> search term, no network
  python tools/fetch_commons_photos.py --contact you@example.com    # download missing photos
  python tools/fetch_commons_photos.py --contact you@example.com --embed
  python tools/fetch_commons_photos.py --embed-only                 # rebuild the Dart file from assets/images/menu
  options: --only key1 key2 | --force | --width 480

--contact is required by Wikimedia's user-agent policy (an email or URL).
Honest note: Commons has generic photos of dishes, not your exact products, so review
the results; replace any you dislike by dropping your own <key>.jpg in assets/images/menu/
(then run --embed-only) or by pinning a URL in ImageService.pinned.
"""
import argparse, base64, json, os, re, sys, time, urllib.parse, urllib.request, urllib.error

HERE = os.path.dirname(os.path.abspath(__file__)); ROOT = os.path.dirname(HERE)
LIB = os.path.join(ROOT, 'lib'); OUTDIR = os.path.join(ROOT, 'assets', 'images', 'menu')
CREDITS_MD = os.path.join(OUTDIR, 'CREDITS.md'); CREDITS_JSON = os.path.join(HERE, 'commons_credits.json')
EMBED_DART = os.path.join(LIB, 'services', 'embedded_photos_data.dart')
API = 'https://commons.wikimedia.org/w/api.php'
FREE = re.compile(r'^(cc0|public domain|pd\b|cc[- ]by(-sa)?\b)', re.I)   # excludes NC / ND / fair use


def slug(s): return re.sub(r'[^a-z0-9]+', '-', s.lower().replace('&', 'and').replace('+', 'plus')).strip('-')


def load_rules():
    s = open(os.path.join(LIB, 'services', 'image_service.dart'), encoding='utf8').read()
    blk = s[s.index('_rules = <String, String>{'):]
    blk = blk[:blk.index('};')]
    return dict(re.findall(r"^\s+'([^']+)': '([^']+)',", blk, flags=re.M))


def keywords(rules, name):
    n = name.lower()
    for k in sorted(rules, key=len, reverse=True):
        if k in n: return rules[k]
    m = re.search(r"_defaultTerm = '([^']+)'", open(os.path.join(LIB, 'services', 'image_service.dart'), encoding='utf8').read())
    return m.group(1) if m else 'food'


def load_items():
    """(imageKey, photoName) for every distinct menu item, mirroring Item.imageKey / Item.photoName."""
    src = open(os.path.join(LIB, 'services', 'menu_data.dart'), encoding='utf8').read()
    rx = re.compile(r"I\('((?:[^'\\]|\\.)*)',\s*'(?:[^'\\]|\\.)*',\s*Kind\.(\w+)")
    items, blocks, cur = [], {}, None
    for line in src.split('\n'):
        m = re.match(r'final List<Item> (\w+) = \[', line)
        if m: cur = m.group(1)
        for n, k in rx.findall(line):
            n = n.replace("\\'", "'"); items.append((n, k)); blocks.setdefault(cur, []).append((n, k))
    for n, _ in blocks['acaiBowls'][:9]:           # mini bowls are derived in menu_data.dart
        if n != 'Aloha Bowl': items.append((n, 'mini'))
    for n, _ in blocks['smoothieBowls']: items.append((n, 'mini'))
    out, seen = [], set()
    for n, k in items:
        prefix = {'mini': 'mini-', 'wrap': 'wrap-', 'ibowl': 'bowl-'}.get(k, '')
        photo = {'wrap': n + ' wrap', 'ibowl': n + ' indian bowl'}.get(k, (n if n.lower().endswith('mini') else n + ' mini') if k == 'mini' else n)
        key = prefix + slug(n)
        if key not in seen: seen.add(key); out.append((key, photo))
    return out


def http(url, ua, retries=2):
    for a in range(retries + 1):
        try:
            with urllib.request.urlopen(urllib.request.Request(url, headers={'User-Agent': ua}), timeout=30) as r:
                return r.read()
        except urllib.error.HTTPError as e:
            if e.code in (429, 503) and a < retries: time.sleep(3 * (a + 1)); continue
            raise


def search(term, ua, width):
    q = {'action': 'query', 'generator': 'search', 'gsrsearch': term + ' filetype:bitmap', 'gsrnamespace': '6', 'gsrlimit': '30',
         'prop': 'imageinfo', 'iiprop': 'url|mime|size|extmetadata', 'iiextmetadatafilter': 'LicenseShortName|Artist',
         'iiurlwidth': str(width), 'format': 'json'}
    data = json.loads(http(API + '?' + urllib.parse.urlencode(q), ua))
    pages = sorted((data.get('query', {}).get('pages', {})).values(), key=lambda p: p.get('index', 99))
    res = []
    for p in pages:
        info = (p.get('imageinfo') or [None])[0]
        if not info or info.get('mime') != 'image/jpeg' or info.get('width', 0) < 600: continue
        md = info.get('extmetadata', {})
        lic = (md.get('LicenseShortName', {}) or {}).get('value', '')
        if not FREE.match(lic.strip()): continue
        artist = re.sub(r'<[^>]+>', '', (md.get('Artist', {}) or {}).get('value', 'unknown')).strip()
        res.append({'url': info['thumburl'], 'page': info['descriptionurl'], 'license': lic, 'artist': artist, 'title': p['title']})
    return res


def embed():
    files = sorted(f for f in os.listdir(OUTDIR) if f.lower().endswith('.jpg'))
    total = 0
    with open(EMBED_DART, 'w', encoding='utf8') as o:
        o.write("// GENERATED by tools/fetch_commons_photos.py --embed. Do not edit by hand.\n"
                "// Map: Item.imageKey -> base64 JPEG.\nconst Map<String, String> kEmbeddedPhotosData = {\n")
        for f in files:
            b = open(os.path.join(OUTDIR, f), 'rb').read(); total += len(b)
            o.write(f"  '{f[:-4]}': '{base64.b64encode(b).decode()}',\n")
        o.write('};\n')
    print(f'Embedded {len(files)} photos ({total/1024:.0f} KB of JPEG, {os.path.getsize(EMBED_DART)/1024:.0f} KB of Dart) into lib/services/embedded_photos_data.dart')
    if total > 6_000_000: print('Warning: large. Use --width 360 to shrink, or ship assets/ instead of embedding.')


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--list', action='store_true'); ap.add_argument('--embed', action='store_true'); ap.add_argument('--embed-only', action='store_true')
    ap.add_argument('--force', action='store_true'); ap.add_argument('--only', nargs='*'); ap.add_argument('--contact'); ap.add_argument('--width', type=int, default=480)
    a = ap.parse_args()
    rules, items = load_rules(), load_items()
    os.makedirs(OUTDIR, exist_ok=True)
    if a.list:
        for key, photo in items: print(f'{key:46} {photo:44} -> {keywords(rules, photo)}')
        print(len(items), 'items,', len({keywords(rules, p) for _, p in items}), 'search terms'); return
    if a.embed_only: embed(); return
    if not a.contact: sys.exit('Pass --contact you@example.com (Wikimedia requires a contact in the user agent).')
    ua = f'SouthBlockAppPhotoFetcher/1.0 ({a.contact})'
    credits = json.load(open(CREDITS_JSON, encoding='utf8')) if os.path.exists(CREDITS_JSON) else {}
    used = {c['url'] for c in credits.values()}
    cache, taken, done = {}, {}, 0
    for key, photo in items:
        if a.only and key not in a.only: continue
        path = os.path.join(OUTDIR, key + '.jpg')
        if os.path.exists(path) and not a.force: continue
        term = keywords(rules, photo)
        try:
            if term not in cache: cache[term] = search(term, ua, a.width); time.sleep(0.3)
            pick = next((r for r in cache[term] if r['url'] not in used), None)
            if not pick: print(f'  none free/unused for "{term}" ({key}); change its rule or add your own {key}.jpg'); continue
            open(path, 'wb').write(http(pick['url'], ua)); time.sleep(0.3)
            used.add(pick['url']); credits[key] = pick; done += 1
            print(f'ok  {key:46} <- "{term}"  [{pick["license"]}]')
        except Exception as e:
            print(f'  failed {key}: {e}')
    json.dump(credits, open(CREDITS_JSON, 'w', encoding='utf8'), indent=2)
    with open(CREDITS_MD, 'w', encoding='utf8') as f:
        f.write('# Photo credits\n\nFrom Wikimedia Commons. Licenses: CC0 / public domain / CC BY / CC BY-SA (BY and BY-SA require attribution).\n\n')
        for k, c in sorted(credits.items()):
            f.write(f"- `{k}.jpg`: {c['title']} by {c['artist']}, {c['license']} - {c['page']}\n")
    print(f'\nDownloaded {done}. Credits: assets/images/menu/CREDITS.md')
    if a.embed: embed()
    else: print('Run again with --embed (or --embed-only) to bake them into one Dart file.')


if __name__ == '__main__':
    main()
