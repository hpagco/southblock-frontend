import 'package:flutter/material.dart';

import '../config/theme.dart';
import '../models/category.dart';
import '../utils/helpers.dart';
import 'sb_button.dart';

/// Left-hand category list on the Menu page (a wrapped row on phones).
class CategorySidebar extends StatelessWidget {
  final List<Cat> categories;
  final String selectedId;
  final ValueChanged<String> onSelect;
  final bool compact;
  const CategorySidebar({super.key, required this.categories, required this.selectedId, required this.onSelect, required this.compact});

  Widget _button(Cat c) {
    final on = c.id == selectedId;
    return InkWell(
      onTap: () => onSelect(c.id),
      child: Container(
        width: compact ? null : 150,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        color: on ? c.color : Colors.transparent,
        child: Text(c.label, style: body(13, color: on ? (c.darkText ? C.ink : Colors.white) : C.ink, w: FontWeight.w700)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (compact) return Wrap(spacing: 6, runSpacing: 6, children: [for (final c in categories) _button(c)]);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      for (final c in categories) ...[
        if (c.divider) const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: SizedBox(width: 150, child: Divider(height: 1))),
        _button(c),
      ],
      const SizedBox(height: 12),
      SbButton('Order Now', () => soon(context, 'Online ordering opens here (placeholder)'), small: true),
    ]);
  }
}
