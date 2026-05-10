import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lisan_portfolio/features/on_boarding/presentation/screens/on_boarding_screen.dart';

import '../bottom_navigation_bar/presentation/bottom_nav_bar.dart';
import '../splash/presentation/screens/splash_screen.dart';
import '../splash/provider/splash_provider.dart';

const String splashScreen = "/splash";
const String bottomNavBar = '/nav';
const String onboarding = '/onBoarding';

final goRouterProvider = Provider<GoRouter>((ref) {
  final startupState = ref.watch(splashProvider);

  return GoRouter(
    initialLocation: splashScreen,
    redirect: (context, state) {
      final location = state.matchedLocation;

      // 1. If we are still loading, force the Splash screen
      if (startupState == AppStartupState.loading) {
        return splashScreen;
      }

      // 2. If loading is finished and we are STILL on splash, go to Onboarding
      if (location == splashScreen && startupState == AppStartupState.completed) {
        return onboarding;
      }

      // 3. In all other cases (like being on Onboarding or Nav), don't redirect
      return null;
    },
    routes: [
      GoRoute(
        path: splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: onboarding,
        builder: (context, state) => const OnBoardingScreen(),
      ),
      GoRoute(
        path: bottomNavBar,
        builder: (context, state) => const BottomNavBar(),
      ),
    ],
  );
});