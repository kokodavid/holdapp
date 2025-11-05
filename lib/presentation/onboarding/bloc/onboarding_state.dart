// lib/presentation/onboarding/bloc/onboarding_state.dart
abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class OnboardingLoading extends OnboardingState {}

/// When we’ve loaded the onboarding status (seen or not)
class OnboardingStatusLoaded extends OnboardingState {
  final bool hasSeenOnboarding;
  OnboardingStatusLoaded(this.hasSeenOnboarding);
}

/// When onboarding is fully completed
class OnboardingCompleted extends OnboardingState {}

/// In case of error (optional)
class OnboardingError extends OnboardingState {
  final String message;
  OnboardingError(this.message);
}
