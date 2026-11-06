import 'package:flutter/material.dart';

class Phone extends StatelessWidget {
  final double w, h;
  const Phone({super.key, this.w = 110, this.h = 190});
  @override
  Widget build(BuildContext context) => Transform.rotate(
        angle: -.14,
        child: Container(
          width: w,
          height: h,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFFF9A825), Color(0xFFFF8F00)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            border: Border.all(color: const Color(0xFF111111), width: 5),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      );
}
