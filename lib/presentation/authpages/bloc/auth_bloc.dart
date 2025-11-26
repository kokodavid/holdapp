import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/auth/get_current_user.dart';
import '../../../domain/usecases/auth/is_signed_in.dart';
import '../../../domain/usecases/auth/sign_in_with_google.dart';
import '../../../domain/usecases/auth/sign_out.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithGoogle signInWithGoogle;
  final SignOut signOut;
  final IsSignedIn isSignedIn;
  final GetCurrentUser getCurrentUser;

  AuthBloc({
    required this.signInWithGoogle,
    required this.signOut,
    required this.isSignedIn,
    required this.getCurrentUser,
  }) : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<GoogleSignInRequested>(_onGoogleSignInRequested);
    on<SignOutRequested>(_onSignOutRequested);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    try {
      print('AppStarted event received');
      emit(AuthLoading());
      final signedEither = await isSignedIn.call(NoParams());

      await signedEither.fold(
            (failure) async {
          print('AppStarted - isSignedIn failed: ${failure.message}');
          emit(AuthFailure(failure.message));
        },
            (signed) async {
          print('AppStarted - isSignedIn result: $signed');
          if (!signed) {
            emit(Unauthenticated());
            return;
          }
          final userEither = await getCurrentUser.call(NoParams());
          userEither.fold(
                (failure) {
              print('AppStarted - getCurrentUser failed: ${failure.message}');
              emit(AuthFailure(failure.message));
            },
                (user) {
              print('AppStarted - getCurrentUser result: $user');
              emit(user != null ? Authenticated(user) : Unauthenticated());
            },
          );
        },
      );
    } catch (e, stackTrace) {
      print('AppStarted - Unexpected error: $e');
      print('Stack trace: $stackTrace');
      emit(AuthFailure('Unexpected error: $e'));
    }
  }

  Future<void> _onGoogleSignInRequested(
      GoogleSignInRequested event,
      Emitter<AuthState> emit
      ) async {
    print('GoogleSignInRequested event received');
    emit(AuthLoading());
    try {
      final result = await signInWithGoogle.call(NoParams());
      print('GoogleSignInRequested - UseCase result received');

      result.fold(
            (failure) {
          print('GoogleSignInRequested - Failure: ${failure.message}');
          emit(AuthFailure(failure.message));
        },
            (user) {
          print('GoogleSignInRequested - Success: $user');
          emit(Authenticated(user));
        },
      );
    } catch (e, stackTrace) {
      print('GoogleSignInRequested - Exception: $e');
      print('Stack trace: $stackTrace');
      emit(AuthFailure('Sign in failed: $e'));
    }
  }

  Future<void> _onSignOutRequested(
      SignOutRequested event,
      Emitter<AuthState> emit
      ) async {
    emit(AuthLoading());
    final result = await signOut.call(NoParams());
    result.fold(
          (failure) => emit(AuthFailure(failure.message)),
          (_) => emit(Unauthenticated()),
    );
  }
}