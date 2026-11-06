import 'package:flutter/material.dart';

import '../config/routes.dart';
import '../config/theme.dart';
import '../utils/helpers.dart';
import 'sb_button.dart';

class NavBar extends StatelessWidget {
  final Pg pg;
  final NavFn go;
  final VoidCallback onMenu;
  const NavBar({super.key, required this.pg, required this.go, required this.onMenu});

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    Widget link(String t, Pg p) => Padding(
          padding: const EdgeInsets.only(right: 20),
          child: InkWell(onTap: () => go(p), child: Text(t, style: body(15, color: pg == p ? C.green : Colors.white, w: FontWeight.w700))),
        );
    return Material(
      color: C.nav,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: mobile ? 14 : 28),
          child: Row(children: [
            InkWell(
              onTap: () => go(Pg.home),
              child: Row(children: [
                const Icon(Icons.change_history, color: Colors.white, size: 28),
                const SizedBox(width: 8),
                Text('SOUTH\nBLOCK', style: slab(15, color: Colors.white, w: FontWeight.w900, h: .95)),
              ]),
            ),
            const SizedBox(width: 24),
            if (!mobile) ...[link('Menu', Pg.menu), link('About Us', Pg.about), link('Rewards', Pg.rewards), link('Careers', Pg.careers)],
            const Spacer(),
            if (!mobile) ...[
              InkWell(
                onTap: () => go(Pg.locations),
                child: Row(children: [
                  const Icon(Icons.location_on, color: Colors.white, size: 18),
                  const SizedBox(width: 4),
                  Text('Find Your Block', style: body(15, color: Colors.white, w: FontWeight.w700)),
                ]),
              ),
              const SizedBox(width: 16),
              SbButton('ORDER', () => go(Pg.menu), small: true),
            ] else
              IconButton(onPressed: onMenu, icon: const Icon(Icons.menu, color: Colors.white)),
          ]),
        ),
      ),
    );
  }
}
