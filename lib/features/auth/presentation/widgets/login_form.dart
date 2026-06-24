import 'package:dhira_hrms/core/constants/app_assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  const LoginForm({super.key, this.onForgotPasswordTap, this.onMicrosoftTap});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController emailController;
  late TextEditingController passwordController;
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;

  late TapGestureRecognizer _termsRecognizer;
  late TapGestureRecognizer _privacyRecognizer;

  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  bool _hasSubmitted = false;

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();

    _termsRecognizer = TapGestureRecognizer()..onTap = _openTerms;

    _privacyRecognizer = TapGestureRecognizer()..onTap = _openPrivacy;

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
        'title': l10n.termsOfService,
      },
    );
  }

  void _openPrivacy() {
    final l10n = AppLocalizations.of(context)!;

    context.push(
      AppRouter.commonWebViewPath,
      extra: {
        'url': SettingsWebViewUrls.privacyAndSecurity,
        'title': l10n.privacyPolicy,
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    _termsRecognizer.dispose();
    _privacyRecognizer.dispose();

    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    setState(() => _hasSubmitted = true);
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
        loginState.whenOrNull(success: (_) => _handleRememberMe());
      },
      builder: (context, loginState) {
        return BlocBuilder<SSOCubit, SSOState>(
          builder: (context, ssoState) {
            final isLoginLoading = loginState.maybeWhen(
              loading: () => true,
              orElse: () => false,
            );
            final isSSOLoading = ssoState.maybeWhen(
              loading: () => true,
              orElse: () => false,
            );
            final isLoading = isLoginLoading || isSSOLoading;

            return Form(
              key: _formKey,
              autovalidateMode: _hasSubmitted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Drag Handle Indicator
                  Center(
                    child: Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: colors.gray400,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Heading
                  Center(
                    child: Text(
                      l10n.signInToYourAccountTitle,
                      style: AppTextStyle.headlineSmall.copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),

                  // Subheading
                  Center(
                    child: Text(
                      l10n.enterEmailAndPasswordBelow,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.bodyMedium.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  /// Email Label
                  Text(
                    l10n.email,
                    style: AppTextStyle.loginLabel.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),

                  /// Email Field
                  TextFormField(
                    controller: emailController,
                    focusNode: emailFocusNode,
                    keyboardType: TextInputType.emailAddress,
                    style: AppTextStyle.bodyMedium.copyWith(
                      color: colors.textPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: 'name@example.com',
                      hintStyle: AppTextStyle.bodyMedium.copyWith(
                        color: colors.gray400,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 10.h,
                      ),
                      filled: true,
                      fillColor: colors.surfaceContainerLowest,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: colors.gray400,
                          width: 1.w,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: colors.gray400,
                          width: 1.w,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: colors.primaryContainer,
                          width: 1.5.w,
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

                  SizedBox(height: 16.h),

                  /// Password Label
                  Text(
                    l10n.password,
                    style: AppTextStyle.loginLabel.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  /// Password Field
                  TextFormField(
                    controller: passwordController,
                    focusNode: passwordFocusNode,
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
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 11.h,
                      ),
                      filled: true,
                      fillColor: colors.surfaceContainerLowest,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: colors.gray400,
                          width: 1.w,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: colors.gray400,
                          width: 1.w,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: colors.primaryContainer,
                          width: 1.5.w,
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

                  SizedBox(height: 8.h),

                  /// Remember Me + Forgot Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 24.w,
                            height: 24.h,
                            child: Checkbox(
                              value: _rememberMe,
                              onChanged: (val) {
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  _rememberMe = val ?? false;
                                });
                              },
                              activeColor: AppColors.of(
                                context,
                              ).primaryContainer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              side: BorderSide(
                                color: colors.gray400,
                                width: 1.5.w,
                              ),
                            ),
                          ),

                          SizedBox(width: 8.w),

                          Text(
                            l10n.rememberMe,
                            style: AppTextStyle.bodySmall.copyWith(
                              color: colors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      GestureDetector(
                        onTap: () {
                          emailFocusNode.unfocus();
                          passwordFocusNode.unfocus();
                          FocusScope.of(context).unfocus();
                          widget.onForgotPasswordTap?.call();
                        },
                        child: Text(
                          l10n.forgotPassword,
                          style: AppTextStyle.loginForgotPassword.copyWith(
                            color: colors.primaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  /// Login Button
                  CommonButton(
                    text: l10n.signIn,
                    onPressed: _submit,
                    isLoading: isLoginLoading,
                    width: double.infinity,
                  ),

                  SizedBox(height: 16.h),

                  /// Divider
                  Row(
                    children: [
                      Expanded(
                        child: Divider(color: colors.border, thickness: 1),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          l10n.orLoginWith,
                          style: AppTextStyle.loginOrWith.copyWith(
                            color: colors.gray400,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(color: colors.border, thickness: 1),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  /// Microsoft Login
                  CommonButton(
                    text: l10n.loginWithOffice365,
                    variant: ButtonVariant.outlined,
                    customIcon: Image.asset(
                      AppAssets.microsoftLogo,
                      height: 20.h,
                    ),
                    width: double.infinity,
                    isLoading: isSSOLoading,
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      context.read<SSOCubit>().initiateMicrosoftSSO();
                    },
                  ),

                  SizedBox(height: 24.h),

                  /// Terms & Privacy Links
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: _openPrivacy,
                        child: Text(
                          l10n.privacyPolicy,
                          style: AppTextStyle.bodySmall.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _openTerms,
                        child: Text(
                          l10n.termsOfService,
                          style: AppTextStyle.bodySmall.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {}, // Add support link if needed
                        child: Text(
                          l10n.support,
                          style: AppTextStyle.bodySmall.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      ),
                    ],
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
