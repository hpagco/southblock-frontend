import 'package:flutter/material.dart';

import '../config/theme.dart';
import '../utils/helpers.dart';
import 'box.dart';
import 'phone_mock.dart';
import 'sb_button.dart';
import 'store_badges.dart';
import 'wave_band.dart';

/// Green wave band promoting the rewards app.
class RollWithUsBand extends StatelessWidget {
  const RollWithUsBand({super.key});
  @override
  Widget build(BuildContext context) => WaveBand(
        child: Box(
          max: 560,
          pad: EdgeInsets.zero,
          child: Wrap(spacing: 24, runSpacing: 16, alignment: WrapAlignment.center, crossAxisAlignment: WrapCrossAlignment.center, children: [
            const Phone(),
            SizedBox(
              width: 300,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('REWARDS', style: script(26, C.teal)),
                Text('Roll With Us', style: slab(34, color: Colors.white, w: FontWeight.w700)),
                const SizedBox(height: 6),
                Text('\$5 off your first mobile order when you sign up', style: body(12, color: Colors.white)),
                const SizedBox(height: 10),
                const StoreBadges(align: WrapAlignment.start),
                const SizedBox(height: 10),
                SbButton('Learn More', () => soon(context, 'Use the Rewards link in the nav'), small: true),
              ]),
            ),
          ]),
        ),
      );
}
