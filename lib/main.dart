import 'package:flutter/material.dart';
import 'package:hold_app/presentation/splash/screens/splash_screen.dart';

import 'core/theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      home: Scaffold(
        body: Center(
          child: SplashPage(),
        ),
      ),
    );
  }
}
