import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/login_cubit.dart';
import '../bloc/sso_cubit.dart';
import '../../../../l10n/app_localizations.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, loginState) {
        final l10n = AppLocalizations.of(context)!;
        return BlocBuilder<SSOCubit, SSOState>(
          builder: (context, ssoState) {
            final isLoading =
                loginState.maybeWhen(
                  loading: () => true,
                  orElse: () => false,
                ) ||
                ssoState.maybeWhen(loading: () => true, orElse: () => false);

            final error = loginState.maybeWhen(
              error: (msg) => msg,
              orElse: () =>
                  ssoState.maybeWhen(error: (msg) => msg, orElse: () => null),
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isDark
                    ? ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                        child: Image.asset(AppAssets.logo, height: 37),
                      )
                    : Image.asset(AppAssets.logo, height: 37),
                const SizedBox(height: 10),
                Divider(color: AppColors.of(context).bordergrey),
                const SizedBox(height: 20),

                Text(
                  l10n.signIn,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 56),

                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.emailAddress),
                      const SizedBox(height: 8),

                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: AppColors.of(context).onSurface),
                        decoration: InputDecoration(
                          labelText: l10n.emailAddress,
                          hintText: l10n.emailAddress,
                          hintStyle: TextStyle(color: AppColors.of(context).onSurfaceVariant),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.of(context).border),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.of(context).border),
                          ),
                          filled: true,
                          fillColor: isDark ? AppColors.of(context).surfaceContainerLow : Colors.grey.shade100,
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

                      Text(l10n.password),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: passwordController,
                        obscureText: !_isPasswordVisible,
                        style: TextStyle(color: AppColors.of(context).onSurface),
                        decoration: InputDecoration(
                          labelText: l10n.password,
                          hintText: '••••••••',
                          hintStyle: TextStyle(color: AppColors.of(context).onSurfaceVariant),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.of(context).border),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.of(context).border),
                          ),
                          filled: true,
                          fillColor: isDark ? AppColors.of(context).surfaceContainerLow : Colors.grey.shade100,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColors.of(context).onSurfaceVariant,
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
                      const SizedBox(height: 8),

                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: widget.onForgotPasswordTap,
                          child: Text(
                            l10n.forgotPassword,
                            style: TextStyle(
                              color: AppColors.of(context).primaryBlue,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),



                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.of(context).primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: isLoading ? null : _submit,
                    child: isLoading
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            l10n.signIn,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                ),

                 Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Divider(color: AppColors.of(context).bordergrey),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Text(
                      l10n.or,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                InkWell(
                  onTap: isLoading
                      ? null
                      : () {
                          context.read<SSOCubit>().initiateMicrosoftSSO();
                        },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.of(context).bordergrey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.loginWith,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Image.asset(AppAssets.microsoftLogo, scale: 2),
                        const SizedBox(width: 4),
                        Text(
                          l10n.office365,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
