import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/item.dart';

class ArtPainter extends CustomPainter {
  final Item it;
  ArtPainter(this.it);

  Paint f(Color c, [double o = 1]) => Paint()..color = c.withOpacity(o);

  @override
  void paint(Canvas c, Size s) {
    final sc = math.min(s.width, s.height) / 100;
    if (sc <= 0 || sc.isInfinite) return;
    c.translate((s.width - 100 * sc) / 2, (s.height - 100 * sc) / 2);
    c.scale(sc);
    final a = it.a, b = it.b;
    final white = Colors.white;
    c.drawOval(Rect.fromCenter(center: const Offset(50, 93), width: 62, height: 7), f(Colors.black, .14));
    void logo(double cy) {
      c.drawCircle(Offset(50, cy), 9, Paint()..color = white.withOpacity(.75)..style = PaintingStyle.stroke..strokeWidth = 1.3);
      final v = Path()..moveTo(45, cy - 4)..lineTo(50, cy - 2.5)..lineTo(55, cy - 4)..lineTo(50, cy + 6)..close();
      c.drawPath(v, f(white, .75));
    }

    switch (it.kind) {
      case Kind.bowl:
      case Kind.mini:
        final y = it.kind == Kind.bowl ? 40.0 : 52.0;
        final body = Path()..moveTo(12, y + 6)..lineTo(88, y + 6)..lineTo(78, 90)..quadraticBezierTo(50, 96, 22, 90)..close();
        c.drawPath(body, f(a));
        c.drawOval(Rect.fromCenter(center: Offset(50, y + 6), width: 78, height: 14), f(a));
        c.drawOval(Rect.fromLTWH(14, y - 14, 72, 30), f(b));
        c.drawCircle(Offset(34, y - 4), 6, f(const Color(0xFFFFF6DD)));
        c.drawCircle(Offset(52, y - 9), 6, f(const Color(0xFFD6334F)));
        c.drawCircle(Offset(68, y - 3), 5, f(const Color(0xFF2E3B94)));
        logo(y + 28);
        break;
      case Kind.cup:
        c.drawLine(const Offset(60, 6), const Offset(63, 38), Paint()..color = const Color(0xFF18C58A)..strokeWidth = 5..strokeCap = StrokeCap.round);
        final cup = Path()..moveTo(28, 36)..lineTo(72, 36)..lineTo(65, 92)..quadraticBezierTo(50, 96, 35, 92)..close();
        c.drawPath(cup, f(a));
        c.drawOval(Rect.fromCenter(center: const Offset(50, 36), width: 44, height: 8), f(white, .5));
        logo(66);
        break;
      case Kind.toast:
        c.drawRRect(RRect.fromRectAndRadius(const Rect.fromLTWH(12, 18, 76, 68), const Radius.circular(24)), f(const Color(0xFFC98B4E)));
        c.drawRRect(RRect.fromRectAndRadius(const Rect.fromLTWH(19, 25, 62, 54), const Radius.circular(17)), f(a));
        for (final o in const [Offset(34, 42), Offset(56, 52), Offset(68, 38), Offset(44, 64), Offset(64, 66)]) {
          c.drawCircle(o, 5, f(b));
        }
        break;
      case Kind.juice:
        c.drawRect(const Rect.fromLTWH(40, 4, 20, 10), f(Colors.black));
        c.drawRRect(RRect.fromRectAndRadius(const Rect.fromLTWH(32, 14, 36, 80), const Radius.circular(8)), f(a));
        c.drawRect(const Rect.fromLTWH(32, 44, 36, 42), f(Colors.black, .85));
        break;
      case Kind.bottle:
        c.drawRect(const Rect.fromLTWH(43, 4, 14, 8), f(const Color(0xFF2A7FC9)));
        c.drawRRect(RRect.fromRectAndRadius(const Rect.fromLTWH(34, 12, 32, 82), const Radius.circular(10)), f(a, .85));
        c.drawRect(const Rect.fromLTWH(34, 44, 32, 22), f(white, .85));
        break;
      case Kind.can:
        c.drawRRect(RRect.fromRectAndRadius(const Rect.fromLTWH(30, 8, 40, 86), const Radius.circular(8)), f(a));
        c.drawRect(const Rect.fromLTWH(30, 8, 40, 10), f(white, .5));
        c.drawRect(const Rect.fromLTWH(30, 42, 40, 28), f(white, .85));
        break;
      case Kind.bag:
        final p = Path()..moveTo(22, 12)..quadraticBezierTo(50, 4, 78, 12)..lineTo(82, 90)..quadraticBezierTo(50, 96, 18, 90)..close();
        c.drawPath(p, f(a));
        c.drawRect(const Rect.fromLTWH(28, 30, 44, 42), f(white, .88));
        c.drawRect(const Rect.fromLTWH(28, 36, 44, 7), f(Colors.black, .7));
        break;
      case Kind.pot:
        c.drawRRect(RRect.fromRectAndRadius(const Rect.fromLTWH(8, 16, 84, 66), const Radius.circular(26)), f(const Color(0xFFEFE1C6)));
        c.drawRRect(RRect.fromRectAndRadius(const Rect.fromLTWH(15, 22, 70, 54), const Radius.circular(20)), f(a));
        for (final o in const [Offset(34, 42), Offset(56, 36), Offset(68, 56), Offset(44, 60)]) {
          c.drawCircle(o, 7, f(b));
        }
        break;
      case Kind.ibowl:
        const ctr = Offset(50, 50);
        c.drawCircle(ctr, 44, f(const Color(0xFFEFE1C6)));
        c.drawCircle(ctr, 36, f(a));
        c.drawArc(Rect.fromCircle(center: ctr, radius: 36), -math.pi / 2, math.pi / 2, true, f(b, .9));
        c.drawArc(Rect.fromCircle(center: ctr, radius: 36), math.pi * .55, math.pi * .55, true, f(const Color(0xFF6FAE3A), .85));
        c.drawCircle(const Offset(68, 68), 8, f(const Color(0xFFD6283A)));
        c.drawCircle(const Offset(38, 30), 5, f(white, .55));
        c.drawCircle(ctr, 6, f(const Color(0xFFEEF3EA)));
        break;
      case Kind.sauce:
        const ctr = Offset(50, 48);
        c.drawCircle(ctr, 36, f(const Color(0xFFF6F1E8)));
        c.drawCircle(ctr, 28, f(a));
        c.drawCircle(const Offset(40, 40), 6, f(white, .3));
        if (b.value != kDefaultAccent) {
          c.drawCircle(const Offset(58, 52), 7, f(b));
          c.drawCircle(const Offset(44, 58), 5, f(b));
        }
        break;
      case Kind.roti:
        c.drawOval(const Rect.fromLTWH(10, 24, 80, 56), f(a));
        for (final o in const [Offset(36, 46), Offset(62, 42), Offset(54, 62)]) {
          c.drawCircle(o, 4, f(const Color(0xFFB8843F)));
        }
        break;
      case Kind.wrap:
        c.save();
        c.rotate(-0.25);
        c.drawRRect(RRect.fromRectAndRadius(const Rect.fromLTWH(10, 44, 70, 32), const Radius.circular(16)), f(const Color(0xFFE2B66B)));
        c.drawRRect(RRect.fromRectAndRadius(const Rect.fromLTWH(30, 28, 70, 34), const Radius.circular(17)), f(const Color(0xFFECC27C)));
        c.drawOval(const Rect.fromLTWH(86, 26, 14, 34), f(a));
        c.drawCircle(const Offset(92, 36), 4, f(b));
        c.drawCircle(const Offset(93, 49), 3.5, f(const Color(0xFFD63A4A)));
        c.restore();
        break;
      case Kind.hot:
        final cup = Path()..moveTo(26, 36)..lineTo(74, 36)..lineTo(69, 90)..quadraticBezierTo(50, 95, 31, 90)..close();
        c.drawPath(cup, f(const Color(0xFF3A3A3A)));
        c.drawRRect(RRect.fromRectAndRadius(const Rect.fromLTWH(22, 28, 56, 10), const Radius.circular(4)), f(const Color(0xFF555555)));
        c.drawOval(Rect.fromCenter(center: const Offset(50, 27), width: 46, height: 8), f(a));
        logo(64);
        break;
      case Kind.cookie:
        c.drawCircle(const Offset(50, 50), 36, f(a));
        for (final o in const [Offset(36, 40), Offset(60, 36), Offset(64, 58), Offset(40, 62), Offset(52, 48)]) {
          c.drawCircle(o, 5.5, f(b));
        }
        break;
      case Kind.bar:
        c.drawRRect(RRect.fromRectAndRadius(const Rect.fromLTWH(24, 8, 52, 84), const Radius.circular(6)), f(a));
        c.drawRect(const Rect.fromLTWH(30, 36, 40, 30), f(white, .85));
        break;
      case Kind.crisps:
        final p = Path()..moveTo(22, 10)..lineTo(78, 6)..lineTo(82, 90)..lineTo(18, 94)..close();
        c.drawPath(p, f(a));
        c.drawRect(const Rect.fromLTWH(30, 38, 40, 32), f(white, .85));
        c.drawCircle(const Offset(50, 54), 9, f(a));
        break;
    }
  }

  @override
  bool shouldRepaint(ArtPainter o) => o.it != it;
}
