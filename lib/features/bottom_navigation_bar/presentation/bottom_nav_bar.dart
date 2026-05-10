// bottom_nav_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'nav_provider.dart';

// Feature Screen Imports
import 'package:lisan_portfolio/features/about/screen/about_screen.dart';
import 'package:lisan_portfolio/features/contract/screen/contents_screen.dart';
import 'package:lisan_portfolio/features/home/screen/home_screen.dart';
import 'package:lisan_portfolio/features/work/screen/work_screen.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    return Scaffold(
      // Required: lets page content bleed behind the glass bar
      extendBody: true,
      backgroundColor: const Color(0xFF0A0A0F),

      // ── iOS 26 Liquid Glass Bottom Bar ─────────────────────────────────────
      // GlassBottomBar uses the real shader pipeline on Impeller (iOS/Android),
      // and a lightweight CanvasKit shader on Web — no configuration needed.
      bottomNavigationBar: Align(
        alignment: Alignment.bottomCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 800,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: GlassBottomBar(
              selectedIndex: selectedIndex,
              onTabSelected: (index) =>
              ref.read(selectedIndexProvider.notifier).state = index,

              // Premium quality = full two-pass Gaussian blur + chromatic aberration.
              // Perfect for a static bottom bar surface.
              quality: GlassQuality.premium,

              tabs: const [
                GlassBottomBarTab(
                  label: 'Home',
                  icon: Icon(Icons.home_rounded),
                ),
                GlassBottomBarTab(
                  label: 'Work',
                  icon: Icon(Icons.work_rounded),
                ),
                GlassBottomBarTab(
                  label: 'About',
                  icon: Icon(Icons.person_rounded),
                ),
                GlassBottomBarTab(
                  label: 'Contact',
                  icon: Icon(Icons.mail_rounded),
                ),
              ],
            ),
          ),
        ),
      ),

      // ── Page Content ────────────────────────────────────────────────────────
      // GlassBackdropScope isolates the backdrop capture per screen,
      // preventing ghost artifacts when navigating between routes.
      body: GlassBackdropScope(
        child: IndexedStack(
          index: selectedIndex,
          children: const [
            HomeScreen(),
            WorkScreen(),
            AboutScreen(),
            ContentsScreen(),
          ],
        ),
      ),
    );
  }
}