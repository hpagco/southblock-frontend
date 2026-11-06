import 'package:flutter/material.dart';

import '../config/routes.dart';
import '../config/theme.dart';
import '../widgets/sb_button.dart';

class StubScreen extends StatelessWidget {
  final String title;
  final NavFn go;
  const StubScreen(this.title, {super.key, required this.go});
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 90, horizontal: 24),
        child: Column(children: [
          Text(title, style: slab(38, w: FontWeight.w700)),
          const SizedBox(height: 12),
          Text('Screenshots for this page have not been shared yet.', style: body(15, color: C.soft)),
          const SizedBox(height: 20),
          SbButton('Back to home', () => go(Pg.home)),
        ]),
      );
}
