import 'package:dhira_hrms/core/constants/app_assets.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/routing/app_router.dart';
import 'package:dhira_hrms/core/services/local_storage_service.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/widgets/common_button.dart';
import 'package:dhira_hrms/features/auth/presentation/bloc/login_cubit.dart';
import 'package:dhira_hrms/features/auth/presentation/bloc/sso_cubit.dart';
import 'package:dhira_hrms/features/settings/data/constants/webview_urls.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

/// Customized premium login form with rich visual components and styles.
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

  late TextEditingController emailController;
  late TextEditingController passwordController;

  late TapGestureRecognizer _termsRecognizer;
  late TapGestureRecognizer _privacyRecognizer;

  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();

    _termsRecognizer = TapGestureRecognizer()
      ..onTap = _openTerms;

    _privacyRecognizer = TapGestureRecognizer()
      ..onTap = _openPrivacy;

    _loadRememberMeCredentials();
  }

  void _loadRememberMeCredentials() {
    final storage = Get.find<LocalStorageService>();
    final isRemembered = storage.getRememberMe();
    if (isRemembered) {
      final savedEmail = storage.getRememberMeEmail();
      final savedPassword = storage.getRememberMePassword();
      if (savedEmail != null) emailController.text = savedEmail;
      if (savedPassword != null) passwordController.text = savedPassword;
      setState(() {
        _rememberMe = true;
      });
    }
  }

  void _handleRememberMe() {
    final storage = Get.find<LocalStorageService>();
    if (_rememberMe) {
      storage.saveRememberMeCredentials(
        emailController.text.trim(),
        passwordController.text,
      );
    } else {
      storage.clearRememberMeCredentials();
    }
  }

  void _openTerms() {
    final l10n = AppLocalizations.of(context)!;

    context.push(
      AppRouter.commonWebViewPath,
      extra: {
        'url': SettingsWebViewUrls.termsAndConditions,
        'title': l10n.termsAndConditions,
      },
    );
  }

  void _openPrivacy() {
    final l10n = AppLocalizations.of(context)!;

    context.push(
      AppRouter.commonWebViewPath,
      extra: {
        'url': SettingsWebViewUrls.privacyAndSecurity,
        'title': l10n.privacyAndSecurity,
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    _termsRecognizer.dispose();
    _privacyRecognizer.dispose();

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

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, loginState) {
        loginState.whenOrNull(
          success: (_) => _handleRememberMe(),
        );
      },
      builder: (context, loginState) {
        return BlocBuilder<SSOCubit, SSOState>(
          builder: (context, ssoState) {
            final isLoading =
                loginState.maybeWhen(
                  loading: () => true,
                  orElse: () => false,
                ) ||
                    ssoState.maybeWhen(
                      loading: () => true,
                      orElse: () => false,
                    );

            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Email Label
                  Text(
                    l10n.email,
                    style: AppTextStyle.loginLabel.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// Email Field
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: AppTextStyle.bodyMedium.copyWith(
                      color: colors.textPrimary,
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
                      fillColor: colors.surfaceContainerLowest,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: colors.gray400,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: colors.gray400,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: colors.primaryContainer,
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

                  /// Password Label
                  Text(
                    l10n.password,
                    style: AppTextStyle.loginLabel.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// Password Field
                  TextFormField(
                    controller: passwordController,
                    obscureText: !_isPasswordVisible,
                    style: AppTextStyle.bodyMedium.copyWith(
                      color: colors.textPrimary,
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
                      fillColor: colors.surfaceContainerLowest,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: colors.gray400,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: colors.gray400,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: colors.primaryContainer,
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
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
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

                  /// Remember Me + Forgot Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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

                  /// Login Button
                  CommonButton(
                    text: l10n.signIn,
                    onPressed: _submit,
                    isLoading: isLoading,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    borderRadius: AppConstants.r8,
                  ),

                  const SizedBox(height: 24),

                  /// Divider
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: colors.border,
                          thickness: 1,
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
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  /// Microsoft Login
                  InkWell(
                    onTap: isLoading
                        ? null
                        : () {
                      context
                          .read<SSOCubit>()
                          .initiateMicrosoftSSO();
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: colors.gray400,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: colors.surfaceContainerLowest,
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
                              color: colors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 48),

                  /// Terms & Privacy
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
                            TextSpan(
                              text: l10n.bySigningUpAgree,
                            ),

                            TextSpan(
                              text: l10n.termsOfService,
                              recognizer: _termsRecognizer,
                              style: AppTextStyle.bodySmall.copyWith(
                                color: colors.primaryContainer,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                              ),
                            ),

                            TextSpan(
                              text: l10n.andText,
                            ),

                            TextSpan(
                              text: l10n.dataProcessingAgreement,
                              recognizer: _privacyRecognizer,
                              style: AppTextStyle.bodySmall.copyWith(
                                color: colors.primaryContainer,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                decoration: TextDecoration.underline,
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