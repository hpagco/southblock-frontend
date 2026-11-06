import 'package:flutter/material.dart';

import '../config/theme.dart';
import '../utils/helpers.dart';
import 'box.dart';
import 'sb_button.dart';

class CateringBlock extends StatelessWidget {
  const CateringBlock({super.key});
  @override
  Widget build(BuildContext context) => Box(
        max: 640,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Wrap(spacing: 22, runSpacing: 14, crossAxisAlignment: WrapCrossAlignment.center, children: [
            SizedBox(
              width: 260,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('CATERING', style: script(26, C.yellow)),
                Text('Good Vibes,\nDelivered', style: slab(34, w: FontWeight.w700)),
                const SizedBox(height: 10),
                SbButton('Order Now', () => soon(context, 'Catering order opens here (placeholder)'), small: true),
              ]),
            ),
            SizedBox(
              width: 300,
              child: Text(
                'Whether it is an office lunch or a family gathering, our catering packages bring the party to you with convenient pickup or delivery.\n\nMake it wow with our one-of-a-kind build-your-own acai bar.',
                style: body(12, color: C.soft),
              ),
            ),
          ]),
        ),
      );
}
