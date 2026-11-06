import 'package:flutter/material.dart';

import 'config/theme.dart';
import 'screens/app_shell.dart';

class SouthBlockApp extends StatelessWidget {
  const SouthBlockApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'South Block',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: C.bg,
          colorScheme: ColorScheme.fromSeed(seedColor: C.green),
        ),
        home: const AppShell(),
      );
}
