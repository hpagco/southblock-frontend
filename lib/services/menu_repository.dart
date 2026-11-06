import '../models/category.dart';
import '../models/item.dart';
import '../models/testimonial.dart';

import '../models/category.dart';
import '../models/item.dart';
import '../models/testimonial.dart';
import 'menu_data.dart' as data;

/// Single access point for menu content. Today it reads hardcoded lists;
/// in step 5 only this class changes (to call the Cloudflare Worker API).
class MenuRepository {
  const MenuRepository._();
  static const MenuRepository instance = MenuRepository._();

  List<Cat> get categories => data.cats;
  List<HomeCat> get homeCategories => data.homeCats;
  List<Testimonial> get testimonials => data.testimonials;

  Cat categoryById(String id) => categories.firstWhere((c) => c.id == id, orElse: () => categories.first);

  /// First menu item with this exact name (used for decorative spots on pages).
  Item find(String name) {
    for (final c in categories) {
      for (final i in c.items) {
        if (i.name == name) return i;
      }
    }
    throw ArgumentError('Unknown menu item: $name');
  }
}
