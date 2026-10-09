import 'package:flutter/material.dart';

import '../core/theme/aty_theme.dart';
import 'router/app_router.dart';

class AtyApp extends StatelessWidget {
  const AtyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ATY — Comunidade Fatec',
      debugShowCheckedModeBanner: false,
      theme: AtyTheme.light(),
      darkTheme: AtyTheme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
