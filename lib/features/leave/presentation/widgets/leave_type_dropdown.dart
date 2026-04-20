import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/leave_bloc.dart';
import '../bloc/leave_state.dart';
import '../../../../shared/components/mandatory_label.dart';
import '../../../../l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<LeaveBloc, LeaveState>(
      buildWhen: (previous, current) => previous.leaveTypes != current.leaveTypes,
      builder: (context, state) {
        final types = state.leaveTypes;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MandatoryLabel(labelText: l10n.leaveType),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: value,
              isExpanded: true,
              hint: Text(l10n.selectLeaveType),
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
              validator: (val) => val == null ? l10n.required : null,
            ),
          ],
        );
      },
    );
  }
}
