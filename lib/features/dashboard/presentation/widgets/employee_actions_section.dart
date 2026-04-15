import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';

class EmployeeActionsSection extends StatelessWidget {
  const EmployeeActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Employee Actions',
          style: AppTextStyle.h3,
        ),
        const SizedBox(height: AppConstants.p16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _ActionCard(
                title: 'Timesheet',
                subtitle: 'Log your hours',
                icon: Icons.access_time_filled,
                iconColor: Colors.blue,
                onTap: () {},
              ),
            ),
            const SizedBox(width: AppConstants.p16),
            Expanded(
              child: _ActionCard(
                title: 'Leave Application',
                subtitle: 'Request time off',
                icon: Icons.calendar_today,
                iconColor: Colors.teal,
                onTap: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.p16),
        FractionallySizedBox(
          widthFactor: 0.5,
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: _ActionCard(
              title: 'Attendance',
              subtitle: 'View records',
              icon: Icons.person_add_alt_1,
              iconColor: Colors.deepPurple,
              onTap: () {},
            ),
          ),
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(AppConstants.p20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: AppTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: AppTextStyle.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
