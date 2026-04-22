import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../core/routing/app_router.dart';
import '../bloc/otp_verification_cubit.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;

  const OtpVerificationScreen({super.key, required this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _otpController = TextEditingController();

  void _verifyOtp() {
    final l10n = AppLocalizations.of(context)!;
    if (_otpController.text.length >= 4) {
      context.read<OtpVerificationCubit>().verifyOtp(widget.email, _otpController.text);
    } else {
      ToastUtils.showError(l10n.pleaseEnterValidOtp);
    }
  }

  void _resendOtp() {
    context.read<OtpVerificationCubit>().resendOtp(widget.email);
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider<OtpVerificationCubit>.value(
      value: Get.find<OtpVerificationCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: AppBar(
          title: Text(l10n.verifyOtp),
        ),
        body: BlocListener<OtpVerificationCubit, OtpVerificationState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (message, status) {
                ToastUtils.showSuccess(message);
                if (!mounted) return;
                if (status == OtpVerificationStatus.otpVerified) {
                   context.go(AppRouter.dashboardPath);
                }
              },
              error: (message) => ToastUtils.showError(message),
            );
          },
          child: BlocBuilder<OtpVerificationCubit, OtpVerificationState>(
            builder: (context, state) {
              final isLoading = state.maybeWhen(
                loading: () => true,
                orElse: () => false,
              );

              return Padding(
                padding: const EdgeInsets.all(AppConstants.p24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      l10n.enterOtpSentTo(widget.email),
                      textAlign: TextAlign.center,
                      style: AppTextStyle.bodyLarge,
                    ),
                    const SizedBox(height: AppConstants.p24),
                    TextField(
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        hintText: '----',
                      ),
                      maxLength: 6,
                    ),
                    const SizedBox(height: AppConstants.p24),
                    ElevatedButton(
                      onPressed: isLoading ? null : _verifyOtp,
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.surface),
                            )
                          : Text(l10n.verifyOtp, style: AppTextStyle.button),
                    ),
                    TextButton(
                      onPressed: isLoading ? null : _resendOtp,
                      child: Text(l10n.resendOtp, style: AppTextStyle.bodyMedium.copyWith(color: AppColors.primary)),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

