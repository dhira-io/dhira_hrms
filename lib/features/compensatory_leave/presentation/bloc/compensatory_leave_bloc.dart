import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/core/services/local_storage_service.dart';
import 'package:dhira_hrms/features/timesheet/domain/usecases/get_projects_usecase.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/entities/compensatory_leave_request_entity.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/entities/compensatory_leave_summary_entity.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/entities/compensatory_leave_timesheet_detail_entity.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/usecases/get_compensatory_leave_summary_usecase.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/usecases/get_compensatory_leave_eligible_dates_usecase.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/usecases/submit_compensatory_leave_request_usecase.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/constants/compensatory_leave_constants.dart';
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
  }) : super(const CompensatoryLeaveState()) {
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
    emit(
      state.copyWith(
        status: CompensatoryLeaveStatus.loading,
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
    final empId = localStorageService.getEmpId() ?? '';
    if (empId.isEmpty) {
      emit(
        state.copyWith(
          status: CompensatoryLeaveStatus.failure,
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
          state.copyWith(
            status: CompensatoryLeaveStatus.failure,
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
              state.copyWith(
                status: CompensatoryLeaveStatus.failure,
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
                  state.copyWith(
                    status: CompensatoryLeaveStatus.failure,
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
                  state.copyWith(
                    status: CompensatoryLeaveStatus.loaded,
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

  CompensatoryLeaveState _ensureNonErrorState(
    CompensatoryLeaveState currentState,
  ) {
    if (currentState.status == CompensatoryLeaveStatus.failure) {
      return currentState.copyWith(
        status: CompensatoryLeaveStatus.loaded,
        errorMessage: null,
      );
    }
    return currentState;
  }

  void _onDateSelected(
    CompensatoryLeaveDateSelected event,
    Emitter<CompensatoryLeaveState> emit,
  ) {
    final selectedDate = event.date;
    final currentState = _ensureNonErrorState(state);
    emit(
      currentState.copyWith(
        selectedDate: selectedDate,
        workedHours: selectedDate?.workedHours ?? 0.0,
        workType: selectedDate?.workType ?? currentState.workType,
      ),
    );
  }

  void _onProjectSelected(
    CompensatoryLeaveProjectSelected event,
    Emitter<CompensatoryLeaveState> emit,
  ) {
    final selectedProject = event.project;
    final currentState = _ensureNonErrorState(state);
    emit(currentState.copyWith(selectedProject: selectedProject));
  }

  void _onTimesheetFillChanged(
    CompensatoryLeaveTimesheetFillChanged event,
    Emitter<CompensatoryLeaveState> emit,
  ) {
    final currentState = _ensureNonErrorState(state);
    emit(currentState.copyWith(timesheetFill: event.type));
  }

  void _onTaskDescriptionChanged(
    CompensatoryLeaveTaskDescriptionChanged event,
    Emitter<CompensatoryLeaveState> emit,
  ) {
    final currentState = _ensureNonErrorState(state);
    emit(currentState.copyWith(taskDescription: event.description));
  }

  void _onReasonChanged(
    CompensatoryLeaveReasonChanged event,
    Emitter<CompensatoryLeaveState> emit,
  ) {
    final currentState = _ensureNonErrorState(state);
    emit(currentState.copyWith(reason: event.reason));
  }

  void _onWorkTypeChanged(
    CompensatoryLeaveWorkTypeChanged event,
    Emitter<CompensatoryLeaveState> emit,
  ) {
    final currentState = _ensureNonErrorState(state);
    emit(currentState.copyWith(workType: event.type));
  }

  Future<void> _onSubmitRequested(
    CompensatoryLeaveSubmitRequested event,
    Emitter<CompensatoryLeaveState> emit,
  ) async {
    // Clear any previous error state so that BlocListener can trigger again if the exact same error happens.
    emit(
      state.copyWith(
        status: CompensatoryLeaveStatus.loaded,
        errorMessage: null,
      ),
    );

    final previous = state;
    final empId = localStorageService.getEmpId() ?? '';

    if (state.selectedDate == null) {
      emit(
        state.copyWith(
          status: CompensatoryLeaveStatus.failure,
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

    if (state.timesheetFill == CompensatoryLeaveConstants.timesheetFillManual &&
        state.selectedProject == null) {
      emit(
        state.copyWith(
          status: CompensatoryLeaveStatus.failure,
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

    if (state.timesheetFill == CompensatoryLeaveConstants.timesheetFillManual &&
        state.taskDescription.trim().isEmpty) {
      emit(
        state.copyWith(
          status: CompensatoryLeaveStatus.failure,
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
          errorMessage: "Please enter a task/work description",
        ),
      );
      return;
    }

    if (state.reason.trim().isEmpty) {
      emit(
        state.copyWith(
          status: CompensatoryLeaveStatus.failure,
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

    emit(state.copyWith(isActionLoading: true));

    final empName =
        localStorageService.getEmpName() ??
        localStorageService.getUserFullname() ??
        '';

    final requestEntity = CompensatoryLeaveRequestEntity(
      customAutofill:
          state.timesheetFill == CompensatoryLeaveConstants.timesheetFillManual
          ? "0"
          : "1",
      customTimesheetDetails:
          state.timesheetFill == CompensatoryLeaveConstants.timesheetFillManual
          ? [
              CompensatoryLeaveTimesheetDetailEntity(
                projectActivity: state.selectedProject?.name ?? '',
                task: state.taskDescription,
                reasonForExtraWork: state.reason,
                spentHours: state.workedHours,
              ),
            ]
          : [],
      customWorkType:
          state.workType == CompensatoryLeaveConstants.workTypeHoliday
          ? CompensatoryLeaveConstants.workTypePayloadHoliday
          : state.workType == CompensatoryLeaveConstants.workTypeOvertime
          ? CompensatoryLeaveConstants.workTypePayloadOvertime
          : CompensatoryLeaveConstants.workTypePayloadWeekend,
      employee: empId,
      employeeName: empName,
      leaveType: 'Compensatory Off',
      reason:
          state.timesheetFill == CompensatoryLeaveConstants.timesheetFillAuto &&
              state.reason.isEmpty
          ? CompensatoryLeaveConstants.autoFilledReason
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
        emit(previous.copyWith(isActionLoading: false));
        emit(
          state.copyWith(
            status: CompensatoryLeaveStatus.failure,
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
        emit(
          state.copyWith(
            status: CompensatoryLeaveStatus.success,
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
