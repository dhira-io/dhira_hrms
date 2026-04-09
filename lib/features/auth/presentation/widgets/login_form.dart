import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginForm extends StatefulWidget {
  final VoidCallback? onForgotPasswordTap;
  final VoidCallback? onMicrosoftTap;

  const LoginForm({
    super.key,
    this.onForgotPasswordTap,
    this.onMicrosoftTap,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
            AuthEvent.loginRequested(
              _emailController.text.trim(),
              _passwordController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );
        
        // Track if this is a form submission (vs SSO)
        final bool isFormSubmitting = isLoading && _emailController.text.isNotEmpty;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.signIn,
              style: AppTextStyle.h1.copyWith(fontSize: 30, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: AppConstants.p40),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.emailAddress, style: AppTextStyle.label),
                  const SizedBox(height: AppConstants.p8),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: l10n.enterEmail,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return l10n.emailRequired;
                      if (!value.contains('@')) return l10n.enterValidEmail;
                      return null;
                    },
                  ),
                  const SizedBox(height: AppConstants.p20),
                  Text(l10n.password, style: AppTextStyle.label),
                  const SizedBox(height: AppConstants.p8),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: l10n.enterPassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: AppColors.textSecondary,
                        ),
                        onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return l10n.passwordRequired;
                      if (value.length < 4) return l10n.passwordTooShort;
                      return null;
                    },
                  ),
                  const SizedBox(height: AppConstants.p12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: widget.onForgotPasswordTap,
                      child: Text(
                        l10n.forgotPassword,
                        style: AppTextStyle.bodyMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.p32),
            ElevatedButton(
              onPressed: isLoading ? null : _submit,
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.surface),
                    )
                  : Text(l10n.signIn),
            ),
            const SizedBox(height: AppConstants.p24),
            Row(
              children: [
                const Expanded(child: Divider(color: AppColors.border)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16),
                  child: Text(l10n.or, style: AppTextStyle.bodySmall.copyWith(color: AppColors.textSecondary)),
                ),
                const Expanded(child: Divider(color: AppColors.border)),
              ],
            ),
            const SizedBox(height: AppConstants.p24),
            OutlinedButton(
              onPressed: isLoading ? null : () {
                context.read<AuthBloc>().add(const AuthEvent.microsoftSSORequested());
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                side: const BorderSide(color: AppColors.border),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r12)),
              ),
              child: isLoading && !isFormSubmitting // Show spinner if loading but not from main form
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(l10n.loginWith, style: AppTextStyle.bodyMedium),
                        const SizedBox(width: AppConstants.p4),
                        Image.asset(AppAssets.microsoftLogo, height: 20),
                        const SizedBox(width: AppConstants.p4),
                        Text(l10n.office365, style: AppTextStyle.h3.copyWith(fontSize: 14)),
                      ],
                    ),
            ),
          ],
        );
      },
    );
  }
}


