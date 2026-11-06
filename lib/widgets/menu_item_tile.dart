import 'package:flutter/material.dart';

import '../config/theme.dart';
import '../models/item.dart';
import 'product_art.dart';

/// One item in the menu grid: photo/illustration, name, description, dietary tags.
class MenuItemTile extends StatelessWidget {
  final Item item;
  final double width;
  const MenuItemTile({super.key, required this.item, required this.width});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: width,
        child: Column(children: [
          SizedBox(height: 130, width: 130, child: ProductArt(item)),
          const SizedBox(height: 6),
          Text(item.name, textAlign: TextAlign.center, style: body(13, w: FontWeight.w800)),
          if (item.desc.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 3), child: Text(item.desc, textAlign: TextAlign.center, style: body(10.5, color: C.soft, h: 1.3))),
          if (item.tag.isNotEmpty) Text('(${item.tag})', style: body(10, color: C.green, w: FontWeight.w800)),
        ]),
      );
}
