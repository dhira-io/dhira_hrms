import 'package:dhira_hrms/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/widgets/app_header.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dhira_hrms/features/auth/presentation/bloc/auth_state.dart';

class HomeHeaderWidget extends StatelessWidget {
  final ValueChanged<String>? onSearchChanged;

  const HomeHeaderWidget({super.key, this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppHeader(
          backgroundColor: AppColors.of(context).surface,
          iconColor: AppColors.of(context).onSurface,
        ),
        Container(
          padding: EdgeInsets.only(top: 16.h, bottom: 50.h),
          decoration: BoxDecoration(
            color: AppColors.of(context).primary,
            // borderRadius: BorderRadius.only(
            //   bottomLeft: Radius.circular(24.r),
            //   bottomRight: Radius.circular(24.r),
            // ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppConstants.p20.w),
                child: Builder(
                  builder: (context) {
                    final authName = context.select<AuthBloc, String?>((bloc) => bloc.state.maybeWhen(
                      authenticated: (user) => user.fullName,
                      orElse: () => null,
                    ));
                    final profileName = context.select<ProfileBloc, String?>((bloc) => bloc.state.maybeWhen(
                      loaded: (profile, resume) => profile.fullName,
                      orElse: () => null,
                    ));
                    
                    final fullName = profileName ?? authName;
                    final displayFirstName = fullName?.split(' ').first ?? AppLocalizations.of(context)!.employeeName;
                    
                    return Text(
                      "${AppLocalizations.of(context)!.welcomeName} $displayFirstName!",
                      style: AppTextStyle.bodyLarge.copyWith(
                        color: AppColors.of(context).onPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppConstants.p20.w),
                child: Container(
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: AppColors.of(context).surface,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: AppConstants.p16.w),
                      Icon(
                        Icons.search,
                        color: AppColors.of(context).onSurfaceVariant,
                        size: 20.w,
                      ),
                      SizedBox(width: AppConstants.p12.w),
                      Expanded(
                        child: TextField(
                          onChanged: onSearchChanged,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.searchForSomething,
                            hintStyle: AppTextStyle.bodyMedium.copyWith(
                              color: AppColors.of(context).onSurfaceVariant,
                            ),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(bottom: 8.h), // align text
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
