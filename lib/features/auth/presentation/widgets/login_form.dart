import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../bloc/login_cubit.dart';
import '../bloc/sso_cubit.dart';
import '../../../../l10n/app_localizations.dart';

/// Customized premium login form with rich visual components and styles.
class LoginForm extends StatefulWidget {
  final VoidCallback? onForgotPasswordTap;
  final VoidCallback? onMicrosoftTap;

  const LoginForm({super.key, this.onForgotPasswordTap, this.onMicrosoftTap});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginCubit>().login(
        emailController.text.trim(),
        passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;
    
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, loginState) {
        return BlocBuilder<SSOCubit, SSOState>(
          builder: (context, ssoState) {
            final isLoading =
                loginState.maybeWhen(
                  loading: () => true,
                  orElse: () => false,
                ) ||
                ssoState.maybeWhen(loading: () => true, orElse: () => false);

            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Email Address Label
                  Text(
                    l10n.email,
                    style: AppTextStyle.loginLabel.copyWith(
                      color: colors.slate950,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // 2. Email Address Input Field (Height: 44px naturally)
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: AppTextStyle.bodyMedium.copyWith(
                      color: colors.slate950,
                    ),
                    decoration: InputDecoration(
                      hintText: l10n.enterEmail,
                      hintStyle: AppTextStyle.bodyMedium.copyWith(
                        color: colors.gray400,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      filled: true,
                      fillColor: colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: colors.gray400,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: colors.gray400,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: colors.primaryContainer,
                          width: 1.5,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: colors.error,
                          width: 1.0,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: colors.error,
                          width: 1.5,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.emailRequired;
                      }
                      if (!value.contains('@')) {
                        return l10n.enterValidEmail;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // 3. Password Label
                  Text(
                    l10n.password,
                    style: AppTextStyle.loginLabel.copyWith(
                      color: colors.slate950,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // 4. Password Input Field (Height: 46px naturally, borderRadius: 10)
                  TextFormField(
                    controller: passwordController,
                    obscureText: !_isPasswordVisible,
                    style: AppTextStyle.bodyMedium.copyWith(
                      color: colors.slate950,
                    ),
                    decoration: InputDecoration(
                      hintText: '••••••••',
                      hintStyle: AppTextStyle.bodyMedium.copyWith(
                        color: colors.gray400,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 11,
                      ),
                      filled: true,
                      fillColor: colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: colors.gray400,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: colors.gray400,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: colors.primaryContainer,
                          width: 1.5,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: colors.error,
                          width: 1.0,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: colors.error,
                          width: 1.5,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: colors.gray400,
                          size: 20,
                        ),
                        onPressed: () => setState(
                          () => _isPasswordVisible = !_isPasswordVisible,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.passwordRequired;
                      }
                      if (value.length < 4) {
                        return l10n.passwordTooShort;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // 5. Checkbox (Remember Me) & Forgot Password Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Remember me (Stateful visual checkbox)
                      Row(
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Checkbox(
                              value: _rememberMe,
                              onChanged: (val) {
                                setState(() {
                                  _rememberMe = val ?? false;
                                });
                              },
                              activeColor: colors.primaryContainer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              side: BorderSide(
                                color: colors.gray400,
                                width: 1.5,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            l10n.rememberMe,
                            style: AppTextStyle.bodySmall.copyWith(
                              color: colors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      // Forgot your password link
                      GestureDetector(
                        onTap: widget.onForgotPasswordTap,
                        child: Text(
                          l10n.forgotPassword,
                          style: AppTextStyle.loginForgotPassword.copyWith(
                            color: colors.primaryContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // 6. Login Action Button (Height: 48, #155DFC background)
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primaryContainer,
                        foregroundColor: colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppConstants.r8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                      ),
                      onPressed: isLoading ? null : _submit,
                      child: isLoading
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  colors.white,
                                ),
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              l10n.signIn,
                              style: AppTextStyle.button.copyWith(
                                color: colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 7. "Or login with" Separator
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: colors.border,
                          thickness: 1.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          l10n.orLoginWith,
                          style: AppTextStyle.loginOrWith.copyWith(
                            color: colors.gray400,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: colors.border,
                          thickness: 1.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // 8. Office 365 Integration Button (Height: 48, borderRadius: 10, #0F172B text)
                  InkWell(
                    onTap: isLoading
                        ? null
                        : () {
                            context.read<SSOCubit>().initiateMicrosoftSSO();
                          },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: colors.gray400,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppAssets.microsoftLogo,
                            height: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            l10n.loginWithOffice365,
                            style: AppTextStyle.loginOffice365Text.copyWith(
                              color: colors.slate900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),

                  // 9. Terms of Service & Privacy Footer (RichText visual representation)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: AppTextStyle.bodySmall.copyWith(
                            color: colors.gray400,
                            fontSize: 12,
                            height: 1.4,
                          ),
                          children: [
                            TextSpan(text: l10n.bySigningUpAgree),
                            TextSpan(
                              text: l10n.termsOfService,
                              style: AppTextStyle.bodySmall.copyWith(
                                color: colors.slate900,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            TextSpan(text: l10n.andText),
                            TextSpan(
                              text: l10n.dataProcessingAgreement,
                              style: AppTextStyle.bodySmall.copyWith(
                                color: colors.slate900,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
