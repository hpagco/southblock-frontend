import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/category.dart';
import '../utils/helpers.dart';
import 'box.dart';
import 'home_card.dart';

/// Shows 3 DIFFERENT items of a home category at a time; arrows page through them.
class ItemCarousel extends StatelessWidget {
  final HomeCat category;
  final int page;
  final ValueChanged<int> onPage;
  final VoidCallback onTapItem;
  const ItemCarousel({super.key, required this.category, required this.page, required this.onPage, required this.onTapItem});

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    final n = category.items.length;
    final pages = (n / 3).ceil();
    // window of 3 different items; wraps around without repeating an item
    final win = [for (var j = 0; j < math.min(3, n); j++) category.items[(page * 3 + j) % n]];
    Widget arrow(String t, int target) => SizedBox(
          width: 44,
          child: pages > 1 ? IconButton(onPressed: () => onPage(target), icon: Text(t, style: const TextStyle(fontSize: 28))) : null,
        );
    return Box(
      max: 980,
      pad: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        arrow('«', (page - 1 + pages) % pages),
        Expanded(
          child: mobile
              ? Column(children: [for (final it in win) HomeCard(it, onTapItem)])
              : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  for (final it in win) Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 5), child: HomeCard(it, onTapItem))),
                ]),
        ),
        arrow('»', (page + 1) % pages),
      ]),
    );
  }
}
