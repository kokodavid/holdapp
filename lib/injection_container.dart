// lib/injection_container.dart

import 'package:get_it/get_it.dart';
import 'package:hold_app/presentation/authpages/bloc/auth_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';

// Onboarding imports
import 'data/data_sources/onboarding/onboarding_local_data_source.dart';
import 'data/repositories/onboarding/onboarding_repository_impl.dart';
import 'domain/repositories/onboarding/onboarding_repository.dart';
import 'domain/usecases/onboarding/get_onboarding_status.dart';
import 'domain/usecases/onboarding/complete_onboarding.dart';

// Auth imports
import 'data/data_sources/auth/auth_remote_data_source.dart';
import 'data/data_sources/auth/auth_local_data_source.dart';
import 'data/repositories/auth/auth_repository_impl.dart';
import 'domain/repositories/auth/auth_repository.dart';
import 'domain/usecases/auth/sign_in_with_google.dart';
import 'domain/usecases/auth/is_signed_in.dart';
import 'domain/usecases/auth/get_current_user.dart';
import 'domain/usecases/auth/sign_out.dart';

final sl = GetIt.instance;

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

  // Firebase Auth & GoogleSignIn
  sl.registerLazySingleton<fb.FirebaseAuth>(() => fb.FirebaseAuth.instance);
  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn(scopes: ['email']));

  // Auth feature wiring
  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(
      firebaseAuth: sl(),
      googleSignIn: sl(),
    ),
  );

  sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl());

  // Repository implementation
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(remote: sl(), local: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => SignInWithGoogle(sl()));
  sl.registerLazySingleton(() => IsSignedIn(sl()));
  sl.registerLazySingleton(() => GetCurrentUser(sl()));
  sl.registerLazySingleton(() => SignOut(sl()));

  // Bloc - CHANGED FROM registerFactory TO registerLazySingleton
  sl.registerLazySingleton<AuthBloc>(() => AuthBloc(
    signInWithGoogle: sl(),
    signOut: sl(),
    isSignedIn: sl(),
    getCurrentUser: sl(),
  ));
}