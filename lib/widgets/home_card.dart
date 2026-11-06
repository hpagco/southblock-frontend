import 'package:flutter/material.dart';

import '../config/theme.dart';
import '../models/item.dart';
import 'product_art.dart';

class HomeCard extends StatelessWidget {
  final Item it;
  final VoidCallback onTap;
  const HomeCard(this.it, this.onTap);
  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(color: C.card, height: 270, padding: const EdgeInsets.all(26), child: ProductArt(it)),
          Container(
            color: C.green,
            height: 130,
            padding: const EdgeInsets.all(14),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(it.name.toUpperCase(), style: body(15, color: Colors.white, w: FontWeight.w800)),
              const SizedBox(height: 6),
              Expanded(child: Text(it.desc, maxLines: 4, overflow: TextOverflow.ellipsis, style: body(11, color: Colors.white, w: FontWeight.w600, h: 1.3))),
              Text('Order Now »', style: body(12, color: Colors.white70)),
            ]),
          ),
        ]),
      );
}
