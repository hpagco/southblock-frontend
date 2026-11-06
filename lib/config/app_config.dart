import 'package:flutter/painting.dart';

import '../models/item.dart';

/// App-wide constants. Override the API base URL at build time:
///   flutter run --dart-define=API_BASE_URL=https://your-worker.workers.dev
class AppConfig {
  AppConfig._();

  /// Width below which the mobile layout is used.
  static const double mobileBreakpoint = 820;

  /// Folder (declared in pubspec.yaml) holding one photo per menu item.
  /// File name = Item.imageKey + '.jpg', e.g. assets/images/menu/warrior-bowl.jpg
  static const String menuImageDir = 'assets/images/menu';

  /// Used from step 5 (live data). Never hardcode a production URL here.
  static const String apiBaseUrl = String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:8787');
}

/// Colours used by FoodImage placeholders.
class Brand {
  Brand._();
  static const Color soft = Color(0xFFEFEDE6);
  static const Color gold = Color(0xFFFCB827);
}
