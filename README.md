# South Block (Flutter)

## Run
    flutter pub get
    flutter run -d chrome
    # later, against the Worker API (step 5):
    flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:8787

## Structure (lib/)
    main.dart              entry point (loads the photo index, runs the app)
    app.dart               MaterialApp + theme
    config/                app_config (constants), theme (colours, text styles), routes (Pg, NavFn)
    models/                Item, Kind, Cat, HomeCat, Testimonial
    services/              menu_data (hardcoded content), menu_repository (the ONE place that
                           supplies content; step 5 swaps it for API calls), image_index
    utils/                 helpers (isMobile, soon, slugify)
    screens/               app_shell (nav + scroll + footer), home, menu, rewards, careers, stub
    widgets/               one file per UI section/component (nav_bar, home_hero, category_chips,
                           item_carousel, menu_grid, category_sidebar, product_art, site_footer, ...)

## Photos
`ProductArt(item)` is the one widget every screen uses. Precedence for each item:
1. `ImageService.pinned['<photoName lowercase>']` - a URL you choose (wins over everything)
2. a photo embedded in code: `lib/services/embedded_photos_data.dart` (generated, see below)
3. a file at `assets/images/menu/<imageKey>.jpg`
4. a live Wikimedia Commons photo (keyword rules in `lib/services/image_service.dart`)
5. the drawn illustration (always works, no network)

Download open-licensed photos and bake them into ONE Dart file (needs Python 3.8+, no packages):

    python tools/fetch_commons_photos.py --list                      # item -> search term (offline)
    python tools/fetch_commons_photos.py --contact you@example.com --embed

Photos land in `assets/images/menu/` (+ `CREDITS.md`) and are embedded into
`lib/services/embedded_photos_data.dart`. Replace any photo by saving your own `<imageKey>.jpg`
in that folder and running `--embed-only`. Only CC0 / public-domain / CC BY / CC BY-SA images are kept;
BY and BY-SA need attribution, so keep CREDITS.md or show credits in the app.
