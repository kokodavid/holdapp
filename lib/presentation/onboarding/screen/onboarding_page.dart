import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/color_styles.dart';
import '../../../injection_container.dart';
import '../../auth/screen/home_page.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';
import '../widgets/onboarding_buttons.dart';
import '../widgets/onboarding_header.dart';


class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => OnboardingBloc(
getOnboardingStatus: sl(),
completeOnboarding: sl(),

      )..add(CheckOnboardingStatus()),
      child: BlocListener<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingCompleted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocBuilder<OnboardingBloc, OnboardingState>(
              builder: (context, state) {
                if (state is OnboardingLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(height: 30),
                        const OnboardingHeader(),
                        const OnboardingButtons(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            "By continuing, you agree to our Terms of Service and Privacy Policy. "
                                "At HoldApp, your personal goals, logs, and accountability data "
                                "remain private by default.",
                            style: theme.textTheme.labelMedium?.copyWith(
                                color: AppColors.textSecondary,
                                height: 2.0,
                                fontWeight: FontWeight.w400
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
              },
            ),
        ),
      ),
    );
  }
}









/*import 'package:flutter/material.dart';
import '../../../core/theme/color_styles.dart';
import '../widgets/onboarding_buttons.dart';
import '../widgets/onboarding_header.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 30),
              const OnboardingHeader(),
              const OnboardingButtons(),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  "By continuing, you agree to our Terms of Service and Privacy Policy. "
                      "At HoldApp, your personal goals, logs, and accountability data "
                      "remain private by default.",
                  style: theme.textTheme.labelMedium?.copyWith(
                      color: AppColors.textSecondary,
                      height: 2.0,
                      fontWeight: FontWeight.w400
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

 */

