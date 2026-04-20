import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/utils/toast_utils.dart';
import '../bloc/attendance_bloc.dart';
import '../bloc/attendance_event.dart';
import '../bloc/attendance_state.dart';
import '../widgets/attendance_header.dart';
import '../widgets/attendance_log_list.dart';
import '../widgets/punch_card.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          title: Text(l10n.attendance),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                context.read<AttendanceBloc>().add(const AttendanceEvent.checkStatusRequested());
              },
            ),
          ],
        ),
        body: BlocListener<AttendanceBloc, AttendanceState>(
          listener: (context, state) {
            state.whenOrNull(
              error: (message) => ToastUtils.showError(message),
            );
          },
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<AttendanceBloc>().add(const AttendanceEvent.logRequested());
              context.read<AttendanceBloc>().add(const AttendanceEvent.checkStatusRequested());
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  const AttendanceHeader(),
                  const PunchCard(),
                  const SizedBox(height: AppConstants.p20),
                  const AttendanceLogList(),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
