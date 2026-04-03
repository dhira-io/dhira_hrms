import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../shared/dialogs/app_dialogs.dart';
import '../../../auth/presentation/screens/login_screen.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_state.dart';
import '../widgets/change_password_form.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: Get.find<ProfileBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Change Password')),
        body: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (message) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
                );
              },
              error: (message) => AppDialogs.showAlertDialog(context, message),
            );
          },
          child: const SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: ChangePasswordForm(),
          ),
        ),
      ),
    );
  }
}
