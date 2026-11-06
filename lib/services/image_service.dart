import 'dart:convert';

import 'package:http/http.dart' as http;

/// Finds a free (Wikimedia Commons) photo for an item name.
/// Order of precedence: [pinned] URL > search by keyword rule.
class ImageService {
  /// Exact photo URLs I choose myself. Key = Item.photoName in lowercase, e.g.
  ///   'warrior bowl': 'https://example.com/my-warrior-bowl.jpg',
  ///   'tandoori chicken wrap': 'https://example.com/wrap.jpg',   // wraps end in ' wrap'
  ///   'golden hour indian bowl': '...',                          // Indian bowls end in ' indian bowl'
  ///   'warrior bowl mini': '...',                                // mini bowls end in ' mini'
  static const pinned = <String, String>{};

  /// If the item name contains the key, search Commons for the value.
  /// Longest matching key wins. Keys must be unique lowercase.
  static const _rules = <String, String>{
    'acai bowl': 'acai bowl',
    'warrior smoothie': 'berry smoothie',
    'warrior': 'acai bowl',
    'nutella': 'acai bowl',
    'pbj smoothie': 'berry smoothie',
    'pbj': 'acai bowl',
    'almond butter': 'acai bowl',
    'dubai': 'acai bowl',
    'cali vibes': 'acai bowl',
    'aloha': 'acai bowl',
    'green bowl': 'green smoothie bowl',
    'magic dragon': 'dragon fruit bowl',
    'mermaid bowl': 'smoothie bowl',
    'mermaid smoothie': 'blue smoothie',
    'strawberry bowl': 'smoothie bowl',
    'chocolate covered strawberry': 'chocolate strawberries',
    'mango sunshine': 'smoothie bowl',
    'peanut blast bowl': 'smoothie bowl',
    'peanut blast smoothie + spinach': 'green smoothie',
    'peanut blast': 'banana smoothie',
    'yogurt bowl': 'yogurt granola',
    'yogurt smoothie': 'smoothie',
    'lean green protein yogurt smoothie': 'green smoothie',
    'pumpkin': 'pumpkin pie',
    'apple crisp': 'apple crisp',
    'daily protein': 'protein shake',
    'incredible bulk': 'smoothie',
    'monkey': 'banana smoothie',
    'health nut': 'smoothie',
    'mother earth': 'green smoothie',
    'greens + protein': 'green smoothie',
    'tropi-kale': 'kale smoothie',
    'super green': 'green smoothie',
    'pink pitaya': 'dragon fruit',
    'strawberry cloud': 'strawberry smoothie',
    'blue sky': 'blue smoothie',
    'guava': 'guava',
    'mango': 'mango smoothie',
    'strawberry': 'strawberry smoothie',
    'green mini': 'green smoothie',
        'avocado toast': 'avocado toast',
    'banana almond toast': 'banana toast',
    'reset juice': 'green juice',
    'level up juice': 'green juice',
    'rise up juice': 'apple juice',
    'shine on juice': 'beet juice',
    'all heart juice': 'beet juice',
    'brightside juice': 'mango juice',
    'daily dose': 'ginger',
    'fiji': 'bottled water',
    'spindrift': 'sparkling water',
    'collagen': 'protein powder',
    'plant protein': 'protein powder',
    'whey protein': 'protein powder',
    'cauliflower biryani': 'biryani',
    'mixed quinoa': 'quinoa',
    'shredded cabbage': 'cabbage salad',
    'tandoori chicken': 'tandoori chicken',
    'honey masala chicken': 'chicken tikka',
    'goan glazed salmon': 'grilled salmon',
    'spring paneer': 'paneer',
    'chickpea chaat': 'chana chaat',
    'turmeric coconut dal': 'dal',
    'charred honey broccoli': 'roasted broccoli',
    'golden roasted cauliflower': 'roasted cauliflower',
    'masala spiced sweet potato': 'roasted sweet potato',
    'kaana kachumba': 'kachumber',
    'roasted masala chickpea': 'roasted chickpeas',
    'avocado, mango': 'avocado salad',
    'kaana slaw': 'coleslaw',
    'honey masala mustard': 'mustard',
    'tamarind chutney': 'tamarind chutney',
    'coriander chutney': 'green chutney',
    'mango hot sauce': 'hot sauce',
    'raita': 'raita',
    'lime + chilli': 'lime',
    'red chillies': 'red chili pepper',
    'green chillies': 'green chili pepper',
    'crunchy spice': 'sev',
    'lime wedges': 'lime',
    'pickled red onions': 'pickled onion',
    'kaana relish': 'relish',
    'roti': 'roti',
    'tandoori chicken wrap': 'chicken wrap',
    'masala honey chicken wrap': 'chicken wrap',
    'spring paneer wrap': 'kathi roll',
    'chickpea chaat wrap': 'wrap sandwich',
    'golden hour': 'biryani',
    'slaw and order': 'rice bowl',
    'fishful': 'salmon bowl',
    'unbe-leaf-able': 'buddha bowl',
    'sweet, spice': 'buddha bowl',
    'masala chai': 'masala chai',
    'pink chai': 'kashmiri tea',
    'golden chai': 'turmeric latte',
    'hot chocolate': 'hot chocolate',
    'teas': 'tea',
    'sparkling water': 'sparkling water',
    'still water': 'bottled water',
    'dash water': 'sparkling water',
    'trip cbd': 'sparkling water',
    'kombucha': 'kombucha',
    'iced tea': 'iced tea',
    'lychee': 'lychee',
    'xoxo orange': 'orange soda',
    'coke': 'cola',
    'chocolate chip cookie': 'chocolate chip cookie',
    'cranberry oatmeal': 'oatmeal cookie',
    'double chocolate': 'chocolate cookie',
    'barebells': 'protein bar',
    'hu vanilla': 'chocolate bar',
    'howdah bombay': 'potato chips',
    'howdah onion bhaji': 'potato chips',
    'hero home': 'smoothie bowl',
    'hero rewards': 'acai bowl',
  };
  static const _defaultTerm = 'healthy food';

  static String keywords(String name) {
    final n = name.toLowerCase();
    final keys = _rules.keys.toList()..sort((a, b) => b.length.compareTo(a.length));
    for (final k in keys) {
      if (n.contains(k)) return _rules[k]!;
    }
    return _defaultTerm;
  }

  // term -> all usable JPEG urls (ranked); results are cached per search term.
  static final _cache = <String, Future<List<String>>>{};
  // term -> which item took which result, so items sharing a term get DIFFERENT photos.
  static final _claims = <String, Map<String, int>>{};
  static final _byName = <String, Future<String?>>{};

  static Future<String?> resolve(String name) {
    final key = name.toLowerCase();
    final pin = pinned[key];
    if (pin != null) return Future.value(pin);
    return _byName.putIfAbsent(key, () async {
      final kw = keywords(name);
      final urls = await _cache.putIfAbsent(kw, () => _commons(kw));
      if (urls.isEmpty) return null;
      final claims = _claims.putIfAbsent(kw, () => <String, int>{});
      final i = claims.putIfAbsent(key, () => claims.length); // first item gets the first JPEG
      return urls[i % urls.length];
    });
  }

  static Future<List<String>> _commons(String term) async {
    final uri = Uri.https('commons.wikimedia.org', '/w/api.php', {
      'action': 'query',
      'generator': 'search',
      'gsrsearch': '$term filetype:bitmap',
      'gsrnamespace': '6',
      'gsrlimit': '20',
      'prop': 'imageinfo',
      'iiprop': 'url|mime|size',
      'iiurlwidth': '500',
      'format': 'json',
      'origin': '*', // lets browsers call the API
    });
    final out = <String>[];
    try {
      final res = await http.get(uri).timeout(const Duration(seconds: 10));
      final pages = ((jsonDecode(res.body)['query']?['pages'] as Map?)?.values.toList() ?? [])
        ..sort((a, b) => ((a['index'] ?? 99) as int).compareTo((b['index'] ?? 99) as int));
      for (final p in pages) {
        final info = (p['imageinfo'] as List?)?.first;
        if (info == null || info['mime'] != 'image/jpeg' || (info['width'] ?? 0) < 600) continue;
        final url = info['thumburl'] as String?;
        if (url != null) out.add(url);
      }
    } catch (_) {}
    return out;
  }
}
