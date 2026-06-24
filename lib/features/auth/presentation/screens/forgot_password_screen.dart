import 'package:dhira_hrms/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/geometric_background_pattern.dart';
import '../bloc/forgot_password_cubit.dart';
import '../widgets/forgot_password_form.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForgotPasswordCubit>(
      create: (context) => ForgotPasswordCubit(
        forgotPasswordUseCase: Get.find<ForgotPasswordUseCase>(),
      ),
      child: const ForgotPasswordView(),
    );
  }
}

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        backgroundColor: colors.primaryContainer,
        body: Column(
          children: [
            // Top Blue Header Section
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        colors.primaryContainer.withValues(alpha: 0.85),
                        colors.primaryContainer,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                // Background geometric pattern mimicking the target design
                const GeometricBackgroundPattern(),
                // Content
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 34.h,
                    left: 16.w,
                    right: 16.w,
                    bottom: 24.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Top Logo (ColorFiltered to White)
                      ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          colors.white,
                          BlendMode.srcIn,
                        ),
                        child: Center(
                          child: Image.asset(AppAssets.logo, height: 54.h),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Bottom White Container (Expanded to fill remaining space)
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colors.background,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(32.r),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 32.h),
                  child: const ForgotPasswordForm(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
