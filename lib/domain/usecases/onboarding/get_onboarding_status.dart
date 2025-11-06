import 'package:hold_app/domain/entities/onboarding/onboarding_entity_status.dart';
import '../../repositories/onboarding/onboarding_repository.dart';

class GetOnboardingStatus {
  final OnboardingRepository repository;

  GetOnboardingStatus(this.repository);

  Future<OnboardingEntityStatus> call() async {
    return await repository.getOnboardingStatus();
  }
}
