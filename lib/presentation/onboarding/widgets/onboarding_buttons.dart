import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hold_app/core/theme/color_styles.dart';


import '../../auth/screen/home_page.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';

class OnboardingButtons extends StatelessWidget {
  const OnboardingButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        _buildGetStartedButton(context, "Get Started", Theme.of(context).primaryColor,
          Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.surfaceVariant),
                (){
                  context
                      .read<OnboardingBloc>()
                      .add(FinishOnboarding());
        }
        ),
        const SizedBox(height: 10),

       _buildGetStartedButton(context, "i have an account", AppColors.surface,
         Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.accent),
               (){
                 Navigator.pushReplacement(
                   context,
                   MaterialPageRoute(builder: (context) => const HomePage()),
                 );
               }
       ),
      ],
    );
  }
}

Widget _buildGetStartedButton(
    BuildContext context,
    String textType,
    Color? myColorType,
    TextStyle? myTextStyle,
    void Function() func
    ) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: myColorType,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: func,
      child: Text(
        textType,
        style: myTextStyle,
      ),
    ),
  );
}
