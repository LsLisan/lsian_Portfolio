import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:lisan_portfolio/core/services/auth_service.dart'; // Unused: No auth in project

enum AppStartupState { loading, completed } // Simplified states

class AppStartupNotifier extends Notifier<AppStartupState> {
  @override
  AppStartupState build() {
    _init();
    return AppStartupState.loading;
  }

  Future<void> _init() async {
    // Artificial delay for splash screen branding
    await Future.delayed(const Duration(seconds: 2));

    /* // Unused: No authentication logic required for this project
    await AuthService.init();
    if (AuthService.hasToken()) {
      state = AppStartupState.authenticated;
    } else {
      state = AppStartupState.unauthenticated;
    }
    */

    state = AppStartupState.completed;
  }
}

// Modern NotifierProvider syntax
final splashProvider = NotifierProvider<AppStartupNotifier, AppStartupState>(() {
  return AppStartupNotifier();
});