import 'package:flutter/material.dart';

import '../config/routes.dart';
import '../config/theme.dart';
import '../models/item.dart';
import '../services/menu_repository.dart';
import '../utils/helpers.dart';
import 'box.dart';
import 'product_art.dart';
import 'sb_button.dart';

class ProteinBanner extends StatelessWidget {
  final NavFn go;
  final bool big;
  const ProteinBanner({super.key, required this.go, required this.big});
  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    Widget art(Item i, String l1, String l2, String g) => Stack(alignment: Alignment.bottomCenter, children: [
          SizedBox(width: big ? 220 : 130, height: big ? 220 : 130, child: ProductArt(i)),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(l1, style: body(7, w: FontWeight.w800, h: 1.1)),
              Text(l2, style: body(7, w: FontWeight.w800, h: 1.1)),
              Text(g, style: body(8, color: C.green, w: FontWeight.w800)),
            ]),
          ),
        ]);
    final text = Column(crossAxisAlignment: big ? CrossAxisAlignment.start : CrossAxisAlignment.center, children: [
      Text('PROTEIN JUST\nGOT CREAMIER', textAlign: big ? TextAlign.left : TextAlign.center, style: slab(big ? 44 : 26, color: Colors.white)),
      const SizedBox(height: 8),
      Text('Made With Real Greek Yogurt', style: body(big ? 22 : 15, color: Colors.white, w: FontWeight.w400)),
      const SizedBox(height: 12),
      SbButton('Order Now', () => go(Pg.menu, cat: 'featured')),
    ]);
    final inner = mobile
        ? text
        : Row(mainAxisAlignment: big ? MainAxisAlignment.start : MainAxisAlignment.spaceEvenly, children: [
            art(MenuRepository.instance.find('Berry Balanced Protein Yogurt Smoothie'), 'BERRY BALANCED', 'PROTEIN YOGURT SMOOTHIE', '20g PROTEIN'),
            if (big) const SizedBox(width: 40),
            text,
            if (!big) art(MenuRepository.instance.find('Berry Glaze Protein Yogurt Bowl'), 'BERRY GLAZE', 'PROTEIN YOGURT BOWL', '28g PROTEIN'),
          ]);
    return Container(
      color: C.forest,
      width: big ? double.infinity : null,
      constraints: big ? null : const BoxConstraints(maxWidth: 820),
      margin: big ? null : const EdgeInsets.symmetric(horizontal: 12),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: big ? 48 : 16),
      alignment: Alignment.center,
      child: big ? Box(child: inner) : inner,
    );
  }
}
