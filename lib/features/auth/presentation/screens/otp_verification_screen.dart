import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/dialogs/app_dialogs.dart';
import '../../../../core/routing/app_router.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

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
      context.read<AuthBloc>().add(AuthEvent.verifyOtpRequested(widget.email, _otpController.text));
    } else {
      AppDialogs.showAlertDialog(context, l10n.pleaseEnterValidOtp);
    }
  }

  void _resendOtp() {
    context.read<AuthBloc>().add(AuthEvent.resendOtpRequested(widget.email));
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider<AuthBloc>.value(
      value: Get.find<AuthBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: AppBar(
          title: Text(l10n.verifyOtp),
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (message) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                if (message == l10n.otpVerifiedSuccessfully) {
                   context.go(AppRouter.dashboardPath);
                }
              },
              error: (message) => AppDialogs.showAlertDialog(context, message),
            );
          },
          child: BlocBuilder<AuthBloc, AuthState>(
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

