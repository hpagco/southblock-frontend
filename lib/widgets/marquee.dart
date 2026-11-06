import 'dart:async';

import 'package:flutter/material.dart';

import '../config/theme.dart';

class Marquee extends StatefulWidget {
  final String text;
  const Marquee(this.text, {super.key});
  @override
  State<Marquee> createState() => _MarqueeState();
}

class _MarqueeState extends State<Marquee> {
  final sc = ScrollController();
  Timer? t;
  @override
  void initState() {
    super.initState();
    t = Timer.periodic(const Duration(milliseconds: 30), (_) {
      if (!sc.hasClients) return;
      final max = sc.position.maxScrollExtent;
      if (max <= 0) return;
      final next = sc.offset + 1.2;
      sc.jumpTo(next >= max ? 0 : next);
    });
  }

  @override
  void dispose() {
    t?.cancel();
    sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        color: C.pink,
        height: 26,
        child: SingleChildScrollView(
          controller: sc,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: Center(child: Text(widget.text * 4, maxLines: 1, style: body(11, color: Colors.white, w: FontWeight.w800))),
        ),
      );
}
