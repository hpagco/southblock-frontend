import 'package:flutter/material.dart';

import '../config/theme.dart';
import '../models/item.dart';
import '../utils/helpers.dart';
import '../widgets/box.dart';
import '../widgets/marquee.dart';
import '../widgets/product_art.dart';
import '../widgets/sb_button.dart';
import '../widgets/wave_band.dart';

class CareersScreen extends StatefulWidget {
  const CareersScreen({super.key});
  @override
  State<CareersScreen> createState() => _CareersScreenState();
}

class _CareersScreenState extends State<CareersScreen> {
  int val = 0;
  static const ticker = '   GROWTH OPPORTUNITIES  ★  COMPETITIVE WAGES + TIPS  ★  FREE SHIFT MEALS  ★  FRIENDLY, POSITIVE & INCLUSIVE WORK ENVIRONMENT  ★  COMMUNITY IMPACT  ★';
  static const values = ['BELIEVE in YOURSELF', 'Spread GOOD VIBES', 'Small Acts have BIG IMPACTS', 'We are ONE BLOCK'];

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    final join = SbButton('Join Our Team', () => soon(context, 'Application form opens here (placeholder)'), small: true);
    final cups = Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      for (final i in [Item('Warrior Bowl', '', Kind.bowl, Color(0xFF5B2A73), Color(0xFFD6334F)), Item('Green Bowl', '', Kind.bowl, Color(0xFF7FB9CC), Color(0xFFD6334F)), Item('Magic Dragon Bowl', '', Kind.bowl, Color(0xFFB02A6A), Color(0xFFFFC83D))]) SizedBox(width: mobile ? 90 : 140, height: mobile ? 90 : 140, child: ProductArt(i)),
    ]);
    final good = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Good Vibes + Great Pay', style: slab(32, w: FontWeight.w700)),
      Transform.rotate(angle: -.06, child: Text('YOU DESERVE BOTH', style: script(24, C.yellow))),
      const SizedBox(height: 10),
      Text(
        'We are always looking for amazing people like you to join our team. Simply bring those good vibes and we will show you the rest. We value team players, work ethic, solutions-minded people and positive attitudes. If you have those qualities, you will have opportunities to grow at South Block!',
        style: body(12),
      ),
      const SizedBox(height: 8),
      Text('Questions? Email us at careers@example.com', style: body(12)),
      const SizedBox(height: 12),
      join,
    ]);
    return Column(children: [
      Container(
        height: 230,
        width: double.infinity,
        decoration: BoxDecoration(gradient: LinearGradient(colors: [const Color(0xFF1F8A3F), const Color(0xFF2AA04E).withOpacity(.9)])),
        child: Box(max: 340, child: Align(alignment: Alignment.centerLeft, child: Text('LIFE IS\nBETTER\nON THE\nBLOCK', style: slab(34, color: Colors.white, w: FontWeight.w900, h: .98)))),
      ),
      const SizedBox(height: 50),
      Box(max: 860, child: mobile ? Column(children: [good, const SizedBox(height: 20), cups]) : Row(children: [Expanded(flex: 4, child: good), const SizedBox(width: 20), Expanded(flex: 6, child: cups)])),
      const SizedBox(height: 30),
      const Marquee(ticker),
      Box(
        max: 380,
        child: Padding(
          padding: const EdgeInsets.only(top: 56),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Full Time\nPerks', style: slab(32, w: FontWeight.w700)),
            Text('FOR ELIGIBLE TEAM MEMBERS', style: body(13, w: FontWeight.w400)),
            const SizedBox(height: 14),
            Wrap(spacing: 22, runSpacing: 6, children: [
              for (final p in ['Health', 'Vision', 'Competitive Salary', 'Unlimited Flexible PTO', 'Dental', 'Free Meals', 'Good Vibes', 'Phone/Internet Stipend'])
                Text('★ ${p.toUpperCase()}', style: body(10.5, w: FontWeight.w800)),
            ]),
          ]),
        ),
      ),
      WaveBand(
        color: const Color(0xFF1A1A1A),
        child: Box(
          max: 560,
          pad: EdgeInsets.zero,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('MAKE\nAN IMPACT', style: script(30, C.teal)),
            const SizedBox(height: 8),
            Text('Our mission is to make people feel awesome one block at a time by spreading good vibes and fresh food.', style: body(14, color: Colors.white, w: FontWeight.w700)),
            const SizedBox(height: 8),
            Text(
              'At South Block, we believe in the power of small acts to create big changes. While we might look like an awesome acai shop on the surface (we definitely are), our true mission goes far beyond smoothies and bowls. When working at a South Block, you truly will be helping to make a difference… one block at a time!',
              style: body(12, color: Colors.white),
            ),
            const SizedBox(height: 12),
            join,
          ]),
        ),
      ),
      Box(
        max: 640,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Wrap(spacing: 24, runSpacing: 20, crossAxisAlignment: WrapCrossAlignment.center, children: [
            SizedBox(
              width: 260,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('OUR\nVALUES', style: script(28, C.green)),
                const SizedBox(height: 10),
                for (var i = 0; i < values.length; i++)
                  InkWell(
                    onTap: () => setState(() => val = i),
                    child: Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: Text(values[i], style: slab(19, color: i == val ? (i == 0 ? C.green : C.ink) : const Color(0xFFBBBBBB), w: FontWeight.w800))),
                  ),
              ]),
            ),
            Container(
              width: 240,
              color: Colors.white,
              child: Column(children: [
                Container(height: 200, color: const Color(0xFFB9D3E8), alignment: Alignment.center, child: const Text('🏃', style: TextStyle(fontSize: 60))),
                Padding(padding: const EdgeInsets.all(8), child: Text('It starts with you. BE YOU! Believe in your own unique abilities!', style: body(10))),
                join,
                const SizedBox(height: 8),
              ]),
            ),
          ]),
        ),
      ),
      const SizedBox(height: 40),
    ]);
  }
}
