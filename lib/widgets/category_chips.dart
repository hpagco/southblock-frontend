import 'package:flutter/material.dart';

import '../config/theme.dart';
import '../models/category.dart';
import 'box.dart';
import 'product_art.dart';

/// The six home-page category chips (Seasonal, Protein Picks, Bowls, ...).
class CategoryChips extends StatelessWidget {
  final List<HomeCat> categories;
  final int selected;
  final ValueChanged<int> onSelect;
  const CategoryChips({super.key, required this.categories, required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) => Box(
        max: 900,
        child: Wrap(spacing: 10, runSpacing: 30, alignment: WrapAlignment.center, children: [
          for (var i = 0; i < categories.length; i++)
            InkWell(
              onTap: () => onSelect(i),
              child: Stack(clipBehavior: Clip.none, children: [
                Container(
                  width: 138,
                  height: 52,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 10, right: 50),
                  decoration: BoxDecoration(color: i == selected ? C.green : C.card, border: Border.all(color: C.green)),
                  child: Text(categories[i].label.toUpperCase(), style: body(12, color: i == selected ? Colors.white : C.ink, w: FontWeight.w800, h: 1.1)),
                ),
                Positioned(right: 2, top: -18, width: 54, height: 60, child: ProductArt(categories[i].icon)),
              ]),
            ),
        ]),
      );
}
