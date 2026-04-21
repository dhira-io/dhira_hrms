import 'package:dhira_hrms/core/routing/app_router.dart';
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
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      decoration: const BoxDecoration(
        color: AppColors.primaryBlue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
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
                  backgroundImage: (userProfile?.userImage != null && userProfile!.userImage!.isNotEmpty)
                      ? NetworkImage("${Get.find<DioClient>().baseUrl}${userProfile.userImage}")
                      : const AssetImage(AppAssets.defaultProfile) as ImageProvider,
                  radius: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateTimeUtils.getGreetingMessage(prefix: ""),
                      style: TextStyle(color: AppColors.white.withValues(alpha: 0.7), fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userProfile?.fullName.split(' ').first ?? l10n.user,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.softwareEngineer,
                      style: const TextStyle(color: AppColors.white, fontSize: 12, fontWeight: FontWeight.bold),
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
