import 'package:flutter/material.dart';
import 'package:hold_app/presentation/splash/screens/splash_screen.dart';
import 'core/theme/app_theme.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initDependencies();
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
