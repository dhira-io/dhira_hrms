import 'package:dhira_hrms/core/routing/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../../features/auth/presentation/bloc/auth_state.dart';
import 'package:get/get.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.p20,
            vertical: AppConstants.p16,
          ),
          color: AppColors.background,
          child: Row(
            children: [
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, authState) {
                  final user = authState.maybeWhen(
                    authenticated: (user) => user,
                    orElse: () => null,
                  );

                  return GestureDetector(
                    onTap: () => context.push(AppRouter.profilePath),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryFixed,
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: (user?.userImage != null &&
                              user!.userImage!.isNotEmpty)
                          ? Image.network(
                              "${Get.find<DioClient>().baseUrl}${user.userImage}",
                              fit: BoxFit.cover,
                            )
                          : const Image(
                              image: AssetImage(AppAssets.defaultProfile),
                              fit: BoxFit.cover,
                            ),
                    ),
                  );
                },
              ),
              const SizedBox(width: AppConstants.p12),
              Text(
                AppLocalizations.of(context)!.executivePresence,
                style: AppTextStyle.h2.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: AppColors.onSurfaceVariant,
                  size: AppConstants.iconMedium,
                ),
                style: IconButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(40, 40),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          width: double.infinity,
          color: AppColors.outlineVariant.withValues(alpha: 0.3),
        ),
      ],
    );
  }
}
