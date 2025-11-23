// lib/core/bloc/app_bloc_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hold_app/injection_container.dart' as di;
import 'package:hold_app/presentation/authpages/bloc/auth_bloc.dart';

import '../../presentation/onboarding/bloc/onboarding_bloc.dart';

class AppBlocProvider extends StatelessWidget {
  final Widget child;

  const AppBlocProvider({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<AuthBloc>()),
        BlocProvider(create: (context) => di.sl<OnboardingBloc>()),
      ],
      child: child,
    );
  }
}