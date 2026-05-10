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
  // Watch the startup state to trigger the redirect logic automatically
  final startupState = ref.watch(splashProvider);

  return GoRouter(
    initialLocation: splashScreen,
    redirect: (context, state) {
      final location = state.matchedLocation;

      // While the timer/assets are loading, stay on Splash
      if (startupState == AppStartupState.loading) {
        return splashScreen;
      }

      // Once loading is 'completed', decide where to go
      if (location == splashScreen && startupState == AppStartupState.completed) {
        /* Since there is no authentication, we choose a default
           landing page (Onboarding or BottomNavBar).
        */
        return onboarding;
      }

      /* Unused Auth Logic
      if (location == splashScreen) {
        if (startupState == AppStartupState.authenticated) {
          return bottomNavBar;
        } else {
          return onboarding;
        }
      }
      */

      return null;
    },
    routes: [
      GoRoute(
        path: splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: bottomNavBar,
        builder: (context, state) => const BottomNavBar(),
      ),
      GoRoute(
        path: onboarding,
        builder: (context, state) => const OnBoardingScreen(),
      ),
    ],
  );
});