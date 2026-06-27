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
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_state.dart';
import 'package:dhira_hrms/features/performance/presentation/bloc/performance_bloc.dart';
import 'package:dhira_hrms/features/performance/presentation/bloc/performance_state.dart';
import 'package:dhira_hrms/core/presentation/dialogs/logout_alert_dialog.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;
    final baseUrl = AppConstants.baseUrl;

    return Drawer(
      backgroundColor: colors.surface,
      surfaceTintColor: colors.transparent,
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
                    icon: Icon(Icons.close, color: colors.onSurface),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            
            Divider(height: 1, thickness: 1, color: colors.outlineVariant),
            
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
                            height: 50.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colors.primaryFixed,
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
                                        style: AppTextStyle.bodyLarge.copyWith(color: colors.onPrimaryFixed),
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      displayInitials,
                                      style: AppTextStyle.bodyLarge.copyWith(color: colors.onPrimaryFixed),
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
                                    color: colors.onSurface,
                                    fontWeight: FontWeight.bold, // Made bold as requested
                                    ),
                                ),
                                SizedBox(height: 8.h), // Increased space
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                                  decoration: BoxDecoration(
                                    color: colors.primary.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Text(
                                    designation ?? l10n.designation,
                                    style: AppTextStyle.bodySmall.copyWith(
                                      color: colors.primary,
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
            
            Divider(height: 1, thickness: 1, color: colors.outlineVariant),
            
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    sliver: SliverList.list(
                      children: [
                        _DrawerMenuItemWidget(
                          icon: Icons.person_outline,
                          title: l10n.myAccount,
                          onTap: () {
                            context.push(AppRouter.profilePath);
                          },
                        ),

                        BlocBuilder<PerformanceBloc, PerformanceState>(
                          builder: (context, performanceState) {
                            return _ExpandablePerformanceMenuItem(
                              l10n: l10n,
                              performanceState: performanceState,
                            );
                          },
                        ),
                        _DrawerMenuItemWidget(
                          icon: Icons.policy_outlined,
                          title: l10n.policies,
                          onTap: () {
                            context.push(AppRouter.policyPath);
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Divider(height: 1, thickness: 1, color: colors.outlineVariant),
                        ),
                        _DrawerMenuItemWidget(
                          icon: Icons.headset_mic_outlined,
                          title: l10n.support,
                          onTap: () {
                            context.push(AppRouter.comingSoonPath, extra: l10n.support);
                          },
                        ),
                        _DrawerMenuItemWidget(
                          icon: Icons.settings_outlined,
                          title: l10n.settings,
                          onTap: () {
                            context.push(AppRouter.settingsPath);
                          },
                        ),
                        _DrawerMenuItemWidget(
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
                ],
              ),
            ),
            
            // Footer Version
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Text(
                "${l10n.version} ${AppConstants.appVersion}",
                style: AppTextStyle.bodySmall.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class _DrawerMenuItemWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DrawerMenuItemWidget({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: ListTile(
        leading: Icon(
          icon,
          color: colors.drawerIconColor,
          size: 24.w,
        ),
        title: Text(
          title,
          style: AppTextStyle.bodyMedium.copyWith(
            color: colors.drawerIconColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 24.w),
        dense: true,
      ),
    );
  }
}

class _ExpandablePerformanceMenuItem extends StatefulWidget {
  final AppLocalizations l10n;
  final PerformanceState performanceState;

  const _ExpandablePerformanceMenuItem({
    required this.l10n,
    required this.performanceState,
  });

  @override
  State<_ExpandablePerformanceMenuItem> createState() =>
      _ExpandablePerformanceMenuItemState();
}

class _ExpandablePerformanceMenuItemState
    extends State<_ExpandablePerformanceMenuItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: colors.transparent,
        ),
        child: ExpansionTile(
          onExpansionChanged: (expanded) {
            setState(() {
              _isExpanded = expanded;
            });
          },
          trailing: AnimatedRotation(
            turns: _isExpanded ? 0.25 : 0,
            duration: const Duration(milliseconds: 200),
            child: Icon(
              Icons.keyboard_arrow_right,
              color: colors.drawerIconColor,
            ),
          ),
          leading: Icon(
            Icons.speed_outlined,
            color: colors.drawerIconColor,
            size: 24.w,
          ),
          title: Text(
            widget.l10n.performance,
            style: AppTextStyle.bodyMedium.copyWith(
              color: colors.drawerIconColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          tilePadding: EdgeInsets.symmetric(horizontal: 24.w),
          childrenPadding: EdgeInsets.only(left: 36.w),
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: colors.onSurfaceVariant,
                    width: 1.5,
                  ),
                ),
              ),
              child: Column(
                children: [
                  _DrawerSubMenuItemWidget(
                    title: widget.l10n.goalSetup,
                    onTap: () {
                      context.push(AppRouter.performanceGoalSetupPath);
                    },
                  ),
                  _DrawerSubMenuItemWidget(
                    title: widget.l10n.selfAssessment,
                    onTap: () {
                      context.push(AppRouter.performanceSelfAssessmentPath);
                    },
                  ),
                  if (widget.performanceState.isManager)
                    _DrawerSubMenuItemWidget(
                      title: widget.l10n.teamEvaluation,
                      onTap: () {
                        context.push(AppRouter.performanceTeamEvaluationPath);
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class _DrawerSubMenuItemWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _DrawerSubMenuItemWidget({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return ListTile(
      title: Text(
        title,
        style: AppTextStyle.bodyMedium.copyWith(
          color: colors.drawerIconColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.only(left: 16.w, right: 24.w),
      dense: true,
    );
  }
}
