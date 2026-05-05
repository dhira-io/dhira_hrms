import 'package:dhira_hrms/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dhira_hrms/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/routing/app_router.dart';
import '../bloc/dashboard_cubit.dart';
import '../bloc/dashboard_state.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/welcome_profile_card.dart';
import '../widgets/quick_stats_section.dart';
import '../widgets/employee_actions_section.dart';
import '../widgets/performance_section.dart';
import '../widgets/company_information_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          unauthenticated: () => context.go(AppRouter.loginPath),
          orElse: () {},
        );
      },
      child: Column(
        children: [
          const DashboardHeader(),
          Expanded(
            child: BlocBuilder<DashboardCubit, DashboardState>(
              builder: (context, state) {
                return CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.p14,
                        vertical: AppConstants.p16,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          const WelcomeProfileCard(),
                          const SizedBox(height: AppConstants.p20),
                          const QuickStatsSection(),
                          const SizedBox(height: AppConstants.p20),
                          const EmployeeActionsSection(),
                          const SizedBox(height: AppConstants.p20),
                          const PerformanceSection(),
                          const SizedBox(height: AppConstants.p20),
                          const CompanyInformationSection(),
                          const SizedBox(height: AppConstants.p100),
                        ]),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}