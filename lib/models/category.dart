import 'package:flutter/material.dart';

import 'item.dart';

class Cat {
  final String id, label, intro;
  final Color color;
  final bool divider, darkText;
  final List<Item> items;
  const Cat(this.id, this.label, this.color, this.items, {this.intro = '', this.divider = false, this.darkText = false});
}

class HomeCat {
  final String label, link;
  final Item icon;
  final List<Item> items;
  const HomeCat(this.label, this.icon, this.items, this.link);
}
