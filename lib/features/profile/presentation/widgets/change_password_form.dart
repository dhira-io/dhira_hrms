import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                label: 'Current Password',
              ),
              const SizedBox(height: 15),
              _PasswordField(
                controller: _newPasswordController,
                label: 'New Password',
                minLength: 4,
              ),
              const SizedBox(height: 15),
              _PasswordField(
                controller: _confirmPasswordController,
                label: 'Confirm New Password',
                validator: (val) => val != _newPasswordController.text ? 'Passwords do not match.' : null,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff1100CC), foregroundColor: Colors.white),
                  child: isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('CHANGE PASSWORD'),
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
    return TextFormField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      validator: (val) {
        if (val == null || val.isEmpty) return 'Required';
        if (minLength != null && (val.length < (minLength as num))) return 'At least $minLength characters required.';
        if (validator != null) return validator!(val); // Fixed nullable call
        return null;
      },
    );
  }
}
