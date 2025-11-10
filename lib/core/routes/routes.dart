import 'package:flutter/material.dart';
import '../../presentation/splash/screens/splash_screen.dart';
import '../../presentation/onboarding/screen/onboarding_page.dart';
import '../../presentation/auth/screen/home_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String login = '/login';
}

class AppRouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return _buildRoute(
          const SplashPage(),
          settings: settings,
        );

      case AppRoutes.onboarding:
        return _buildRoute(
          const OnboardingScreen(),
          settings: settings,
        );

      case AppRoutes.home:
        return _buildRoute(
          const HomePage(),
          settings: settings,
        );
        
    

      default:
        return _buildRoute(
          _buildNotFoundPage(),
          settings: settings,
        );
    }
  }

  static PageRoute _buildRoute(
    Widget page, {
    required RouteSettings settings,
  }) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => page,
    );
  }

  static Widget _buildNotFoundPage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.red,
            ),
            SizedBox(height: 16),
            Text(
              '404 - Page Not Found',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'The requested page could not be found',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
