import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../onboarding/screen/onboarding_page.dart';
import '../bloc/splash_screen_bloc.dart';
import '../bloc/splash_screen_event.dart';
import '../bloc/splash_screen_state.dart';


class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(SplashStarted()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashLoaded) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const OnboardingPage()),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Image.asset(
              'assets/img/logo.png',
              width: 120,
              height: 120,
            ),
          ),
        ),
      ),
    );
  }
}
