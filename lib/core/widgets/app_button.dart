import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum AppButtonSize { small, medium, large }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final AppButtonSize size;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;
  final bool iconFirst;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? elevation;
  final Image? image;


  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.iconFirst = true,
    this.borderRadius,
    this.padding,
    this.elevation,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonColors = _getButtonColors(theme);
    final buttonPadding = _getButtonPadding();
    final buttonBorderRadius = borderRadius ?? 12.0;

    Widget buttonChild = _buildButtonContent();

    if (isLoading) {
      buttonChild = _buildLoadingContent(theme);
    }

    Widget button = ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColors.backgroundColor,
        foregroundColor: buttonColors.textColor,
        padding: buttonPadding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonBorderRadius),
        ),
        elevation: 0,
        disabledBackgroundColor: buttonColors.backgroundColor?.withOpacity(0.5),
        disabledForegroundColor: buttonColors.textColor?.withOpacity(0.5),
      ),
      child: buttonChild,
    );

    return isFullWidth
        ? SizedBox(width: double.infinity, child: button)
        : button;
  }

  Widget _buildButtonContent() {
    final textStyle = _getButtonTextStyle();
    Widget? leadingWidget;

    if (image != null) {
      leadingWidget = SizedBox(
        width: _getIconSize() + 4,
        height: _getIconSize() + 4,
        child: image,
      );
    } else if (icon != null) {
      leadingWidget = Icon(icon, size: _getIconSize());
    }

    if (leadingWidget != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: iconFirst
            ? [
          leadingWidget,
          const SizedBox(width: 8),
          Text(text, style: textStyle),
        ]
            : [
          Text(text, style: textStyle),
          const SizedBox(width: 8),
          leadingWidget,
        ],
      );
    }

    return Text(text, style: textStyle);
  }

  Widget _buildLoadingContent(ThemeData theme) {
    final textStyle = _getButtonTextStyle();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: _getIconSize(),
          height: _getIconSize(),
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              _getButtonColors(theme).textColor ?? AppColors.surface,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(text, style: textStyle),
      ],
    );
  }

  _ButtonColors _getButtonColors(ThemeData theme) {
    return _ButtonColors(
      backgroundColor: backgroundColor ?? theme.primaryColor,
      textColor: textColor ?? AppColors.surface,
      borderColor: borderColor,
    );
  }

  EdgeInsetsGeometry _getButtonPadding() {
    if (padding != null) return padding!;

    switch (size) {
      case AppButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
      case AppButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 14);
      case AppButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
    }
  }

  double _getIconSize() {
    switch (size) {
      case AppButtonSize.small:
        return 16;
      case AppButtonSize.medium:
        return 20;
      case AppButtonSize.large:
        return 24;
    }
  }

  TextStyle _getButtonTextStyle() {
    switch (size) {
      case AppButtonSize.small:
        return const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        );
      case AppButtonSize.medium:
        return const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        );
      case AppButtonSize.large:
        return const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        );
    }
  }
}
class _ButtonColors {
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;

  _ButtonColors({this.backgroundColor, this.textColor, this.borderColor});
}
