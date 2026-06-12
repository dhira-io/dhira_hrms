import 'dart:developer' as developer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/core/services/local_storage_service.dart';
import 'package:dhira_hrms/features/timesheet/domain/usecases/get_projects_usecase.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/entities/compensatory_leave_request_entity.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/entities/compensatory_leave_summary_entity.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/entities/compensatory_leave_timesheet_detail_entity.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/usecases/get_compensatory_leave_summary_usecase.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/usecases/get_compensatory_leave_eligible_dates_usecase.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/usecases/submit_compensatory_leave_request_usecase.dart';
import 'package:dhira_hrms/features/compensatory_leave/presentation/bloc/compensatory_leave_event.dart';
import 'package:dhira_hrms/features/compensatory_leave/presentation/bloc/compensatory_leave_state.dart';

class CompensatoryLeaveBloc
    extends Bloc<CompensatoryLeaveEvent, CompensatoryLeaveState> {
  final GetCompensatoryLeaveSummaryUseCase getCompensatoryLeaveSummaryUseCase;
  final GetCompensatoryLeaveEligibleDatesUseCase
  getCompensatoryLeaveEligibleDatesUseCase;
  final SubmitCompensatoryLeaveRequestUseCase
  submitCompensatoryLeaveRequestUseCase;
  final LocalStorageService localStorageService;
  final GetProjectsUseCase getProjectsUseCase;

  CompensatoryLeaveBloc({
    required this.getCompensatoryLeaveSummaryUseCase,
    required this.getCompensatoryLeaveEligibleDatesUseCase,
    required this.submitCompensatoryLeaveRequestUseCase,
    required this.localStorageService,
    required this.getProjectsUseCase,
  }) : super(const CompensatoryLeaveState.initial()) {
    on<CompensatoryLeaveStarted>(_onStarted);
    on<CompensatoryLeaveFetchRequested>(_onFetchRequested);
    on<CompensatoryLeaveDateSelected>(_onDateSelected);
    on<CompensatoryLeaveProjectSelected>(_onProjectSelected);
    on<CompensatoryLeaveTimesheetFillChanged>(_onTimesheetFillChanged);
    on<CompensatoryLeaveTaskDescriptionChanged>(_onTaskDescriptionChanged);
    on<CompensatoryLeaveReasonChanged>(_onReasonChanged);
    on<CompensatoryLeaveWorkTypeChanged>(_onWorkTypeChanged);
    on<CompensatoryLeaveSubmitRequested>(_onSubmitRequested);
  }

  Future<void> _onStarted(
    CompensatoryLeaveStarted event,
    Emitter<CompensatoryLeaveState> emit,
  ) async {
    developer.log(
      "CompensatoryLeaveBloc: Started with ID = ${event.compensatoryLeaveId}",
    );
    emit(
      CompensatoryLeaveState.loading(
        initialCompensatoryLeaveId: event.compensatoryLeaveId,
        summary: state.summary,
        eligibleDates: state.eligibleDates,
        timesheetFill: state.timesheetFill,
        taskDescription: state.taskDescription,
        reason: state.reason,
        workType: state.workType,
        workedHours: state.workedHours,
        projects: state.projects,
        selectedProject: state.selectedProject,
      ),
    );
    add(const CompensatoryLeaveEvent.fetchRequested());
  }

  Future<void> _onFetchRequested(
    CompensatoryLeaveFetchRequested event,
    Emitter<CompensatoryLeaveState> emit,
  ) async {
    developer.log("CompensatoryLeaveBloc: Fetch requested");
    final empId = localStorageService.getEmpId() ?? '';
    if (empId.isEmpty) {
      emit(
        CompensatoryLeaveState.error(
          initialCompensatoryLeaveId: state.initialCompensatoryLeaveId,
          summary: state.summary,
          eligibleDates: state.eligibleDates,
          timesheetFill: state.timesheetFill,
          taskDescription: state.taskDescription,
          reason: state.reason,
          workType: state.workType,
          workedHours: state.workedHours,
          projects: state.projects,
          selectedProject: state.selectedProject,
          errorMessage: "Employee ID not found",
        ),
      );
      return;
    }

    final summaryResult = await getCompensatoryLeaveSummaryUseCase(empId);
    final datesResult = await getCompensatoryLeaveEligibleDatesUseCase(empId);
    final projectsResult = await getProjectsUseCase();

    summaryResult.fold(
      (failure) {
        emit(
          CompensatoryLeaveState.error(
            initialCompensatoryLeaveId: state.initialCompensatoryLeaveId,
            summary: state.summary,
            eligibleDates: state.eligibleDates,
            timesheetFill: state.timesheetFill,
            taskDescription: state.taskDescription,
            reason: state.reason,
            workType: state.workType,
            workedHours: state.workedHours,
            projects: state.projects,
            selectedProject: state.selectedProject,
            errorMessage: failure.message,
          ),
        );
      },
      (summary) {
        datesResult.fold(
          (failure) {
            emit(
              CompensatoryLeaveState.error(
                initialCompensatoryLeaveId: state.initialCompensatoryLeaveId,
                summary: summary,
                eligibleDates: state.eligibleDates,
                timesheetFill: state.timesheetFill,
                taskDescription: state.taskDescription,
                reason: state.reason,
                workType: state.workType,
                workedHours: state.workedHours,
                projects: state.projects,
                selectedProject: state.selectedProject,
                errorMessage: failure.message,
              ),
            );
          },
          (dates) {
            projectsResult.fold(
              (failure) {
                emit(
                  CompensatoryLeaveState.error(
                    initialCompensatoryLeaveId:
                        state.initialCompensatoryLeaveId,
                    summary: summary,
                    eligibleDates: dates,
                    timesheetFill: state.timesheetFill,
                    taskDescription: state.taskDescription,
                    reason: state.reason,
                    workType: state.workType,
                    workedHours: state.workedHours,
                    projects: state.projects,
                    selectedProject: state.selectedProject,
                    errorMessage: failure.message,
                  ),
                );
              },
              (projects) {
                emit(
                  CompensatoryLeaveState.loaded(
                    initialCompensatoryLeaveId:
                        state.initialCompensatoryLeaveId,
                    summary: summary,
                    eligibleDates: dates,
                    timesheetFill: state.timesheetFill,
                    taskDescription: state.taskDescription,
                    reason: state.reason,
                    workType: state.workType,
                    workedHours: state.workedHours,
                    projects: projects,
                    selectedProject: state.selectedProject,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  void _onDateSelected(
    CompensatoryLeaveDateSelected event,
    Emitter<CompensatoryLeaveState> emit,
  ) {
    developer.log("CompensatoryLeaveBloc: Date selected = ${event.date?.date}");
    final selectedDate = event.date;
    emit(
      state.maybeMap(
        loaded: (s) => s.copyWith(
          selectedDate: selectedDate,
          workedHours: selectedDate?.workedHours ?? 0.0,
          workType: selectedDate?.workType ?? s.workType,
        ),
        success: (s) => s.copyWith(
          selectedDate: selectedDate,
          workedHours: selectedDate?.workedHours ?? 0.0,
          workType: selectedDate?.workType ?? s.workType,
        ),
        orElse: () => state,
      ),
    );
  }

  void _onProjectSelected(
    CompensatoryLeaveProjectSelected event,
    Emitter<CompensatoryLeaveState> emit,
  ) {
    developer.log(
      "CompensatoryLeaveBloc: Project selected = ${event.project?.projectName}",
    );
    final selectedProject = event.project;
    emit(
      state.maybeMap(
        loaded: (s) => s.copyWith(selectedProject: selectedProject),
        success: (s) => s.copyWith(selectedProject: selectedProject),
        orElse: () => state,
      ),
    );
  }

  void _onTimesheetFillChanged(
    CompensatoryLeaveTimesheetFillChanged event,
    Emitter<CompensatoryLeaveState> emit,
  ) {
    developer.log(
      "CompensatoryLeaveBloc: Timesheet fill changed = ${event.type}",
    );
    emit(
      state.maybeMap(
        loaded: (s) => s.copyWith(timesheetFill: event.type),
        success: (s) => s.copyWith(timesheetFill: event.type),
        orElse: () => state,
      ),
    );
  }

  void _onTaskDescriptionChanged(
    CompensatoryLeaveTaskDescriptionChanged event,
    Emitter<CompensatoryLeaveState> emit,
  ) {
    emit(
      state.maybeMap(
        loaded: (s) => s.copyWith(taskDescription: event.description),
        success: (s) => s.copyWith(taskDescription: event.description),
        orElse: () => state,
      ),
    );
  }

  void _onReasonChanged(
    CompensatoryLeaveReasonChanged event,
    Emitter<CompensatoryLeaveState> emit,
  ) {
    emit(
      state.maybeMap(
        loaded: (s) => s.copyWith(reason: event.reason),
        success: (s) => s.copyWith(reason: event.reason),
        orElse: () => state,
      ),
    );
  }

  void _onWorkTypeChanged(
    CompensatoryLeaveWorkTypeChanged event,
    Emitter<CompensatoryLeaveState> emit,
  ) {
    developer.log("CompensatoryLeaveBloc: Work type changed = ${event.type}");
    emit(
      state.maybeMap(
        loaded: (s) => s.copyWith(workType: event.type),
        success: (s) => s.copyWith(workType: event.type),
        orElse: () => state,
      ),
    );
  }

  Future<void> _onSubmitRequested(
    CompensatoryLeaveSubmitRequested event,
    Emitter<CompensatoryLeaveState> emit,
  ) async {
    developer.log("CompensatoryLeaveBloc: Submit requested");
    final previous = state;
    final empId = localStorageService.getEmpId() ?? '';

    if (state.selectedDate == null) {
      emit(
        CompensatoryLeaveState.error(
          initialCompensatoryLeaveId: state.initialCompensatoryLeaveId,
          summary: state.summary,
          eligibleDates: state.eligibleDates,
          selectedDate: state.selectedDate,
          timesheetFill: state.timesheetFill,
          taskDescription: state.taskDescription,
          reason: state.reason,
          workType: state.workType,
          workedHours: state.workedHours,
          projects: state.projects,
          selectedProject: state.selectedProject,
          errorMessage: "Please select a work date",
        ),
      );
      return;
    }

    if (state.timesheetFill == 'manual' && state.selectedProject == null) {
      emit(
        CompensatoryLeaveState.error(
          initialCompensatoryLeaveId: state.initialCompensatoryLeaveId,
          summary: state.summary,
          eligibleDates: state.eligibleDates,
          selectedDate: state.selectedDate,
          timesheetFill: state.timesheetFill,
          taskDescription: state.taskDescription,
          reason: state.reason,
          workType: state.workType,
          workedHours: state.workedHours,
          projects: state.projects,
          selectedProject: state.selectedProject,
          errorMessage: "Please select a project",
        ),
      );
      return;
    }

    if (state.timesheetFill == 'manual' && state.reason.trim().isEmpty) {
      emit(
        CompensatoryLeaveState.error(
          initialCompensatoryLeaveId: state.initialCompensatoryLeaveId,
          summary: state.summary,
          eligibleDates: state.eligibleDates,
          selectedDate: state.selectedDate,
          timesheetFill: state.timesheetFill,
          taskDescription: state.taskDescription,
          reason: state.reason,
          workType: state.workType,
          workedHours: state.workedHours,
          projects: state.projects,
          selectedProject: state.selectedProject,
          errorMessage: "Please enter a reason for extra work",
        ),
      );
      return;
    }

    emit(
      state.maybeMap(
        loaded: (s) => s.copyWith(isActionLoading: true),
        orElse: () => state,
      ),
    );

    final empName =
        localStorageService.getEmpName() ??
        localStorageService.getUserFullname() ??
        '';

    final requestEntity = CompensatoryLeaveRequestEntity(
      customAutofill: state.timesheetFill == 'manual' ? "0" : "1",
      customTimesheetDetails: state.timesheetFill == 'manual'
          ? [
              CompensatoryLeaveTimesheetDetailEntity(
                projectActivity: state.selectedProject?.name ?? '',
                task: state.taskDescription,
                reasonForExtraWork: state.reason,
                spentHours: state.workedHours,
              ),
            ]
          : [],
      customWorkType: state.workType == 'Holiday'
          ? 'Holiday Work'
          : 'Weekend Work',
      employee: empId,
      employeeName: empName,
      leaveType: 'Compensatory Off',
      reason: state.timesheetFill == 'auto' && state.reason.isEmpty
          ? "Auto-filled reason"
          : state.reason,
      workEndDate: state.selectedDate!.date,
      workFromDate: state.selectedDate!.date,
    );

    final result = await submitCompensatoryLeaveRequestUseCase(
      employeeId: empId,
      request: requestEntity,
    );

    result.fold(
      (failure) {
        developer.log(
          "CompensatoryLeaveBloc: Submit failed: ${failure.message}",
        );
        emit(
          previous.maybeMap(
            loaded: (s) => s.copyWith(isActionLoading: false),
            orElse: () => previous,
          ),
        );
        emit(
          CompensatoryLeaveState.error(
            initialCompensatoryLeaveId: state.initialCompensatoryLeaveId,
            summary: state.summary,
            eligibleDates: state.eligibleDates,
            selectedDate: state.selectedDate,
            timesheetFill: state.timesheetFill,
            taskDescription: state.taskDescription,
            reason: state.reason,
            workType: state.workType,
            workedHours: state.workedHours,
            projects: state.projects,
            selectedProject: state.selectedProject,
            errorMessage: failure.message,
          ),
        );
      },
      (success) {
        developer.log("CompensatoryLeaveBloc: Submit succeeded");
        emit(
          CompensatoryLeaveState.success(
            initialCompensatoryLeaveId: state.initialCompensatoryLeaveId,
            summary:
                state.summary ??
                const CompensatoryLeaveSummaryEntity(
                  availableBalance: 0,
                  raisedRequest: 0,
                  expiringSoon: 0,
                ),
            eligibleDates: state.eligibleDates,
            selectedDate: state.selectedDate,
            timesheetFill: state.timesheetFill,
            taskDescription: state.taskDescription,
            reason: state.reason,
            workType: state.workType,
            workedHours: state.workedHours,
            projects: state.projects,
            selectedProject: state.selectedProject,
          ),
        );
      },
    );
  }
}
