import 'package:flutter/material.dart';

import '../config/theme.dart';
import '../utils/helpers.dart';

class StoreBadges extends StatelessWidget {
  final WrapAlignment align;
  const StoreBadges({super.key, this.align = WrapAlignment.center});
  @override
  Widget build(BuildContext context) {
    Widget b(String top, String name, IconData i) => InkWell(
          onTap: () => soon(context, '$name link goes here (placeholder)'),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(6)),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(i, color: Colors.white, size: 18),
              const SizedBox(width: 8),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(top, style: body(8, color: Colors.white)),
                Text(name, style: body(14, color: Colors.white, w: FontWeight.w600, h: 1)),
              ]),
            ]),
          ),
        );
    return Wrap(spacing: 8, runSpacing: 8, alignment: align, children: [
      b('Get it on the', 'App Store', Icons.apple),
      b('Get it on', 'Google Play', Icons.play_arrow),
    ]);
  }
}
