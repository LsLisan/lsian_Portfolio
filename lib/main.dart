import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'features/my_app/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Pre-warm shaders
  await LiquidGlassWidgets.initialize();

  runApp(
    ProviderScope(
      child: LiquidGlassWidgets.wrap(
        adaptiveQuality: true,
        child: const MyApp(),
      ),
    ),
  );
}