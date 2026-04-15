import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/utils/toast_utils.dart';
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
                ToastUtils.showSuccess(message);
                context.go(AppRouter.loginPath);
              },
              error: (message) => ToastUtils.showError(message),
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
