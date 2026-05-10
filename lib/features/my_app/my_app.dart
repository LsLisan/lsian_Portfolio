import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/system_designs/app_theme.dart';
import '../../core/system_designs/provider/theme_provider.dart';
import '../routing/app_routing.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'Lisan Portfolio',
      debugShowCheckedModeBanner: false,
      // Theme Settings
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      // Router Settings
      routerConfig: router,
    );
  }
}