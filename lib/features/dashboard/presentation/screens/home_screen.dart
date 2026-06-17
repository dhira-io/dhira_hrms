import 'package:dhira_hrms/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dhira_hrms/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/dashboard_cubit.dart';
import '../bloc/dashboard_state.dart';
import '../widgets/home_header_widget.dart';
import '../widgets/home_user_clock_card.dart';
import '../widgets/home_employee_actions.dart';
import '../widgets/home_quick_stats.dart';

import '../widgets/salary_section.dart';
import 'package:dhira_hrms/core/widgets/app_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          unauthenticated: () => context.go(AppRouter.loginPath),
          orElse: () {},
        );
      },
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          return Column(
            children: [
              AppHeader(
                backgroundColor: AppColors.of(context).surface,
                iconColor: AppColors.of(context).onSurface,
              ),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          const HomeHeaderWidget(),
                          Transform.translate(
                            offset: Offset(0, -40.h),
                            child: Column(
                              children: [
                                const HomeUserClockCard(),
                                SizedBox(height: 8.h),
                                const HomeEmployeeActions(),
                                SizedBox(height: 8.h),
                                const HomeQuickStats(),
                                SizedBox(height: 10.h),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
