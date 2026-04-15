import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/components/action_card.dart';
import '../bloc/dashboard_cubit.dart';
import '../bloc/dashboard_state.dart';
import 'package:dhira_hrms/features/dashboard/presentation/bloc/bottom_nav_cubit.dart';

class HomeActionSections extends StatelessWidget {
  const HomeActionSections({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection(context, l10n.employeeActions, state.filteredEmployeeActions, l10n),
              const SizedBox(height: 30),
              _buildSection(context, l10n.companyInformation, state.filteredCompanyInfo, l10n),
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSection(BuildContext context, String title, List<dynamic> items, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 16),
        if (items.isEmpty)
          Center(child: Text(l10n.noResultsFound))
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1.1,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ActionCard(
                title: item.title,
                subtitle: item.subtitle,
                assetImagePath: item.assetImagePath,
                bgColor: item.bgColor,
                onTap: () {
                  if (item.route == AppRouter.attendancePath) {
                    context.read<BottomNavCubit>().changeIndex(1);
                  } else {
                    context.push(item.route);
                  }
                },
              );
            },
          ),
      ],
    );
  }
}
