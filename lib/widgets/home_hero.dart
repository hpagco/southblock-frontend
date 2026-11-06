import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../config/theme.dart';
import '../utils/helpers.dart';
import 'food_image.dart';
import 'sb_button.dart';

/// Full-width hero with the rotating "Handcrafted ..." word.
class HomeHero extends StatefulWidget {
  final VoidCallback onOrder;
  const HomeHero({super.key, required this.onOrder});
  @override
  State<HomeHero> createState() => _HomeHeroState();
}

class _HomeHeroState extends State<HomeHero> {
  static const words = ['SMOOTHIES', 'ACAI BOWLS', 'JUICE'];
  int w = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 2400), (_) => setState(() => w = (w + 1) % words.length));
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    final h = mobile ? 360.0 : 480.0;
    const dark = Color(0xFF33541F);
    return SizedBox(
      height: h,
      width: double.infinity,
      child: Stack(fit: StackFit.expand, children: [
        FoodImage('hero home', height: h, radius: 0, bg: dark),
        Container(color: Colors.black.withOpacity(.38)), // keeps the white text readable
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: mobile ? 24 : math.max(24, (MediaQuery.of(context).size.width - 1000) / 2 + 24)),
            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('KEEPING\nIT REAL', style: slab(mobile ? 44 : 68, color: Colors.white, w: FontWeight.w900, h: .98)),
              const SizedBox(height: 12),
              Row(mainAxisSize: MainAxisSize.min, children: [
                Text('Handcrafted ', style: body(18, color: Colors.white, w: FontWeight.w700)),
                AnimatedSwitcher(duration: const Duration(milliseconds: 300), child: Text(words[w], key: ValueKey(w), style: slab(24, color: Colors.white))),
              ]),
              const SizedBox(height: 20),
              SbButton('Order Now', widget.onOrder, ghost: true),
            ]),
          ),
        ),
      ]),
    );
  }
}
