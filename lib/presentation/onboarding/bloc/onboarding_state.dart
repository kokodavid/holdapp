abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class OnboardingLoading extends OnboardingState {}

class OnboardingStatusLoaded extends OnboardingState {
  final bool hasSeenOnboarding;
  OnboardingStatusLoaded(this.hasSeenOnboarding);
}

class OnboardingCompleted extends OnboardingState {}

class OnboardingError extends OnboardingState {
  final String message;
  OnboardingError(this.message);
}
