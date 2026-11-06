import 'package:flutter/material.dart';

// Brand colours and text styles.
// Step 9 polish: add google_fonts (Arvo, Alfa Slab One, Montserrat, Caveat Brush).
class C {
  static const nav = Color(0xFF231F20);
  static const green = Color(0xFF00A651);
  static const forest = Color(0xFF33541F);
  static const berry = Color(0xFF920047);
  static const pink = Color(0xFFEC4F9B);
  static const teal = Color(0xFF4BB8C8);
  static const yellow = Color(0xFFFCB827);
  static const blue = Color(0xFF1F5FA8);
  static const lilac = Color(0xFFB79BD6);
  static const bg = Color(0xFFF7F7F7);
  static const card = Color(0xFFFAFAF8);
  static const ink = Color(0xFF1A1A1A);
  static const soft = Color(0xFF4A4A4A);
}

// No google_fonts dependency in step 2: these fall back to system serif/sans.
// Step 9 polish: add google_fonts (Arvo, Alfa Slab One, Montserrat, Caveat Brush).
const String kSlab = 'Georgia';
TextStyle slab(double s, {Color color = C.ink, FontWeight w = FontWeight.w800, double h = 1.05}) =>
    TextStyle(fontFamily: kSlab, fontSize: s, fontWeight: w, color: color, height: h);
TextStyle body(double s, {Color color = C.ink, FontWeight w = FontWeight.w500, double h = 1.4}) =>
    TextStyle(fontSize: s, fontWeight: w, color: color, height: h);
TextStyle script(double s, Color color) =>
    TextStyle(fontFamily: 'Georgia', fontStyle: FontStyle.italic, fontWeight: FontWeight.w900, fontSize: s, color: color);
