import 'package:flutter/material.dart';

import '../config/app_config.dart';

import '../config/app_config.dart';

bool isMobile(BuildContext c) => MediaQuery.of(c).size.width < AppConfig.mobileBreakpoint;

void soon(BuildContext c, String m) =>
    ScaffoldMessenger.of(c).showSnackBar(SnackBar(content: Text(m), duration: const Duration(seconds: 2)));

/// "Goan Glazed Salmon" -> "goan-glazed-salmon". Must match tools/fetch_photos.py.
String slugify(String s) => s
    .toLowerCase()
    .replaceAll('&', 'and')
    .replaceAll('+', 'plus')
    .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
    .replaceAll(RegExp(r'^-+|-+$'), '');
