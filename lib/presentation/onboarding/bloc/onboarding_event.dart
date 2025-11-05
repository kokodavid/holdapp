// lib/presentation/onboarding/bloc/onboarding_event.dart
abstract class OnboardingEvent {}

/// Check if user has already seen onboarding
class CheckOnboardingStatus extends OnboardingEvent {}

/// User finished onboarding (pressed "Get Started")
class FinishOnboarding extends OnboardingEvent {}
