import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../core/network/dio_client.dart';
import 'package:dhira_hrms/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dhira_hrms/features/auth/presentation/bloc/auth_state.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/utils/string_utils.dart';

import 'package:dhira_hrms/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_event.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_state.dart';
import '../bloc/attendance_event.dart';
import '../bloc/attendance_state.dart';
import '../bloc/attendance_bloc.dart';
import '../bottom_sheets/leave_policy_pdf_bottom_sheet.dart';
import '../bottom_sheets/holiday_list_bottom_sheet.dart';
import '../../../../core/utils/toast_utils.dart';

class AttendanceHeader extends StatefulWidget {
  const AttendanceHeader({super.key});

  @override
  State<AttendanceHeader> createState() => _AttendanceHeaderState();
}

class _AttendanceHeaderState extends State<AttendanceHeader> {
  @override
  void initState() {
    super.initState();
    // Refresh profile to ensure we have the latest uploaded image
    context.read<ProfileBloc>().add(const ProfileEvent.started());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocListener<AttendanceBloc, AttendanceState>(
      listenWhen: (previous, current) =>
          previous.holidayListLeavePolicy != current.holidayListLeavePolicy ||
          (previous is! Loading &&
              current is Loading &&
              current.actionType == AttendanceActionType.fetchPolicy) ||
          (previous is Loading && current is! Loading),
      listener: (context, state) {
        if (state is Loading &&
            state.actionType == AttendanceActionType.fetchPolicy) {
          // Could show a global overlay loader if needed, but the button itself could show loading
        }

        if (state.holidayListLeavePolicy != null &&
            state is! Loading &&
            state is! Error) {
          // Check if this was triggered by a user action
          // We can use a more robust way, but for now:
          // If we are in Loaded state and policy is available
        }
      },
      child: Container(
        width: double.infinity,
        color: AppColors.background,
        padding: const EdgeInsets.only(
          left: AppConstants.p20,
          right: AppConstants.p20,
          top: AppConstants.p10,
          bottom: AppConstants.p15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Avatar and User Name
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                final userProfile = state.maybeWhen(
                  authenticated: (user) => user,
                  orElse: () => null,
                );

                final userName =
                    userProfile?.fullName ?? l10n.executivePresence;
                final userImage = userProfile?.userImage;

                final baseUrl = Get.find<DioClient>().baseUrl;

                return Row(
                  children: [
                    BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, profileState) {
                        final profileImage = profileState.maybeWhen(
                          loaded: (profile) => profile.userImage,
                          orElse: () => userImage,
                        );

                        return Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.slateText,
                          ),
                          child: ClipOval(
                            child:
                                profileImage != null && profileImage.isNotEmpty
                                ? Image.network(
                                    profileImage.isAbsoluteUrl
                                        ? profileImage
                                        : "$baseUrl$profileImage",
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Image.asset(
                                            AppAssets.defaultProfile,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                              AppAssets.defaultProfile,
                                              fit: BoxFit.cover,
                                            ),
                                  )
                                : Image.asset(
                                    AppAssets.defaultProfile,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        userName,
                        style: AppTextStyle.h3.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.notifications,
                      color: AppColors.textSecondary,
                      size: AppConstants.iconXXSmall,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 10),

            Text(
              l10n.calendar,
              style: AppTextStyle.h1.copyWith(
                fontSize: AppConstants.iconLarge,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 10),

            // Action Chips
            Row(
              children: [
                BlocBuilder<AttendanceBloc, AttendanceState>(
                  builder: (context, state) {
                    final isLoading =
                        state is Loading &&
                        state.actionType == AttendanceActionType.fetchPolicy;

                    return Row(
                      children: [
                        _buildActionChip(
                          icon: isLoading
                              ? Icons.hourglass_empty
                              : Icons.shield_outlined,
                          label: l10n.leavePolicy,
                          onTap: isLoading
                              ? () {}
                              : () {
                                  if (state.holidayListLeavePolicy != null) {
                                    LeavePolicyPdfBottomSheet.show(
                                      context,
                                      state
                                          .holidayListLeavePolicy!
                                          .leavePolicy
                                          .fileUrl,
                                    );
                                  } else {
                                    context.read<AttendanceBloc>().add(
                                      const AttendanceEvent.holidayListLeavePolicyRequested(),
                                    );
                                    // We need a way to show it once loaded
                                    _showPolicyOnceLoaded(context);
                                  }
                                },
                        ),
                        const SizedBox(width: 12),
                        _buildActionChip(
                          icon: Icons.list_alt,
                          label: l10n.holidayList,
                          onTap: () {
                            if (state.holidayListLeavePolicy != null) {
                              HolidayListBottomSheet.showYearly(
                                context,
                                state.holidayListLeavePolicy!,
                              );
                            } else {
                              context.read<AttendanceBloc>().add(
                                const AttendanceEvent.holidayListLeavePolicyRequested(),
                              );
                              _showHolidayListOnceLoaded(context);
                            }
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showPolicyOnceLoaded(BuildContext context) {
    // Listen for the next state that has the policy
    final bloc = context.read<AttendanceBloc>();
    late StreamSubscription subscription;
    subscription = bloc.stream.listen((state) {
      if (state.holidayListLeavePolicy != null && state is! Loading) {
        LeavePolicyPdfBottomSheet.show(
          context,
          state.holidayListLeavePolicy!.leavePolicy.fileUrl,
        );
        subscription.cancel();
      } else if (state is Error) {
        subscription.cancel();
      }
    });
  }

  void _showHolidayListOnceLoaded(BuildContext context) {
    final bloc = context.read<AttendanceBloc>();
    late StreamSubscription subscription;
    subscription = bloc.stream.listen((state) {
      if (state.holidayListLeavePolicy != null && state is! Loading) {
        HolidayListBottomSheet.showYearly(
          context,
          state.holidayListLeavePolicy!,
        );
        subscription.cancel();
      } else if (state is Error) {
        subscription.cancel();
      }
    });
  }

  Widget _buildActionChip({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.p16,
          vertical: AppConstants.p10,
        ),
        decoration: BoxDecoration(
          color: AppColors
              .slate200, // Slate-200 color matching the image background
          borderRadius: BorderRadius.circular(AppConstants.r12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: AppConstants.iconSmall,
              color: AppColors.slate600,
            ), // Slate-600
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTextStyle.label.copyWith(
                color: AppColors.slate600,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
