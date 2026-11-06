import '../config/app_config.dart';
import '../widgets/product_art.dart';

import 'package:flutter/services.dart';

import '../config/app_config.dart';

/// Knows which menu photos were actually bundled, so we only request files
/// that exist and fall back to the drawn illustration for the rest.
class ImageIndex {
  ImageIndex._();
  static Set<String>? _paths;

  static Future<void> load() async {
    try {
      final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
      _paths = manifest.listAssets().where((a) => a.startsWith(AppConfig.menuImageDir)).toSet();
    } catch (_) {
      _paths = null; // unknown: ProductArt will try the asset and fall back on error
    }
  }

  /// True only if [path] was bundled with the app.
  static bool has(String path) => _paths?.contains(path) ?? false;

  static int get count => _paths?.length ?? 0;
}
