import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_constants.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';

enum ButtonVariant { primary, secondary, outlined, text }

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.variant = ButtonVariant.primary,
    this.isLoading = false,
    this.icon,
    this.customIcon,
    this.suffixIcon,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.foregroundColor,
    this.fontWeight,
  });

  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final ButtonVariant variant;
  final bool isLoading;
  final IconData? icon;
  final Widget? customIcon;
  final IconData? suffixIcon;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    final bool isButtonDisabled = (isLoading ? null : onPressed) == null;
    final colors = AppColors.of(context);

    Widget buttonChild = isLoading
        ? SizedBox(
            width: 20.w,
            height: 20.h,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                variant == ButtonVariant.outlined ||
                        variant == ButtonVariant.text
                    ? colors.primaryContainer
                    : colors.white,
              ),
              strokeWidth: 2,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (customIcon != null) ...[
                if (isButtonDisabled)
                  Opacity(opacity: 0.8, child: customIcon!)
                else
                  customIcon!,
                const SizedBox(width: AppConstants.p8),
              ] else if (icon != null) ...[
                Icon(
                  icon,
                  size: AppConstants.iconXSmall,
                  color: _getTextColor(colors, isButtonDisabled),
                ),
                const SizedBox(width: AppConstants.p8),
              ],
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    text,
                    style: AppTextStyle.button.copyWith(
                      color: _getTextColor(colors, isButtonDisabled),
                      fontWeight: fontWeight ?? FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          );

    Widget button;
    switch (variant) {
      case ButtonVariant.outlined:
        button = OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor: backgroundColor,
            side: BorderSide(
              color: colors.gray400.withValues(alpha: isButtonDisabled ? 0.5 : 1.0),
              width: 1.0.w,
            ),
            foregroundColor:
                foregroundColor ?? colors.primaryContainer,
            disabledForegroundColor:
                (foregroundColor ?? colors.primaryContainer)
                    .withValues(alpha: 0.5),
            padding:
                padding ??
                const EdgeInsets.symmetric(
                  vertical: AppConstants.p16,
                  horizontal: AppConstants.p24,
                ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                borderRadius ?? AppConstants.r12,
              ),
            ),
          ),
          child: buttonChild,
        );
        break;
      case ButtonVariant.text:
        button = TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            foregroundColor:
                foregroundColor ?? colors.primaryContainer,
            disabledForegroundColor:
                (foregroundColor ?? colors.primaryContainer)
                    .withValues(alpha: 0.5),
            padding:
                padding ??
                const EdgeInsets.symmetric(
                  vertical: AppConstants.p16,
                  horizontal: AppConstants.p24,
                ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                borderRadius ?? AppConstants.r12,
              ),
            ),
          ),
          child: buttonChild,
        );
        break;
      case ButtonVariant.secondary:
      case ButtonVariant.primary:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor:
                backgroundColor ??
                (variant == ButtonVariant.secondary
                    ? colors.secondary
                    : colors.primaryContainer),
            foregroundColor: foregroundColor ?? colors.white,
            disabledBackgroundColor:
                (backgroundColor ??
                        (variant == ButtonVariant.secondary
                            ? colors.secondary
                            : colors.primaryContainer))
                    .withValues(alpha: 0.5),
            disabledForegroundColor:
                (foregroundColor ?? colors.white).withValues(
                  alpha: 0.8,
                ),
            elevation: 0,
            padding:
                padding ??
                const EdgeInsets.symmetric(
                  vertical: AppConstants.p16,
                  horizontal: AppConstants.p24,
                ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                borderRadius ?? AppConstants.r12,
              ),
            ),
          ),
          child: buttonChild,
        );
        break;
    }

    if (width != null) {
      return SizedBox(width: width, child: button);
    }

    return button;
  }

  Color _getTextColor(AppColorsResolved colors, bool isDisabled) {
    if (foregroundColor != null) {
      return isDisabled
          ? foregroundColor!.withValues(alpha: 0.5)
          : foregroundColor!;
    }
    if (isDisabled) {
      switch (variant) {
        case ButtonVariant.outlined:
        case ButtonVariant.text:
          return colors.primaryContainer.withValues(alpha: 0.5);
        case ButtonVariant.secondary:
        case ButtonVariant.primary:
          return colors.white.withValues(alpha: 0.8);
      }
    }
    switch (variant) {
      case ButtonVariant.outlined:
      case ButtonVariant.text:
        return colors.primaryContainer;
      case ButtonVariant.secondary:
      case ButtonVariant.primary:
        return colors.white;
    }
  }
}
