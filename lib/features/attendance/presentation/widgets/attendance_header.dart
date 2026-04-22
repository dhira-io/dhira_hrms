import 'package:flutter/material.dart';
import '../../../../core/utils/date_time_utils.dart';
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

class AttendanceHeader extends StatelessWidget {
  const AttendanceHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final today = DateTimeUtils.todayDate(pattern: 'EEEE, d MMM yyyy');

    return Container(
      width: double.infinity,
      color: Colors.grey.shade50,
      padding: const EdgeInsets.only(
        left: AppConstants.p20,
        right: AppConstants.p20,
        top: 10,
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

              final userName = userProfile?.fullName ?? 'Executive Presence';
              final userImage = userProfile?.userImage;

              ImageProvider? imageProvider;
              if (userImage != null && userImage.isNotEmpty) {
                try {
                  final baseUrl = Get.find<DioClient>().baseUrl;
                  imageProvider = NetworkImage("$baseUrl$userImage");
                } catch (_) {}
              }

              return Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: const Color(0xFF1E293B),
                    backgroundImage:
                        imageProvider ??
                        const AssetImage(AppAssets.defaultProfile),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      userName,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.notifications,
                    color: Colors.grey.shade700,
                    size: 28,
                  ),
                ],
              );
            },
          ),
          // const SizedBox(height: 14),

          // Back to Home
          // GestureDetector(
          //   onTap: () => Navigator.of(context).pop(),
          //   child: Row(
          //     children: [
          //       const Icon(
          //         Icons.arrow_back,
          //         color: AppColors.primary,
          //         size: 20,
          //       ),
          //       const SizedBox(width: 8),
          //       const Text(
          //         'Back to Home',
          //         style: TextStyle(
          //           color: AppColors.primary,
          //           fontSize: 16,
          //           //  fontWeight: FontWeight.w600,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(height: 10),

          Text(
            l10n.calendar,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),

          // Action Chips
          Row(
            children: [
              _buildActionChip(
                icon: Icons.shield_outlined,
                label: l10n.leavePolicy,
                onTap: () {},
              ),
              const SizedBox(width: 12),
              _buildActionChip(
                icon: Icons.list_alt,
                label: l10n.holidayList,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionChip({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(
            0xFFE2E8F0,
          ), // Slate-200 color matching the image background
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: const Color(0xFF475569)), // Slate-600
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF475569),
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
