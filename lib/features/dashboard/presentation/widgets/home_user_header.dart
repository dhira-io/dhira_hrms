import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/routing/app_router.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:dhira_hrms/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dhira_hrms/features/auth/presentation/bloc/auth_state.dart';

class HomeUserHeader extends StatelessWidget {
  const HomeUserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.p20,
        AppConstants.p20,
        AppConstants.p20,
        AppConstants.p40,
      ),
      decoration: const BoxDecoration(
        color: AppColors.primaryBlue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppConstants.r24),
          bottomRight: Radius.circular(AppConstants.r24),
        ),
      ),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final userProfile = state.maybeWhen(
            authenticated: (user) => user,
            orElse: () => null,
          );

          return Row(
            children: [
              GestureDetector(
                onTap: () => context.push(AppRouter.profilePath),
                child: CircleAvatar(
                  backgroundImage: (userProfile?.userImage != null &&
                          userProfile!.userImage!.isNotEmpty)
                      ? NetworkImage(
                          "${Get.find<DioClient>().baseUrl}${userProfile.userImage}",
                        )
                      : const AssetImage(AppAssets.defaultProfile)
                          as ImageProvider,
                  radius: AppConstants.p32,
                ),
              ),
              const SizedBox(width: AppConstants.p16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateTimeUtils.getGreetingMessage(prefix: ""),
                      style: AppTextStyle.bodySmall.copyWith(
                        color: AppColors.white.withValues(alpha: AppConstants.opacityMuted),
                      ),
                    ),
                    const SizedBox(height: AppConstants.p4),
                    Text(
                      userProfile?.fullName.split(' ').first ?? l10n.user,
                      style: AppTextStyle.h1.copyWith(
                        color: AppColors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.softwareEngineer,
                      style: AppTextStyle.labelSmall.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(AppAssets.dashboardImg, height: 80),
            ],
          );
        },
      ),
    );
  }
}
