import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/routes/app_navigator.dart';
import '../../../core/routes/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/reusable_widgets.dart';

class WelcomeBack extends StatefulWidget {
  const WelcomeBack({super.key});

  @override
  State<WelcomeBack> createState() => _WelcomeBackState();
}
class _WelcomeBackState extends State<WelcomeBack> {
  final TextEditingController emailController = TextEditingController();
  bool _isDialogShowing = false;

  bool get isEmailFilled => emailController.text.trim().isNotEmpty;

  void showMessageDialog(String message) {
    _hideDialog();
    _isDialogShowing = true;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _isDialogShowing = false;
            },
            child: const Text("OK"),
          ),
        ],
      ),
    ).then((_) => _isDialogShowing = false);
  }

  void showLoadingDialog() {
    if (_isDialogShowing) return;
    _isDialogShowing = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                "Signing in to your account...",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    ).then((context) => _isDialogShowing = false);
  }

  void _hideDialog() {
    if (_isDialogShowing && Navigator.canPop(context)) {
      Navigator.pop(context);
      _isDialogShowing = false;
    }
  }

  void _handleEmailSignIn() {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      showMessageDialog("Please enter your email");
      return;
    }

    showMessageDialog("Email sign-in will be implemented for: $email");

  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              print('WelcomeBack - Auth State: $state');

              if (state is AuthLoading) {
                showLoadingDialog();
              }

              if (state is Authenticated) {
                _hideDialog();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  AppNavigator.pushReplacementNamed(AppRoutes.homeScreen);
                });
              }

              if (state is AuthFailure) {
                _hideDialog();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showMessageDialog(state.message);
                });
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  AuthHeaderTexts(textTitle: 'Welcome Back'),
                  const SizedBox(height: 8),

                  CustomTextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Enter your email',
                    onChanged: (context) => setState(() {}),
                  ),

                  const SizedBox(height: 16),

                  AppButton(
                    text: "Continue",
                    isFullWidth: true,
                    size: AppButtonSize.medium,
                    borderRadius: 10,
                    textColor: Colors.white,
                    backgroundColor: isEmailFilled ? AppColors.accent : null,
                    onPressed: isEmailFilled ? _handleEmailSignIn : null,
                  ),

                  const SizedBox(height: 20),
                  Center(
                    child: Text("Or", style: theme.textTheme.titleMedium),
                  ),
                  const SizedBox(height: 20),

                  AppButton(
                    image: Image.asset(
                      "assets/img/google.png",
                      width: 24,
                      height: 24,
                    ),
                    text: "Continue with Google",
                    textColor: AppColors.textPrimary,
                    isFullWidth: true,
                    backgroundColor: AppColors.surface,
                    onPressed: () {
                      context.read<AuthBloc>().add(GoogleSignInRequested());
                    },
                  ),

                  const SizedBox(height: 12),

                  AppButton(
                    image: Image.asset(
                      "assets/img/apple.png",
                      width: 24,
                      height: 24,
                    ),
                    text: "Continue with Apple",
                    textColor: AppColors.textPrimary,
                    isFullWidth: true,
                    backgroundColor: AppColors.surface,
                    onPressed: () {
                      showMessageDialog("Apple Sign-In not available yet.");
                    },
                  ),

                  const Spacer(),


                  Center(
                    child: GestureDetector(
                      onTap: () {

                        AppNavigator.pushReplacementNamed(AppRoutes.getStarted);
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: theme.textTheme.titleMedium!.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              style: theme.textTheme.titleMedium!.copyWith(
                                color: AppColors.accent,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}