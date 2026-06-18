import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/core/widgets/generic_error_widget.dart';
import 'package:dhira_hrms/features/compensatory_leave/presentation/bloc/compensatory_leave_bloc.dart';
import 'package:dhira_hrms/features/compensatory_leave/presentation/bloc/compensatory_leave_event.dart';

class CompensatoryLeaveErrorView extends StatelessWidget {
  final String? errorMessage;
  const CompensatoryLeaveErrorView({super.key, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return GenericErrorWidget(
      message: errorMessage,
      onRetry: () {
        context.read<CompensatoryLeaveBloc>().add(
          const CompensatoryLeaveEvent.fetchRequested(),
        );
      },
    );
  }
}
