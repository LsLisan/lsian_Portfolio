import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/splash_provider.dart';
// Import your provider file here
// import 'package:lisan_portfolio/path_to_your_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen for state changes to trigger navigation
    ref.listen(splashProvider, (previous, next) {
      if (next == AppStartupState.completed) {
        // Navigate to your main portfolio/home screen
        // Replace 'HomeScreen()' with your actual widget
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text("Home Screen")))),
        );
      }
    });

    return Scaffold(
      backgroundColor: Colors.black, // Typical for a sleek portfolio
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your Logo or Brand Name
            const Text(
              "LISAN",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
              ),
            ),
            const SizedBox(height: 20),
            // A subtle loading indicator to keep the "app" feel
            const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          ],
        ),
      ),
    );
  }
}