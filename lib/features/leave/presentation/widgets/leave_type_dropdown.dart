import 'package:dhira_hrms/features/leave/domain/entities/leave_type_entity.dart';
import 'package:flutter/material.dart';
import '../../../../shared/components/mandatory_label.dart';

class LeaveTypeDropdown extends StatelessWidget {
  final String? value;
  final List<LeaveTypeEntity> leaveTypes;
  final ValueChanged<String?> onChanged;

  const LeaveTypeDropdown({
    super.key,
    required this.value,
    required this.leaveTypes,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MandatoryLabel(labelText: 'Leave Type'),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          hint: const Text('Select Leave Type'),
          items: leaveTypes.map<DropdownMenuItem<String>>((type) {
            return DropdownMenuItem<String>(
              value: type.leaveTypeName,
              child: Text(type.leaveTypeName),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          validator: (val) => val == null ? 'Required' : null,
        ),
      ],
    );
  }
}
