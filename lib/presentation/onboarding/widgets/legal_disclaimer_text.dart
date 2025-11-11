import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class LegalDisclaimerText extends StatelessWidget {
  final VoidCallback? onTermsPressed;
  final VoidCallback? onPrivacyPressed;

  const LegalDisclaimerText({
    super.key,
    this.onTermsPressed,
    this.onPrivacyPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: theme.textTheme.labelMedium?.copyWith(
            color: AppColors.textSecondary,
            height: 1.5,
            fontWeight: FontWeight.w400,
          ),
          children: [
            const TextSpan(text: "By continuing, you agree to our "),
            TextSpan(
              text: "Terms of Service",
              style: TextStyle(
                color: AppColors.accent,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w500,
              ),
              recognizer: TapGestureRecognizer()..onTap = onTermsPressed,
            ),
            const TextSpan(text: " and "),
            TextSpan(
              text: "Privacy Policy",
              style: TextStyle(
                color: AppColors.accent,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w500,
              ),
              recognizer: TapGestureRecognizer()..onTap = onPrivacyPressed,
            ),
            const TextSpan(
              text:
                  ". At The HoldApp, your personal goals, logs, and accountability data remain private by default.",
            ),
          ],
        ),
      ),
    );
  }
}

// Alternative: Simple text version
class SimpleLegalText extends StatelessWidget {
  const SimpleLegalText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        "By continuing, you agree to our Terms of Service and Privacy Policy. "
        "At HoldApp, your personal goals, logs, and accountability data "
        "remain private by default.",
        style: theme.textTheme.labelMedium?.copyWith(
          color: AppColors.textSecondary,
          height: 1.5,
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

// Constants for better maintainability
class LegalTextConstants {
  static const String termsAndPrivacyText =
      "By continuing, you agree to our Terms of Service and Privacy Policy. "
      "At HoldApp, your personal goals, logs, and accountability data "
      "remain private by default.";

  static const String termsOfService = "Terms of Service";
  static const String privacyPolicy = "Privacy Policy";

  // URLs for legal documents
  static const String termsUrl = "https://holdapp.com/terms";
  static const String privacyUrl = "https://holdapp.com/privacy";
}
