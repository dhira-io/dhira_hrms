import 'package:dhira_hrms/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/utils/toast_utils.dart';
import '../bloc/forgot_password_cubit.dart';
import '../widgets/forgot_password_form.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider<ForgotPasswordCubit>(
      create: (context) => ForgotPasswordCubit(
        forgotPasswordUseCase: Get.find<ForgotPasswordUseCase>(),
      ),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.of(context).surface,
          appBar: AppBar(
            backgroundColor: AppColors.of(context).surface,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.of(context).textPrimary,
                size: AppConstants.iconXSmall,
              ),
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                context.pop();
              },
            ),
            title: Text(l10n.forgotPasswordTitle, style: AppTextStyle.h3),
            centerTitle: true,
          ),
          body: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
            listener: (context, state) {
              state.whenOrNull(
                success: (message) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  ToastUtils.showSuccess(l10n.passwordResetSent);
                  context.pop();
                },
                error: (message) {
                  ToastUtils.showError(message);
                },
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppConstants.p24,
                vertical: AppConstants.p20,
              ),
              child: SingleChildScrollView(
                child: Column(children: [ForgotPasswordForm()]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
