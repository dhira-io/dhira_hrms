import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_router.dart';

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Wrap(
          spacing: 24,
          runSpacing: 16,
          alignment: WrapAlignment.start,
          children: [
            _ActionIcon(
              icon: Icons.checklist,
              label: 'Tasks',
              color: Colors.red,
              onTap: () => context.push(AppRouter.myTaskPath),
            ),
            _ActionIcon(
              icon: Icons.add_task,
              label: 'Timesheet',
              color: Colors.blue,
              onTap: () {}, // Handled elsewhere or add route
            ),
            _ActionIcon(
              icon: Icons.request_page,
              label: 'Leave',
              color: Colors.orange,
              onTap: () {}, 
            ),
            _ActionIcon(
              icon: Icons.people,
              label: 'Team',
              color: Colors.purple,
              onTap: () => context.push(AppRouter.organizationPath),
            ),
            _ActionIcon(
              icon: Icons.settings,
              label: 'Settings',
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
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
