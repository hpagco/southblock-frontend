import 'package:flutter/material.dart';

import '../config/routes.dart';
import '../config/theme.dart';
import '../utils/helpers.dart';
import '../widgets/nav_bar.dart';
import '../widgets/site_footer.dart';
import 'careers_screen.dart';
import 'home_screen.dart';
import 'menu_screen.dart';
import 'rewards_screen.dart';
import 'stub_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  Pg pg = Pg.home;
  String cat = 'featured';
  final sc = ScrollController();
  final key = GlobalKey<ScaffoldState>();

  void go(Pg p, {String? cat}) {
    key.currentState?.closeEndDrawer();
    setState(() {
      pg = p;
      if (cat != null) this.cat = cat;
    });
    if (sc.hasClients) sc.jumpTo(0);
  }

  @override
  void dispose() {
    sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    final Widget page = switch (pg) {
      Pg.home => HomeScreen(go: go),
      Pg.menu => MenuScreen(cat: cat, onCat: (id) => setState(() => cat = id)),
      Pg.rewards => const RewardsScreen(),
      Pg.careers => const CareersScreen(),
      Pg.about => StubScreen('About Us', go: go),
      Pg.locations => StubScreen('Find Your Block', go: go),
    };
    return Scaffold(
      key: key,
      appBar: PreferredSize(preferredSize: const Size.fromHeight(64), child: NavBar(pg: pg, go: go, onMenu: () => key.currentState?.openEndDrawer())),
      endDrawer: mobile
          ? Drawer(
              backgroundColor: C.nav,
              child: SafeArea(
                child: ListView(children: [
                  for (final e in {'Menu': Pg.menu, 'About Us': Pg.about, 'Rewards': Pg.rewards, 'Careers': Pg.careers, 'Find Your Block': Pg.locations}.entries)
                    ListTile(title: Text(e.key, style: body(16, color: Colors.white, w: FontWeight.w700)), onTap: () => go(e.value)),
                ]),
              ),
            )
          : null,
      body: SingleChildScrollView(controller: sc, child: Column(children: [page, SiteFooter(go: go)])),
    );
  }
}
