import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/system_designs/responsive.dart';
import 'home/home_desktop.dart';
import 'home/home_mobile.dart';
import 'home/home_tablet.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: Responsive(
        mobile: HomeMobile(),
        tablet: HomeTablet(),
        desktop: HomeDesktop(),
      ),
    );
  }
}
