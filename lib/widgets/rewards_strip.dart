import 'package:flutter/material.dart';

import '../config/routes.dart';
import '../config/theme.dart';

class RewardsStrip extends StatelessWidget {
  final NavFn go;
  const RewardsStrip({super.key, required this.go});
  @override
  Widget build(BuildContext context) {
    Widget step(String n, String a, String b) => Row(mainAxisSize: MainAxisSize.min, children: [
          Text(n, style: TextStyle(fontFamily: kSlab, fontWeight: FontWeight.w900, fontSize: 52, foreground: Paint()..style = PaintingStyle.stroke..strokeWidth = 2..color = Colors.white)),
          const SizedBox(width: 6),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(a, style: slab(26, color: Colors.white, h: 1)),
            Text(b, style: body(14, color: C.green)),
          ]),
        ]);
    return Container(
      color: Colors.black,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 26, 16, 22),
      child: Column(children: [
        Text('JOIN SOUTH BLOCK REWARDS TO EARN FREE ACAI BOWLS, SMOOTHIES, & MORE!', textAlign: TextAlign.center, style: body(15, color: C.green, w: FontWeight.w800)),
        const SizedBox(height: 14),
        Wrap(spacing: 36, runSpacing: 14, alignment: WrapAlignment.center, crossAxisAlignment: WrapCrossAlignment.center, children: [
          step('1', 'Download', 'the App'),
          step('2', 'Earn', 'Stars'),
          step('3', 'Score', 'Big'),
          InkWell(onTap: () => go(Pg.rewards), child: Transform.rotate(angle: -.05, child: Text('JOIN NOW »', style: script(32, C.pink)))),
        ]),
      ]),
    );
  }
}
