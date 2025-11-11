import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hold_app/presentation/splash/bloc/splash_screen_event.dart';
import 'package:hold_app/presentation/splash/bloc/splash_screen_state.dart';


class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashStarted>(_onSplashStarted);
  }

  Future<void> _onSplashStarted(
      SplashStarted event,
      Emitter<SplashState> emit,
      ) async {
    await Future.delayed(const Duration(seconds:3));
    emit(SplashLoaded());
  }
}
