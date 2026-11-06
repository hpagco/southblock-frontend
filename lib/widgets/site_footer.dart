import 'package:flutter/material.dart';

import '../config/routes.dart';
import '../config/theme.dart';
import '../utils/helpers.dart';
import 'box.dart';

class SiteFooter extends StatelessWidget {
  final NavFn go;
  const SiteFooter({super.key, required this.go});
  @override
  Widget build(BuildContext context) {
    Widget col(String h, List<(String, VoidCallback)> links) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(h.toUpperCase(), style: body(12, color: Colors.white, w: FontWeight.w800)),
          const SizedBox(height: 6),
          for (final l in links) InkWell(onTap: l.$2, child: Padding(padding: const EdgeInsets.symmetric(vertical: 2), child: Text(l.$1, style: body(13, color: const Color(0xFFEEEEEE))))),
        ]);
    void todo(String m) => soon(context, '$m (placeholder)');
    Widget soc(String t) => Container(width: 28, height: 28, margin: const EdgeInsets.only(bottom: 8), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), alignment: Alignment.center, child: Text(t, style: body(11, w: FontWeight.w800)));
    return Container(
      color: const Color(0xFF0B0B0B),
      width: double.infinity,
      padding: const EdgeInsets.only(top: 56),
      child: Column(children: [
        Box(
          max: 760,
          child: Wrap(spacing: 28, runSpacing: 24, children: [
            const Icon(Icons.change_history, color: C.green, size: 44),
            Column(children: [soc('ig'), soc('tt'), soc('f')]),
            col('Information', [('Join Rewards', () => go(Pg.rewards)), ('Our Mission', () => go(Pg.about)), ('Contact Us', () => todo('Contact page')), ('FAQs', () => todo('FAQ page'))]),
            col('Helpful Links', [('View Menu', () => go(Pg.menu)), ('Gift Cards', () => todo('Gift cards')), ('Order Catering', () => todo('Catering')), ('Locations', () => go(Pg.locations)), ('Careers', () => go(Pg.careers))]),
            col('Learn More', [('Events + Fundraising', () => todo('Events')), ('Fruitful Planet', () => todo('Fruitful Planet')), ('Press + Awards', () => todo('Press')), ('Nutrition', () => todo('Nutrition'))]),
          ]),
        ),
        const SizedBox(height: 18),
        Box(
          max: 760,
          child: Container(
            padding: const EdgeInsets.only(top: 10),
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.white))),
            child: Text('©2026 BY SOUTH BLOCK\nACAI BOWLS | SMOOTHIES | JUICE', style: body(10, color: Colors.white)),
          ),
        ),
        const SizedBox(height: 28),
        // Giant cropped wordmark that always fits the screen width
        ClipRect(
          child: Align(
            alignment: Alignment.topCenter,
            heightFactor: .58,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: FittedBox(fit: BoxFit.fitWidth, child: Text('SOUTH BLOCK', style: TextStyle(fontFamily: kSlab, fontWeight: FontWeight.w900, color: C.green, fontSize: 200, height: 1))),
            ),
          ),
        ),
      ]),
    );
  }
}
