import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../utils/helpers.dart';

/// Default secondary (topping) colour for items that don't specify one.
const int kDefaultAccent = 0xFFD9A35B;

/// Which illustration to draw when no photo exists.
enum Kind { bowl, mini, cup, toast, juice, bottle, can, bag, pot, ibowl, sauce, roti, wrap, hot, cookie, bar, crisps }

class Item {
  final String name, desc, tag, sec;
  final Kind kind;
  final Color a, b;

  /// Optional remote photo (step 5: from the API). A local asset photo wins over this.
  final String? imageUrl;

  const Item(this.name, this.desc, this.kind, this.a, this.b, [this.tag = '', this.sec = '', this.imageUrl]);

  Item copy({Kind? kind, String? desc, String? sec}) =>
      Item(name, desc ?? this.desc, kind ?? this.kind, a, b, tag, sec ?? this.sec, imageUrl);

  /// File name (no extension) of this item's photo. Prefixes keep same-named
  /// items apart ("Tandoori Chicken" pot vs wrap, bowl vs mini bowl).
  String get imageKey {
    final prefix = switch (kind) {
      Kind.mini => 'mini-',
      Kind.wrap => 'wrap-',
      Kind.ibowl => 'bowl-',
      _ => '',
    };
    return '$prefix${slugify(name)}';
  }

  /// What FoodImage / ImageService search with. Wraps, Indian bowls and mini bowls get a
  /// suffix so same-named items can use different rules and different pinned photos.
  /// Pin keys are this string in lowercase, e.g. 'tandoori chicken wrap'.
  String get photoName {
    final n = name.toLowerCase();
    return switch (kind) {
      Kind.wrap => '$name wrap',
      Kind.ibowl => '$name indian bowl',
      Kind.mini => n.endsWith('mini') ? name : '$name mini',
      _ => name,
    };
  }

  String get assetPath => '${AppConfig.menuImageDir}/$imageKey.jpg';
}
