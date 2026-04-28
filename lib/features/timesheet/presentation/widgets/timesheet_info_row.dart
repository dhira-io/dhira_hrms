import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_style.dart';

class TimesheetInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Widget? valueWidget;

  const TimesheetInfoRow({
    super.key,
    required this.label,
    this.value = '',
    this.valueWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: AppTextStyle.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: valueWidget ??
                Text(
                  value,
                  style: AppTextStyle.bodyMedium.copyWith(
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
