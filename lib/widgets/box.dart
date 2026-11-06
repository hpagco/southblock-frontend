import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  final Widget child;
  final double max;
  final EdgeInsets pad;
  const Box({super.key, required this.child, this.max = 1000, this.pad = const EdgeInsets.symmetric(horizontal: 24)});
  @override
  Widget build(BuildContext context) => Center(child: ConstrainedBox(constraints: BoxConstraints(maxWidth: max), child: Padding(padding: pad, child: child)));
}
