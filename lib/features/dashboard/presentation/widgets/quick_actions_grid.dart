import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.quickActions,
          style: AppTextStyle.h3,
        ),
        const SizedBox(height: AppConstants.p16),
        Wrap(
          spacing: AppConstants.p24,
          runSpacing: AppConstants.p16,
          alignment: WrapAlignment.start,
          children: [
            _ActionIcon(
              icon: Icons.checklist,
              label: l10n.tasks,
              color: Colors.red,
              onTap: () => context.push(AppRouter.myTaskPath),
            ),
            _ActionIcon(
              icon: Icons.add_task,
              label: l10n.timesheet,
              color: Colors.blue,
              onTap: () {}, // TODO: Implementation
            ),
            _ActionIcon(
              icon: Icons.request_page,
              label: l10n.leave,
              color: Colors.orange,
              onTap: () {}, 
            ),
            _ActionIcon(
              icon: Icons.people,
              label: l10n.team,
              color: Colors.purple,
              onTap: () => context.push(AppRouter.organizationPath),
            ),
            _ActionIcon(
              icon: Icons.settings,
              label: l10n.settings,
              color: Colors.grey,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionIcon({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppConstants.r12),
          child: Container(
            padding: const EdgeInsets.all(AppConstants.p12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppConstants.r12),
            ),
            child: Icon(icon, color: color),
          ),
        ),
        const SizedBox(height: AppConstants.p8),
        Text(
          label,
          style: AppTextStyle.bodySmall.copyWith(fontSize: 12),
        ),
      ],
    );
  }
}

