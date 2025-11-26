import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';


class AuthHeaderTexts extends StatelessWidget {
 final String? textTitle;
  const AuthHeaderTexts({super.key, required this.textTitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textTitle!,
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Text(
          "Set meaningful goals, track your progress,\nand stay accountable to the milestones \nthat matter most.",
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 24),
        Text("Email Address", style: theme.textTheme.titleMedium),
      ],
    );
  }
}







