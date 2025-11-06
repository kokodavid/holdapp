import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/routes/routes.dart';
import '../../../core/routes/app_navigator.dart';
import '../../../injection_container.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';
import '../widgets/onboarding_header.dart';
import '../widgets/legal_disclaimer_text.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OnboardingBloc(getOnboardingStatus: sl(), completeOnboarding: sl())
            ..add(CheckOnboardingStatus()),
      child: BlocListener<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingCompleted) {
            AppNavigator.pushNamedAndClearStack(AppRoutes.home);
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 30),
                    const OnboardingHeader(),
                    Column(
                      children: [
                        AppButton(
                          text: "Get Started",
                          isFullWidth: true,
                          onPressed: () {
                            context.read<OnboardingBloc>().add(
                              FinishOnboarding(),
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        AppButton(
                          text: "I have an account",
                          isFullWidth: true,
                          backgroundColor: AppColors.lightShade,
                          textColor: AppColors.accent,
                          onPressed: () {
                            AppNavigator.pushReplacementNamed(AppRoutes.home);
                          },
                        ),
                      ],
                    ),
                    LegalDisclaimerText(
                      onTermsPressed: () {
                        debugPrint("Terms of Service tapped");
                      },
                      onPrivacyPressed: () {
                        debugPrint("Privacy Policy tapped");
                      },
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
