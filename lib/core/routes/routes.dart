import 'package:flutter/material.dart';
import 'package:hold_app/presentation/authpages/auth_screens/welcome_back.dart';
import 'package:hold_app/presentation/homescreen/home_screen.dart';

import '../../presentation/authpages/auth_screens/get_started.dart';
import '../../presentation/profile_screen/profile_setup_screen.dart';
import '../../presentation/splash/screens/splash_screen.dart';
import '../../presentation/onboarding/screen/onboarding_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String getStarted = '/get-started';
  static const String login = '/login';
  static const String welcomeBack = '/welcome-back';
  static const String profileSetupScreen = '/profile-setup-screen';
  static const String homeScreen = '/homeScreen';
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

      case AppRoutes.getStarted:
        return _buildRoute(
          const GetStarted(),
          settings: settings,
        );

      case AppRoutes.welcomeBack:
        return _buildRoute(
          const WelcomeBack(),
          settings: settings,
        );

      case AppRoutes.profileSetupScreen:
        return _buildRoute(
          const ProfileSetupScreen(),
          settings: settings,
        );

      case AppRoutes.homeScreen:
        return _buildRoute(
          const HomeScreen(),
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
