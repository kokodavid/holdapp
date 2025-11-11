import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_theme.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.background,
  primaryColor: AppColors.accent,
  colorScheme: const ColorScheme.light(
    primary: AppColors.accent,
    surface: AppColors.surface,
    background: AppColors.background,
    onSurface: AppColors.textPrimary,
    onPrimary: Colors.white,
    error: AppColors.danger,
    secondary: AppColors.info,
  ),
  textTheme: appTextTheme.apply(
    bodyColor: AppColors.textPrimary,
    displayColor: AppColors.textPrimary,
  ),
);

///to change the text default color, just override the colour directly
/*Text(
'Get Started',
style: Theme.of(context).textTheme.displayLarge!.copyWith(
color: AppColors.danger,
),
),*/