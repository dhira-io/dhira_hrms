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
    this.padding,
    this.borderRadius,
    this.backgroundColor,
  });

  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final ButtonVariant variant;
  final bool isLoading;
  final IconData? icon;
  final Widget? customIcon;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Widget buttonChild = isLoading
        ? SizedBox(
            width: 20.w,
            height: 20.h,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                variant == ButtonVariant.outlined ||
                        variant == ButtonVariant.text
                    ? AppColors.of(context).primaryContainer
                    : AppColors.of(context).white,
              ),
              strokeWidth: 2,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (customIcon != null) ...[
                customIcon!,
                const SizedBox(width: AppConstants.p8),
              ] else if (icon != null) ...[
                Icon(
                  icon,
                  size: AppConstants.iconXSmall,
                  color: _getTextColor(AppColors.of(context)),
                ),
                const SizedBox(width: AppConstants.p8),
              ],
              Text(
                text,
                style: AppTextStyle.button.copyWith(
                  color: _getTextColor(AppColors.of(context)),
                  fontWeight: FontWeight.w600,
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
            side: BorderSide(
              color: AppColors.of(context).gray400,
              width: 1.0.w,
            ),
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
      default:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                backgroundColor ??
                (variant == ButtonVariant.secondary
                    ? AppColors.of(context).secondary
                    : AppColors.of(context).primaryContainer),
            foregroundColor: AppColors.of(context).white,
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

  Color _getTextColor(AppColorsResolved colors) {
    switch (variant) {
      case ButtonVariant.outlined:
      case ButtonVariant.text:
        return colors.primaryContainer;
      case ButtonVariant.secondary:
      case ButtonVariant.primary:
      default:
        return colors.white;
    }
  }
}
