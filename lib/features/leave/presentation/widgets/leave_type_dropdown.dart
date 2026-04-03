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
    return BlocSelector<LeaveBloc, LeaveState, List<dynamic>>( // Using dynamic for LeaveTypeEntity for simplicity in selector
      selector: (state) {
        return state.maybeWhen(
          loaded: (_, types, __, ___, ____) => types,
          orElse: () => [],
        );
      },
      builder: (context, types) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MandatoryLabel(labelText: 'Leave Type'),
            DropdownButtonFormField<String>(
              value: value,
              hint: const Text('Select Leave Type'),
              items: types.map<DropdownMenuItem<String>>((type) {
                return DropdownMenuItem<String>(
                  value: type.leaveTypeName,
                  child: Text(type.leaveTypeName),
                );
              }).toList(),
              onChanged: onChanged,
              validator: (val) => val == null ? 'Required' : null,
            ),
          ],
        );
      },
    );
  }
}
