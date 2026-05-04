import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../widgets/team_evaluation_review_widgets.dart';
import '../cubit/self_assessment/self_assessment_cubit.dart';

class TeamEvaluationReviewScreen extends StatefulWidget {
  final String employeeName;
  final String employeeId;
  final String department;
  final String status;
  final String evaluationStatus;
  final String selfAssessmentId;
  final String evaluationId;

  const TeamEvaluationReviewScreen({
    super.key,
    required this.employeeName,
    required this.employeeId,
    required this.department,
    required this.status,
    required this.evaluationStatus,
    required this.selfAssessmentId,
    required this.evaluationId,
  });

  @override
  State<TeamEvaluationReviewScreen> createState() =>
      _TeamEvaluationReviewScreenState();
}

class _TeamEvaluationReviewScreenState
    extends State<TeamEvaluationReviewScreen> {
  String? _selectedKra;

  @override
  void initState() {
    super.initState();
    Get.find<SelfAssessmentCubit>().fetchSelfAssessment(
      widget.selfAssessmentId,
      widget.evaluationId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: Get.find<SelfAssessmentCubit>(),
      child: BlocListener<SelfAssessmentCubit, SelfAssessmentState>(
        listener: (context, state) {
          state.maybeWhen(
            success: (details) {
              if (_selectedKra == null && details.goalReviews.isNotEmpty) {
                setState(() {
                  _selectedKra = details.goalReviews.first.kras;
                });
              }
            },
            orElse: () {},
          );
        },
        child: Scaffold(
          backgroundColor: AppColors.background,
          resizeToAvoidBottomInset: true,
          appBar: const ReviewHeader(),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.only(
                      bottom: 120,
                    ), // Space for sticky footer
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EmployeeHeroSection(
                          name: widget.employeeName,
                          empId: widget.employeeId,
                          department: widget.department,
                          status: widget.status,
                        ),
                        KraNavigation(
                          selectedKra: _selectedKra,
                          onKraSelected: (kra) {
                            setState(() {
                              _selectedKra = kra;
                            });
                          },
                        ),
                        DetailedReviewSection(selectedKra: _selectedKra),
                        // const TimelineSection(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomSheet: MediaQuery.of(context).viewInsets.bottom > 0
              ? null
              : ReviewFooter(status: widget.evaluationStatus),
        ),
      ),
    );
  }
}
