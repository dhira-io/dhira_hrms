import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({super.key});

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<ProfileBloc>().add(ProfileEvent.passwordChangeRequested(
            oldPassword: _oldPasswordController.text,
            newPassword: _newPasswordController.text,
            logoutAllSessions: "1",
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) => previous.maybeWhen(loading: () => true, orElse: () => false) != current.maybeWhen(loading: () => true, orElse: () => false),
      builder: (context, state) {
        final isLoading = state.maybeWhen(loading: () => true, orElse: () => false);

        return Form(
          key: _formKey,
          child: Column(
            children: [
              _PasswordField(
                controller: _oldPasswordController,
                label: l10n.currentPassword,
              ),
              const SizedBox(height: AppConstants.p15),
              _PasswordField(
                controller: _newPasswordController,
                label: l10n.newPassword,
                minLength: 4,
              ),
              const SizedBox(height: AppConstants.p15),
              _PasswordField(
                controller: _confirmPasswordController,
                label: l10n.confirmPassword,
                validator: (val) => val != _newPasswordController.text ? l10n.passwordsDoNotMatch : null,
              ),
              const SizedBox(height: AppConstants.p32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _submit,
                  child: isLoading 
                      ? const CircularProgressIndicator(color: AppColors.surface) 
                      : Text(l10n.changePassword.toUpperCase()),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final int? minLength;
  final String? Function(String?)? validator;

  const _PasswordField({
    required this.controller,
    required this.label,
    this.minLength,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return TextFormField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        labelText: label,
      ),
      validator: (val) {
        if (val == null || val.isEmpty) return l10n.required;
        if (minLength != null && val.length < minLength!) {
          return l10n.atLeastCharactersRequired(minLength!);
        }
        if (validator != null) return validator!(val);
        return null;
      },
    );
  }
}

