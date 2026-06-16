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
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/core/error/failures.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/project_entity.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/entities/compensatory_leave_eligible_date_entity.dart';

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
          errorMessage: CompensatoryLeaveConstants.errorEmployeeIdNotFound,
        ),
      );
      return;
    }

    final results = await Future.wait([
      getCompensatoryLeaveSummaryUseCase(empId),
      getCompensatoryLeaveEligibleDatesUseCase(empId),
      getProjectsUseCase(),
    ]);

    final summaryResult = results[0] as Either<Failure, CompensatoryLeaveSummaryEntity>;
    final datesResult = results[1] as Either<Failure, List<CompensatoryLeaveEligibleDateEntity>>;
    final projectsResult = results[2] as Either<Failure, List<ProjectEntity>>;

    summaryResult.fold(
      (failure) {
        emit(
          state.copyWith(
            status: CompensatoryLeaveStatus.failure,
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
                summary: summary,
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
                    summary: summary,
                    eligibleDates: dates,
                    errorMessage: failure.message,
                  ),
                );
              },
              (projects) {
                emit(
                  state.copyWith(
                    status: CompensatoryLeaveStatus.loaded,
                    summary: summary,
                    eligibleDates: dates,
                    projects: projects,
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
          errorMessage: CompensatoryLeaveConstants.errorPleaseSelectWorkDate,
        ),
      );
      return;
    }

    if (state.timesheetFill == CompensatoryLeaveConstants.timesheetFillManual &&
        state.selectedProject == null) {
      emit(
        state.copyWith(
          status: CompensatoryLeaveStatus.failure,
          errorMessage: CompensatoryLeaveConstants.errorPleaseSelectProject,
        ),
      );
      return;
    }

    if (state.timesheetFill == CompensatoryLeaveConstants.timesheetFillManual &&
        state.taskDescription.trim().isEmpty) {
      emit(
        state.copyWith(
          status: CompensatoryLeaveStatus.failure,
          errorMessage:
              CompensatoryLeaveConstants.errorPleaseEnterTaskDescription,
        ),
      );
      return;
    }

    if (state.reason.trim().isEmpty) {
      emit(
        state.copyWith(
          status: CompensatoryLeaveStatus.failure,
          errorMessage: CompensatoryLeaveConstants.errorPleaseEnterReason,
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
          ? CompensatoryLeaveConstants.customAutofillManual
          : CompensatoryLeaveConstants.customAutofillAuto,
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
      leaveType: CompensatoryLeaveConstants.leaveTypeCompOff,
      reason:
          state.timesheetFill == CompensatoryLeaveConstants.timesheetFillAuto &&
              state.reason.isEmpty
          ? CompensatoryLeaveConstants.autoFilledReason
          : state.reason,
      workEndDate: state.selectedDate!.date,
      workFromDate: state.selectedDate!.date,
    );

    final result = await submitCompensatoryLeaveRequestUseCase(
      request: requestEntity,
    );

    result.fold(
      (failure) {
        emit(previous.copyWith(isActionLoading: false));
        emit(
          state.copyWith(
            status: CompensatoryLeaveStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(
            status: CompensatoryLeaveStatus.success,
            summary:
                state.summary ??
                const CompensatoryLeaveSummaryEntity(
                  availableBalance: 0,
                  raisedRequest: 0,
                  expiringSoon: 0,
                ),
          ),
        );
      },
    );
  }

  static String getLocalizedErrorMessage(String error, AppLocalizations l10n) {
    switch (error) {
      case CompensatoryLeaveConstants.errorEmployeeIdNotFound:
        return l10n.employeeIdNotFound;
      case CompensatoryLeaveConstants.errorPleaseSelectWorkDate:
        return l10n.selectWorkDateError;
      case CompensatoryLeaveConstants.errorPleaseSelectProject:
        return l10n.selectProjectValidation;
      case CompensatoryLeaveConstants.errorPleaseEnterTaskDescription:
        return l10n.taskValidation;
      case CompensatoryLeaveConstants.errorPleaseEnterReason:
        return l10n.enterReasonForExtraWork;
      default:
        return error;
    }
  }
}
