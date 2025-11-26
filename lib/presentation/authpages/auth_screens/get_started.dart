import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/routes/app_navigator.dart';
import '../../../core/routes/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../profile_screen/profile_setup_screen.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/reusable_widgets.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetStartedView();
  }
}

class GetStartedView extends StatefulWidget {
  const GetStartedView({super.key});

  @override
  State<GetStartedView> createState() => _GetStartedViewState();
}

class _GetStartedViewState extends State<GetStartedView> {
  bool isChecked = false;
  final TextEditingController emailController = TextEditingController();
  bool _isDialogShowing = false;

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
                "Signing in with Google...",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    ).then((_) => _isDialogShowing = false);
  }

  void _hideDialog() {
    if (_isDialogShowing && Navigator.canPop(context)) {
      Navigator.pop(context);
      _isDialogShowing = false;
    }
  }

  void _handleEmailSignUp() {
    if (!isChecked) {
      showMessageDialog("Please agree to Terms and Conditions");
      return;
    }

    final email = emailController.text.trim();
    if (email.isEmpty) {
      showMessageDialog("Please enter your email");
      return;
    }


    showMessageDialog("Email sign-up will be implemented for: $email");
  }


  void _handleGoogleSignIn() {
    showLoadingDialog();
    context.read<AuthBloc>().add(GoogleSignInRequested());
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEmailFilled = emailController.text.isNotEmpty;
    final isButtonEnabled = isChecked && isEmailFilled;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {

              if (state is AuthLoading) {
                showLoadingDialog();
              }
              else if (state is Authenticated) {

                _hideDialog();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  try {
                    AppNavigator.pushReplacementNamed(AppRoutes.profileSetupScreen);

                  } catch (e) {

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const ProfileSetupScreen()),
                    );
                  }
                });
              }
              else if (state is AuthFailure) {
                _hideDialog();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showMessageDialog(state.message);
                });
              }

              else if (state is Unauthenticated || state is AuthInitial) {
                _hideDialog();
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  AuthHeaderTexts(textTitle: 'Get Started'),
                  const SizedBox(height: 8),

                  CustomTextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Enter your email',
                    onChanged: (_) => setState(() {}),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          setState(() => isChecked = value ?? false);
                        },
                        activeColor: AppColors.accent,
                      ),
                      Expanded(
                        child: Text(
                          "By clicking continue, you agree with \nour Terms and Conditions and Privacy \nPolicy",
                          style: theme.textTheme.labelLarge!.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  AppButton(
                    text: "Continue",
                    isFullWidth: true,
                    size: AppButtonSize.medium,
                    textColor: Colors.white,
                    borderRadius: 10,
                    onPressed: isButtonEnabled ? _handleEmailSignUp : null,
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
                    onPressed: _handleGoogleSignIn,
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
                      showMessageDialog("Apple sign-in not implemented yet");
                    },
                  ),

                  const Spacer(),

                  Center(
                    child: GestureDetector(
                      onTap: () {
                        AppNavigator.pushReplacementNamed(AppRoutes.welcomeBack);
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: theme.textTheme.titleMedium!.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          children: [
                            TextSpan(
                              text: "Sign In",
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