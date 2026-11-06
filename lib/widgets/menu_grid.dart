import 'package:flutter/material.dart';

import '../config/theme.dart';
import '../models/category.dart';
import 'menu_item_tile.dart';

/// The item grid for one category, with optional intro text and section headings.
class MenuGrid extends StatelessWidget {
  final Cat category;
  final int columns;
  const MenuGrid({super.key, required this.category, required this.columns});

  @override
  Widget build(BuildContext context) => LayoutBuilder(builder: (ctx, bc) {
        const gap = 14.0;
        final w = (bc.maxWidth - gap * (columns - 1)) / columns - .5;
        final kids = <Widget>[];
        if (category.intro.isNotEmpty) kids.add(SizedBox(width: bc.maxWidth, child: Text(category.intro, style: body(13, color: C.soft))));
        var last = '';
        for (final it in category.items) {
          if (it.sec.isNotEmpty && it.sec != last) {
            last = it.sec;
            kids.add(SizedBox(
              width: bc.maxWidth,
              child: Container(
                margin: const EdgeInsets.only(top: 14),
                padding: const EdgeInsets.only(bottom: 6),
                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: C.green, width: 2))),
                child: Text(it.sec, style: slab(18, w: FontWeight.w700)),
              ),
            ));
          }
          kids.add(MenuItemTile(item: it, width: w));
        }
        return Wrap(spacing: gap, runSpacing: 26, children: kids);
      });
}
