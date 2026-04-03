import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';
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
    if (_otpController.text.length >= 4) {
      context.read<AuthBloc>().add(AuthEvent.verifyOtpRequested(widget.email, _otpController.text));
    } else {
      AppDialogs.showAlertDialog(context, 'Please enter a valid OTP');
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
    return BlocProvider<AuthBloc>.value(
      value: Get.find<AuthBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Verify OTP'),
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (message) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                if (message == "OTP Verified Successfully") {
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
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Enter OTP sent to ${widget.email}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: '----',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      maxLength: 6,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: isLoading ? null : _verifyOtp,
                      child: isLoading
                          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator())
                          : const Text('Verify OTP'),
                    ),
                    TextButton(
                      onPressed: isLoading ? null : _resendOtp,
                      child: const Text('Resend OTP'),
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
