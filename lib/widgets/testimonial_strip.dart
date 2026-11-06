import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../config/theme.dart';
import '../services/menu_repository.dart';

class TestimonialStrip extends StatefulWidget {
  const TestimonialStrip({super.key});
  @override
  State<TestimonialStrip> createState() => _TestimonialStripState();
}

class _TestimonialStripState extends State<TestimonialStrip> {
  final sc = ScrollController();
  @override
  void dispose() {
    sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: SizedBox(
          height: 120,
          child: Stack(children: [
            ListView.separated(
              controller: sc,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: MenuRepository.instance.testimonials.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, i) => Container(
                width: 220,
                color: C.green,
                padding: const EdgeInsets.all(14),
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('★ ★ ★ ★ ★', style: body(10, color: Colors.white)),
                  const SizedBox(height: 6),
                  Text(MenuRepository.instance.testimonials[i].text, textAlign: TextAlign.center, maxLines: 3, overflow: TextOverflow.ellipsis, style: body(10.5, color: Colors.white, w: FontWeight.w600, h: 1.25)),
                  const SizedBox(height: 4),
                  Text(MenuRepository.instance.testimonials[i].author, style: body(8.5, color: Colors.white70)),
                ]),
              ),
            ),
            Positioned(
              right: 6,
              top: 36,
              child: IconButton.filled(
                style: IconButton.styleFrom(backgroundColor: Colors.white, foregroundColor: C.ink),
                onPressed: () => sc.animateTo(math.min(sc.offset + 400, sc.position.maxScrollExtent), duration: const Duration(milliseconds: 300), curve: Curves.easeOut),
                icon: const Text('»', style: TextStyle(fontSize: 20)),
              ),
            ),
          ]),
        ),
      );
}
