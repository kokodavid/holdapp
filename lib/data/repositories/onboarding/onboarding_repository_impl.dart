

import '../../../domain/entities/onboarding/onboarding_entity_status.dart';
import '../../../domain/repositories/onboarding/onboarding_repository.dart';
import '../../data_sources/onboarding/onboarding_local_data_source.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource localDataSource;

  OnboardingRepositoryImpl({required this.localDataSource});

  @override
  Future<OnboardingEntityStatus> getOnboardingStatus() async {
    final hasSeen = await localDataSource.getHasSeenOnboarding();
    return OnboardingEntityStatus(hasSeenOnboarding: hasSeen);
  }

  @override
  Future<void> completeOnboarding() async {
    await localDataSource.cacheHasSeenOnboarding();
  }
}
