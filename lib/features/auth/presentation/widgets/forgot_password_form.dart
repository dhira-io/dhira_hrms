import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
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
      context.read<ForgotPasswordCubit>().requestForgotPassword(_emailController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      builder: (context, state) {
        final isLoading = state.maybeWhen(loading: () => true, orElse: () => false);
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.forgotPasswordInstructions,
                style: AppTextStyle.bodySmall.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: AppConstants.p32),
              Text(l10n.emailAddress, style: AppTextStyle.label),
              const SizedBox(height: AppConstants.p8),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: l10n.enterEmail,
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return l10n.emailRequired;
                  if (!value.contains('@')) return l10n.enterValidEmail;
                  return null;
                },
              ),
              const SizedBox(height: AppConstants.p32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _submit,
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.surface),
                        )
                      : Text(l10n.sendResetLink, style: AppTextStyle.button),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

