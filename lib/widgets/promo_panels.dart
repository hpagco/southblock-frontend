import 'package:flutter/material.dart';

import '../config/routes.dart';
import '../config/theme.dart';
import '../utils/helpers.dart';
import 'box.dart';
import 'sb_button.dart';
import 'store_badges.dart';

class PromoPanels extends StatelessWidget {
  final NavFn go;
  const PromoPanels({super.key, required this.go});
  @override
  Widget build(BuildContext context) {
    final cater = Container(
      height: 350,
      alignment: Alignment.center,
      decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF4A2A2A), Color(0xFF8C4A2F), Color(0xFFE8D5B0)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      child: Container(
        color: Colors.white.withOpacity(.92),
        padding: const EdgeInsets.all(26),
        margin: const EdgeInsets.all(30),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text('SOUTH BLOCK', style: slab(20, w: FontWeight.w900)),
          Text('Catering', style: slab(44)),
          const SizedBox(height: 8),
          Text('Win your next event with smoothies and acai bowls for groups from 10 to 1000', textAlign: TextAlign.center, style: body(13)),
          const SizedBox(height: 14),
          SbButton('Order Catering', () => soon(context, 'Catering order opens here (placeholder)')),
        ]),
      ),
    );
    final off = Container(
      height: 350,
      color: C.berry,
      alignment: Alignment.center,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text('Get \$5 Off', style: body(52, color: Colors.white, w: FontWeight.w800)),
        Text('YOUR FIRST APP ORDER', style: body(13, color: Colors.white)),
        const SizedBox(height: 14),
        const StoreBadges(),
        const SizedBox(height: 14),
        SbButton('Join Now', () => go(Pg.rewards)),
      ]),
    );
    return Box(
      max: 880,
      pad: const EdgeInsets.symmetric(horizontal: 16),
      child: isMobile(context) ? Column(children: [cater, const SizedBox(height: 14), off]) : Row(children: [Expanded(child: cater), const SizedBox(width: 14), Expanded(child: off)]),
    );
  }
}
