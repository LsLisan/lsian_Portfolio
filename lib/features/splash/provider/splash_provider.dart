import 'package:flutter_riverpod/legacy.dart';
import 'package:lisan_portfolio/core/services/auth_service.dart';

enum AppStartupState {loading, authenticated, unauthenticated}

class AppStartupNotifier extends StateNotifier<AppStartupState>{
  AppStartupNotifier(): super(AppStartupState.loading){
    _init();
  }

  final minimumWait = Future.delayed(const Duration(seconds: 2));
  Future<void> _init() async{
    await AuthService.init();
    await minimumWait;

    if (AuthService.hasToken()) {
      state = AppStartupState.authenticated;
    } else {
      state = AppStartupState.authenticated;
    }
  }

}

final splashProvider = StateNotifierProvider <AppStartupNotifier,AppStartupState>((ref){
  return AppStartupNotifier();
});