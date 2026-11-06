import 'package:flutter/material.dart';

import '../config/theme.dart';

class SbButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool ghost, small;
  const SbButton(this.label, this.onTap, {super.key, this.ghost = false, this.small = false});
  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: small ? 16 : 24, vertical: small ? 8 : 12),
          decoration: BoxDecoration(color: ghost ? Colors.transparent : C.green, border: Border.all(color: ghost ? Colors.white : C.green, width: 2)),
          child: Text(label, style: body(small ? 13 : 15, color: Colors.white, w: FontWeight.w800)),
        ),
      );
}
