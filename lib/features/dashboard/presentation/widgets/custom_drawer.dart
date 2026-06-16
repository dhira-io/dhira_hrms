import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/constants/app_assets.dart';
import 'package:dhira_hrms/core/routing/app_router.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dhira_hrms/features/auth/presentation/bloc/auth_state.dart';
import 'package:dhira_hrms/features/auth/presentation/bloc/auth_event.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_state.dart';
import 'package:dhira_hrms/core/network/dio_client.dart';
import 'package:get/get.dart';
import 'package:dhira_hrms/core/presentation/dialogs/logout_alert_dialog.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final baseUrl = Get.find<DioClient>().baseUrl;

    return Drawer(
      backgroundColor: AppColors.of(context).surface,
      surfaceTintColor: Colors.transparent,
      child: SafeArea(
        child: Column(
          children: [
            // Header: Logo and Close button
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 8.w, top: 8.h, bottom: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    AppAssets.logo,
                    height: 28.h,
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: AppColors.of(context).onSurface),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            
            Divider(height: 1, thickness: 1, color: AppColors.of(context).outlineVariant.withOpacity(0.3)),
            
            // Profile Section
            Padding(
              padding: EdgeInsets.all(20.w),
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, authState) {
                  final user = authState.maybeWhen(
                    authenticated: (user) => user,
                    orElse: () => null,
                  );
                  return BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, profileState) {
                      final profileImage = profileState.maybeWhen(
                        loaded: (profile, resume) => profile.userImage,
                        orElse: () => user?.userImage,
                      );
                      final fullName = profileState.maybeWhen(
                        loaded: (profile, resume) => profile.fullName,
                        orElse: () => user?.fullName,
                      );
                      final designation = profileState.maybeWhen(
                        loaded: (profile, resume) => profile.designation,
                        orElse: () => null,
                      );
                      
                      final displayInitials = fullName?.isNotEmpty == true ? fullName![0].toUpperCase() : "E";

                      return Row(
                        children: [
                          Container(
                            width: 50.w,
                            height: 50.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.of(context).primaryFixed,
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: (profileImage != null && profileImage.isNotEmpty)
                                ? Image.network(
                                    profileImage.startsWith(AppConstants.httpPrefix)
                                        ? profileImage
                                        : "$baseUrl$profileImage",
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        Center(
                                      child: Text(
                                        displayInitials,
                                        style: AppTextStyle.bodyLarge.copyWith(color: AppColors.of(context).onPrimaryFixed),
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      displayInitials,
                                      style: AppTextStyle.bodyLarge.copyWith(color: AppColors.of(context).onPrimaryFixed),
                                    ),
                                  ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  fullName ?? l10n.employeeName,
                                  style: AppTextStyle.bodyLarge.copyWith(
                                    color: AppColors.of(context).onSurface,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.sp,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                                  decoration: BoxDecoration(
                                    color: AppColors.of(context).primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Text(
                                    designation ?? l10n.designation,
                                    style: AppTextStyle.bodySmall.copyWith(
                                      color: AppColors.of(context).primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            
            Divider(height: 1, thickness: 1, color: AppColors.of(context).outlineVariant.withOpacity(0.3)),
            
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                children: [
                  _buildMenuItem(
                    context,
                    icon: Icons.person_outline,
                    title: l10n.myAccount,
                    onTap: () {
                      Navigator.pop(context);
                      context.push(AppRouter.profilePath);
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.account_tree_outlined,
                    title: l10n.organizationHierarchy,
                    onTap: () {
                      Navigator.pop(context);
                      context.push(AppRouter.organizationChartPath);
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.speed_outlined,
                    title: l10n.performance,
                    onTap: () {
                      Navigator.pop(context);
                      context.push(AppRouter.comingSoonPath, extra: l10n.performance);
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.shield_outlined,
                    title: l10n.policies,
                    onTap: () {
                      Navigator.pop(context);
                      context.push(AppRouter.comingSoonPath, extra: l10n.policies);
                    },
                  ),
                  
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Divider(height: 1, thickness: 1, color: AppColors.of(context).outlineVariant.withOpacity(0.3)),
                  ),
                  
                  _buildMenuItem(
                    context,
                    icon: Icons.headset_mic_outlined,
                    title: l10n.support,
                    onTap: () {
                      Navigator.pop(context);
                      context.push(AppRouter.comingSoonPath, extra: l10n.support);
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.settings_outlined,
                    title: l10n.settings,
                    onTap: () {
                      Navigator.pop(context);
                      context.push(AppRouter.settingsPath);
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.logout_outlined,
                    title: l10n.logout,
                    onTap: () {
                      Navigator.pop(context);
                      LogoutAlertDialog.show(context);
                    },
                  ),
                ],
              ),
            ),
            
            // Footer Version
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Text(
                "${l10n.version} 1.0.0",
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.of(context).onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color(0xFF23444A), // Use a darker color like mockup
        size: 24.w,
      ),
      title: Text(
        title,
        style: AppTextStyle.bodyMedium.copyWith(
          color: const Color(0xFF23444A), // Dark text color
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 24.w),
      dense: true,
    );
  }
}
