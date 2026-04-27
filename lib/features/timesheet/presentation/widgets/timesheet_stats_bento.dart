import 'package:flutter/material.dart';
import 'timesheet_theme.dart';

class TimesheetBentoStats extends StatelessWidget {
  final int filled;
  final int approved;
  final int pending;
  final int rejected;
  final int upcoming;
  final String filledWeeks;
  final String approvedWeeks;
  final String pendingWeeks;
  final String rejectedWeeks;
  final String upcomingWeeks;

  const TimesheetBentoStats({
    super.key,
    required this.filled,
    required this.approved,
    required this.pending,
    required this.rejected,
    required this.upcoming,
    this.filledWeeks = "",
    this.approvedWeeks = "",
    this.pendingWeeks = "",
    this.rejectedWeeks = "",
    this.upcomingWeeks = "",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top Large Card (Filled)
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: TimesheetColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 32,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('FILED', style: TimesheetStyles.statsLabel),
                      const SizedBox(height: 4),
                      Text('$filled week${filled == 1 ? '' : 's'}', style: TimesheetStyles.statsValue),
                    ],
                  ),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: TimesheetColors.primaryFixed,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.query_stats, color: TimesheetColors.onPrimaryFixedVariant),
                  ),
                ],
              ),
              if (filledWeeks.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(filledWeeks, style: TimesheetStyles.statsLabel.copyWith(fontSize: 11, fontWeight: FontWeight.w500)),
              ],
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Grid for other stats
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.5,
          children: [
            _buildSmallCard('APPROVED', approved, approvedWeeks, Icons.check_circle, Colors.green),
            _buildSmallCard('PENDING', pending, pendingWeeks, Icons.pending, Colors.orange),
            _buildSmallCard('REJECTED', rejected, rejectedWeeks, Icons.cancel, TimesheetColors.error),
            _buildSmallCard('UPCOMING', upcoming, upcomingWeeks, Icons.event, Colors.blue),
          ],
        ),
      ],
    );
  }

  Widget _buildSmallCard(String label, int value, String weeks, IconData icon, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: TimesheetColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: TimesheetColors.border.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: iconColor),
              const SizedBox(width: 8),
              Text(label, style: TimesheetStyles.statsLabel.copyWith(fontSize: 10)),
            ],
          ),
          const SizedBox(height: 4),
          Text('$value week${value == 1 ? '' : 's'}', style: TimesheetStyles.h3.copyWith(fontWeight: FontWeight.w800, fontSize: 18)),
          const Spacer(),
          if (weeks.isNotEmpty)
            Text(weeks, 
              maxLines: 1, 
              overflow: TextOverflow.ellipsis,
              style: TimesheetStyles.statsLabel.copyWith(fontSize: 10, fontWeight: FontWeight.w500)
            ),
        ],
      ),
    );
  }
}
