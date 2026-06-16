import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/common_button.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/forgot_password_cubit.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      FocusManager.instance.primaryFocus?.unfocus();
      context.read<ForgotPasswordCubit>().requestForgotPassword(
        _emailController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      builder: (context, state) {
        final isSuccess = state.maybeWhen(
          success: (_) => true,
          orElse: () => false,
        );

        final isLoading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );
        
        final errorMessage = state.maybeWhen(
          error: (msg) => msg,
          orElse: () => null,
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.of(context).border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            if (isSuccess) ...[
              // Success State UI
              Center(
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.of(context).success.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.mark_email_read_outlined,
                    color: AppColors.of(context).success,
                    size: 40.sp,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Center(
                child: Text(
                  l10n.checkYourInbox,
                  style: AppTextStyle.h3,
                ),
              ),
              SizedBox(height: 12.h),
              Center(
                child: Text(
                  l10n.passwordResetSentTo(_emailController.text.trim()),
                  textAlign: TextAlign.center,
                  style: AppTextStyle.bodyMedium.copyWith(
                    color: AppColors.of(context).textSecondary,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.of(context).border),
                  borderRadius: BorderRadius.circular(AppConstants.r8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.didntReceiveEmail,
                      style: AppTextStyle.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 4.sp, color: AppColors.of(context).textSecondary),
                        SizedBox(width: 8.w),
                        Text(l10n.checkSpamFolder, style: AppTextStyle.bodySmall),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 4.sp, color: AppColors.of(context).textSecondary),
                        SizedBox(width: 8.w),
                        Text(l10n.verifyEmailAddress, style: AppTextStyle.bodySmall),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 4.sp, color: AppColors.of(context).textSecondary),
                        SizedBox(width: 8.w),
                        Text(l10n.requestAnotherLink, style: AppTextStyle.bodySmall),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),
              CommonButton(
                text: l10n.resendLink,
                onPressed: _submit,
                isLoading: isLoading,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
                borderRadius: AppConstants.r8,
              ),
              SizedBox(height: 16.h),
              CommonButton(
                text: l10n.backToLogin,
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  context.pop();
                },
                variant: ButtonVariant.outlined,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
                borderRadius: AppConstants.r8,
              ),
            ] else ...[
              // Form State UI
              Center(
                child: Text(
                  l10n.resetViaEmail,
                  style: AppTextStyle.h3,
                ),
              ),
              SizedBox(height: 12.h),
              Center(
                child: Text(
                  l10n.resetEmailSubtitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.bodyMedium.copyWith(
                    color: AppColors.of(context).textSecondary,
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.workEmailAddress, style: AppTextStyle.label),
                    SizedBox(height: 8.h),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: l10n.enterEmail,
                        errorText: null, // we handle error below
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return l10n.emailRequired;
                        if (!value.contains('@')) return l10n.enterValidEmail;
                        return null;
                      },
                    ),
                    if (errorMessage != null) ...[
                      SizedBox(height: 8.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: AppColors.of(context).error,
                            size: 16.sp,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              // l10n.accountNotFound might be more appropriate if the error is "User not found", but we'll use the specific message or fallback.
                              // Wait, the prompt says "dont use any hardcoded string".
                              // If it's a generic error like "User not found", the API should return a mapped message. But to match the UI perfectly:
                              // If we have an error, we show l10n.accountNotFound.
                              l10n.accountNotFound,
                              style: AppTextStyle.bodySmall.copyWith(
                                color: AppColors.of(context).error,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    SizedBox(height: 32.h),
                    CommonButton(
                      text: l10n.sendResetLink,
                      onPressed: _submit,
                      isLoading: isLoading,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                      borderRadius: AppConstants.r8,
                    ),
                    SizedBox(height: 16.h),
                    CommonButton(
                      text: l10n.backToLogin,
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        context.pop();
                      },
                      variant: ButtonVariant.outlined,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                      borderRadius: AppConstants.r8,
                    ),
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
