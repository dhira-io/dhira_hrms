import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/leave_bloc.dart';
import '../bloc/leave_state.dart';
import '../../../../shared/components/mandatory_label.dart';

class LeaveTypeDropdown extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;

  const LeaveTypeDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveBloc, LeaveState>(
      buildWhen: (previous, current) => previous.leaveTypes != current.leaveTypes,
      builder: (context, state) {
        final types = state.leaveTypes;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MandatoryLabel(labelText: 'Leave Type'),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: value,
              isExpanded: true,
              hint: const Text('Select Leave Type'),
              items: types.map<DropdownMenuItem<String>>((type) {
                return DropdownMenuItem<String>(
                  value: type.leaveTypeName,
                  child: Text(
                    type.leaveTypeName,
                    overflow: TextOverflow.ellipsis,
                  ),
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
      },
    );
  }
}
