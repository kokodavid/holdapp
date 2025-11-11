import 'package:flutter/material.dart';
import 'core/routes/routes.dart';
import 'core/routes/app_navigator.dart';
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
      title: 'HoldApp',
      theme: appTheme,
      navigatorKey: AppNavigator.navigatorKey,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
