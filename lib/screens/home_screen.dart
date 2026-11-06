import 'package:flutter/material.dart';

import '../config/routes.dart';
import '../config/theme.dart';
import '../services/menu_repository.dart';
import '../widgets/category_chips.dart';
import '../widgets/home_hero.dart';
import '../widgets/item_carousel.dart';
import '../widgets/promo_panels.dart';
import '../widgets/protein_banner.dart';
import '../widgets/rewards_strip.dart';

class HomeScreen extends StatefulWidget {
  final NavFn go;
  const HomeScreen({super.key, required this.go});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final repo = MenuRepository.instance;
  int cat = 0, page = 0;

  @override
  Widget build(BuildContext context) {
    final hc = repo.homeCategories[cat];
    return Column(children: [
      HomeHero(onOrder: () => widget.go(Pg.menu)),
      const SizedBox(height: 28),
      ProteinBanner(go: widget.go, big: false),
      const SizedBox(height: 46),
      CategoryChips(
        categories: repo.homeCategories,
        selected: cat,
        onSelect: (i) => setState(() {
          cat = i;
          page = 0;
        }),
      ),
      const SizedBox(height: 16),
      ItemCarousel(category: hc, page: page, onPage: (p) => setState(() => page = p), onTapItem: () => widget.go(Pg.menu, cat: hc.link)),
      const SizedBox(height: 28),
      InkWell(onTap: () => widget.go(Pg.menu, cat: hc.link), child: Text('View Full Menu »', style: body(20, color: C.berry, w: FontWeight.w400))),
      const SizedBox(height: 56),
      RewardsStrip(go: widget.go),
      const SizedBox(height: 64),
      PromoPanels(go: widget.go),
      const SizedBox(height: 64),
    ]);
  }
}
