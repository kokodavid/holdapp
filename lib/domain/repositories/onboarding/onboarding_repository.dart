
import '../../entities/onboarding/onboarding_entity_status.dart';

abstract class OnboardingRepository {
  Future<OnboardingEntityStatus> getOnboardingStatus();
  Future<void> completeOnboarding();
}
