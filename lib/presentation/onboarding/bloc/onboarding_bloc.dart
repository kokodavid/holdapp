// lib/presentation/onboarding/bloc/onboarding_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/onboarding/get_onboarding_status.dart';
import '../../../domain/usecases/onboarding/complete_onboarding.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final GetOnboardingStatus getOnboardingStatus;
  final CompleteOnboarding completeOnboarding;

  OnboardingBloc({
    required this.getOnboardingStatus,
    required this.completeOnboarding,
  }) : super(OnboardingInitial()) {
    on<CheckOnboardingStatus>(_onCheckStatus);
    on<FinishOnboarding>(_onFinishOnboarding);
  }

  Future<void> _onCheckStatus(
      CheckOnboardingStatus event, Emitter<OnboardingState> emit) async {
    emit(OnboardingLoading());
    try {
      final result = await getOnboardingStatus();
      emit(OnboardingStatusLoaded(result.hasSeenOnboarding));
    } catch (e) {
      emit(OnboardingError(e.toString()));
    }
  }

  Future<void> _onFinishOnboarding(
      FinishOnboarding event, Emitter<OnboardingState> emit) async {
    emit(OnboardingLoading());
    try {
      await completeOnboarding();
      emit(OnboardingCompleted());
    } catch (e) {
      emit(OnboardingError(e.toString()));
    }
  }
}
