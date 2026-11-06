import 'package:flutter/material.dart';

import '../config/theme.dart';

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size s) {
    final w = s.width, h = s.height;
    return Path()
      ..moveTo(0, h * .12)
      ..lineTo(w * .10, h * .09)
      ..lineTo(w * .25, h * .06)
      ..lineTo(w * .40, h * .10)
      ..lineTo(w * .55, h * .04)
      ..lineTo(w * .75, h * .08)
      ..lineTo(w, h * .06)
      ..lineTo(w, h * .92)
      ..lineTo(w * .80, h * .96)
      ..lineTo(w * .60, h)
      ..lineTo(w * .35, h * .94)
      ..lineTo(w * .15, h * .98)
      ..lineTo(0, h * .92)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> o) => false;
}

class WaveBand extends StatelessWidget {
  final Color color;
  final Widget child;
  const WaveBand({super.key, this.color = C.forest, required this.child});
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1140),
            child: ClipPath(
              clipper: WaveClipper(),
              child: Container(color: color, padding: const EdgeInsets.fromLTRB(24, 90, 24, 70), child: child),
            ),
          ),
        ),
      );
}
