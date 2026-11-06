import 'package:flutter/material.dart';

import '../config/theme.dart';
import '../services/menu_repository.dart';
import '../utils/helpers.dart';
import '../widgets/box.dart';
import '../widgets/category_sidebar.dart';
import '../widgets/catering_block.dart';
import '../widgets/menu_grid.dart';
import '../widgets/protein_banner.dart';
import '../widgets/roll_with_us_band.dart';
import '../widgets/testimonial_strip.dart';

class MenuScreen extends StatelessWidget {
  final String cat;
  final ValueChanged<String> onCat;
  const MenuScreen({super.key, required this.cat, required this.onCat});

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    final repo = MenuRepository.instance;
    final cur = repo.categoryById(cat);
    final sidebar = CategorySidebar(categories: repo.categories, selectedId: cur.id, onSelect: onCat, compact: mobile);
    final grid = MenuGrid(category: cur, columns: mobile ? 2 : 3);
    return Column(children: [
      ProteinBanner(go: (p, {String? cat}) => onCat(cat ?? 'featured'), big: true),
      Box(
        max: 900,
        pad: const EdgeInsets.fromLTRB(24, 40, 24, 70),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Menu', style: slab(38, w: FontWeight.w700)),
          const SizedBox(height: 14),
          if (mobile) ...[sidebar, const SizedBox(height: 20), grid] else Row(crossAxisAlignment: CrossAxisAlignment.start, children: [sidebar, const SizedBox(width: 22), Expanded(child: grid)]),
        ]),
      ),
      const RollWithUsBand(),
      const CateringBlock(),
      const TestimonialStrip(),
    ]);
  }
}
