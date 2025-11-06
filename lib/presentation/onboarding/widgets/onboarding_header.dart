import 'package:flutter/material.dart';
import 'package:hold_app/core/theme/app_colors.dart';

class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo centered
          Center(
            child: Image.asset('assets/img/logo.png', height: 167, width: 147),
          ),

          const SizedBox(height: 64),

          // First line
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _text(
                "Grow",
                Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                  fontSize: 30,
                ),
              ),
              const SizedBox(width: 6),
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 25,
                child: Image.asset(
                  'assets/img/ellipse.png',
                  height: 50,
                  width: 50,
                ),
              ),
              const SizedBox(width: 6),
              _text(
                "with",
                theme.textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                  height: 1.1,
                ),
              ),
              const SizedBox(width: 6),
              _text(
                "the",
                theme.textTheme.displaySmall!.copyWith(
                  color: AppColors.textTertiary,
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                  height: 1.2,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Second line
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _text(
                "most supportive",
                theme.textTheme.displayMedium!.copyWith(
                  color: AppColors.textTertiary,
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                  height: 1.2,
                ),
              ),
              const SizedBox(width: 6),

              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 16,
                child: Image.asset(
                  'assets/img/ellipse2.png',
                  height: 35,
                  width: 35,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // Third line
          _text(
            "partner",
            theme.textTheme.displayMedium!.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 30,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _text(String text, TextStyle style) {
    return Text(text, style: style, overflow: TextOverflow.visible);
  }
}
