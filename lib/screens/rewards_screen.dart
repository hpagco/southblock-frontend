import 'package:flutter/material.dart';

import '../config/theme.dart';
import '../models/item.dart';
import '../services/menu_repository.dart';
import '../widgets/box.dart';
import '../widgets/food_image.dart';
import '../widgets/phone_mock.dart';
import '../widgets/product_art.dart';
import '../widgets/store_badges.dart';
import '../widgets/wave_band.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Widget step(String label, Color c, String title, List<Widget> kids) => Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label, style: script(24, c)),
            Text(title, style: slab(32, w: FontWeight.w700)),
            const SizedBox(height: 10),
            ...kids,
          ]),
        );
    Widget perk(String t, Item i) => Expanded(
          child: Column(children: [
            Text(t.toUpperCase(), textAlign: TextAlign.center, style: body(12, w: FontWeight.w700, h: 1.1)),
            const SizedBox(height: 6),
            Container(color: const Color(0xFFEEEEEE), height: 90, padding: const EdgeInsets.all(8), child: ProductArt(i)),
          ]),
        );
    Widget bonus(String t, Item i) => Expanded(
          child: Container(
            color: C.pink,
            height: 124,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.fromLTRB(6, 12, 6, 0),
            child: Column(children: [
              Text(t, textAlign: TextAlign.center, style: body(11, color: Colors.white, w: FontWeight.w800, h: 1.15)),
              const Spacer(),
              Container(width: 48, height: 48, decoration: const BoxDecoration(color: Color(0xFFEEEEEE), shape: BoxShape.circle), padding: const EdgeInsets.all(6), child: ProductArt(i)),
              const SizedBox(height: 6),
            ]),
          ),
        );
    return Column(children: [
      SizedBox(
        height: 200,
        width: double.infinity,
        child: Stack(fit: StackFit.expand, children: [
          const FoodImage('hero rewards', height: 200, radius: 0, bg: Color(0xFF5A3A4A)),
          Container(color: Colors.black.withOpacity(.4)),
          Align(alignment: Alignment.centerLeft, child: Box(max: 340, child: Text('JOIN SOUTH BLOCK\nREWARDS', style: slab(32, color: Colors.white, w: FontWeight.w700)))),
        ]),
      ),
      const SizedBox(height: 32),
      Box(
        max: 380,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          step('STEP ONE', C.berry, 'Download\nThe App', [
            Text('GET \$5 OFF YOUR FIRST APP ORDER!', style: body(12, w: FontWeight.w800)),
            Text('*With \$10 min spend before taxes, fees, & discounts', style: body(10, color: C.soft)),
            const SizedBox(height: 10),
            Container(color: C.nav, padding: const EdgeInsets.all(8), child: const StoreBadges(align: WrapAlignment.start)),
          ]),
          step('STEP TWO', C.green, 'Earn Stars', [
            Text('Earn 2 stars per \$1 spent', style: body(12)),
            const SizedBox(height: 10),
            Row(children: [
              for (final e in ['🛹', '☕', '🐕', '🥤'])
                Expanded(child: Container(margin: const EdgeInsets.only(right: 6), height: 70, alignment: Alignment.center, decoration: BoxDecoration(color: Colors.white, border: Border.all()), child: Text(e, style: const TextStyle(fontSize: 26)))),
            ]),
          ]),
          step('STEP THREE', C.teal, 'Roll with us\nand Earn\nPerks Like:', [
            Row(children: [perk('Free Acai Bowls', MenuRepository.instance.find('Warrior Bowl')), const SizedBox(width: 8), perk('Surprise Deals', MenuRepository.instance.find('Super Green Smoothie')), const SizedBox(width: 8), perk('\$5 Off Any Item', MenuRepository.instance.find('Reset Juice'))]),
          ]),
        ]),
      ),
      WaveBand(
        child: Box(
          max: 380,
          pad: EdgeInsets.zero,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Align(alignment: Alignment.centerRight, child: Text('Built in\nBonuses', textAlign: TextAlign.right, style: slab(32, color: Colors.white, w: FontWeight.w700))),
            const SizedBox(height: 14),
            Row(children: [
              bonus('Access to Exclusive Menu Items', MenuRepository.instance.find('Mango Mania Smoothie')),
              bonus('Free Birthday Smoothie', MenuRepository.instance.find('Strawberry Passion Smoothie')),
              bonus('Surprise Deals for Rewards Members Only', MenuRepository.instance.find('Nutella Bowl')),
            ]),
            const SizedBox(height: 40),
            Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('START', style: script(22, C.yellow)),
                  Text('Earning\nStars', style: slab(30, color: Colors.white, w: FontWeight.w700)),
                  const SizedBox(height: 10),
                  const StoreBadges(align: WrapAlignment.start),
                ]),
              ),
              const Phone(w: 90, h: 160),
            ]),
          ]),
        ),
      ),
      const SizedBox(height: 40),
    ]);
  }
}
