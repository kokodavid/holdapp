import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Onboarding imports
import 'data/data_sources/onboarding/onboarding_local_data_source.dart';
import 'data/repositories/onboarding/onboarding_repository_impl.dart';
import 'domain/repositories/onboarding/onboarding_repository.dart';
import 'domain/usecases/onboarding/get_onboarding_status.dart';
import 'domain/usecases/onboarding/complete_onboarding.dart';

// Add others (Auth, Home, etc.) below as you grow

final sl = GetIt.instance; // Service locator

Future<void> initDependencies() async {
  // Shared Preferences
  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // Onboarding
  sl.registerLazySingleton<OnboardingLocalDataSource>(
        () => OnboardingLocalDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<OnboardingRepository>(
        () => OnboardingRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton(() => GetOnboardingStatus(sl()));
  sl.registerLazySingleton(() => CompleteOnboarding(sl()));

  // You can keep adding features here, e.g.:
  // sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  // sl.registerLazySingleton<SplashBloc>(() => SplashBloc(...));
}
