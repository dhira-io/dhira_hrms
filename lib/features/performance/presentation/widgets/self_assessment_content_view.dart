import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/features/performance/presentation/cubit/self_assessment/self_assessment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'self_assessment_assessment_section.dart';
import 'self_assessment_employee_card.dart';
import 'self_assessment_tracking_section.dart';

class SelfAssessmentContentView extends StatelessWidget {
  const SelfAssessmentContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          final cubit = context.read<SelfAssessmentCubit>();
          final name = cubit.state.details?.name ?? '';
          if (name.isNotEmpty) {
            await cubit.fetchSelfAssessment(name, AppConstants.emptyString);
          }
        },
        child: const SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(AppConstants.p16),
          child: Column(
            children: [
              SelfAssessmentEmployeeCard(),
              SizedBox(height: AppConstants.p16),
              SelfAssessmentAssessmentSection(),
              SelfAssessmentTrackingSection(),
            ],
          ),
        ),
      ),
    );
  }
}
