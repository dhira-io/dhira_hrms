import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../../features/auth/presentation/bloc/auth_state.dart';
import '../bloc/dashboard_cubit.dart';
import '../bloc/dashboard_state.dart';
import 'package:get/get.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.p16,
        vertical: AppConstants.p8,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(AppAssets.logo, height: 40),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, size: 30),
          ),
          const SizedBox(width: 8),
          
          // Profile section with popup
          BlocBuilder<DashboardCubit, DashboardState>(
            builder: (context, dashboardState) {
              return BlocBuilder<AuthBloc, AuthState>(
                builder: (context, authState) {
                  final user = authState.maybeWhen(
                    authenticated: (user) => user,
                    orElse: () => null,
                  );

                  return GestureDetector(
                    onTap: () {
                      context.read<DashboardCubit>().toggleProfileMenu();
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: (user?.userImage != null && user!.userImage!.isNotEmpty)
                              ? NetworkImage("${Get.find<DioClient>().baseUrl}${user.userImage}")
                              : const AssetImage(AppAssets.defaultProfile) as ImageProvider,
                          radius: 20,
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          dashboardState.isProfileMenuOpen
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: AppColors.textPrimary,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          
          const SizedBox(width: 8),
          
          BlocBuilder<DashboardCubit, DashboardState>(
            builder: (context, state) {
              return IconButton(
                icon: Icon(
                  state.isMainMenuOpen ? Icons.close : Icons.menu,
                  size: 30,
                  color: AppColors.textPrimary,
                ),
                onPressed: () {
                  context.read<DashboardCubit>().toggleMainMenu();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
