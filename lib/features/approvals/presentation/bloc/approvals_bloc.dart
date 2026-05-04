import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/approval_type.dart';
import '../../domain/entities/approval_request_entity.dart';
import '../../domain/usecases/get_approvals_access_usecase.dart';
import '../../domain/usecases/get_approvals_summary_usecase.dart';
import '../../domain/usecases/get_pending_requests_usecase.dart';
import '../../domain/usecases/submit_leave_workflow_action_usecase.dart';
import '../../domain/usecases/submit_attendance_workflow_action_usecase.dart';
import '../../domain/usecases/submit_timesheet_workflow_action_usecase.dart';
import '../../domain/usecases/submit_comp_off_workflow_action_usecase.dart';
import '../../domain/usecases/add_comment_usecase.dart';
import '../../domain/usecases/get_comments_usecase.dart';
import '../../../../features/timesheet/domain/usecases/get_timesheet_details_usecase.dart';
import '../../../../features/timesheet/domain/usecases/sync_timesheet_week_wise_usecase.dart';
import '../../../../features/timesheet/domain/usecases/get_projects_usecase.dart';
import '../../../../features/timesheet/domain/usecases/get_employees_usecase.dart';
import '../../../../features/timesheet/domain/entities/project_entity.dart';
import '../../../../features/timesheet/domain/usecases/delete_timesheet_usecase.dart';
import 'approvals_event.dart';
import 'approvals_state.dart';

class ApprovalsBloc extends Bloc<ApprovalsEvent, ApprovalsState> {
  final GetApprovalsAccessUseCase getApprovalsAccessUseCase;
  final GetApprovalsSummaryUseCase getApprovalsSummaryUseCase;
  final GetPendingRequestsUseCase getPendingRequestsUseCase;
  final SubmitLeaveWorkflowActionUseCase submitLeaveWorkflowActionUseCase;
  final SubmitAttendanceWorkflowActionUseCase submitAttendanceWorkflowActionUseCase;
  final SubmitTimesheetWorkflowActionUseCase submitTimesheetWorkflowActionUseCase;
  final SubmitCompOffWorkflowActionUseCase submitCompOffWorkflowActionUseCase;
  final AddCommentUseCase addCommentUseCase;
  final GetCommentsUseCase getCommentsUseCase;
  final GetTimesheetDetailsUseCase getTimesheetDetailsUseCase;
  final SyncTimesheetWeekWiseUseCase syncTimesheetWeekWiseUseCase;
  final GetProjectsUseCase getProjectsUseCase;
  final GetEmployeesUseCase getEmployeesUseCase;
  final DeleteTimesheetUseCase deleteTimesheetUseCase;

  ApprovalsBloc({
    required this.getApprovalsAccessUseCase,
    required this.getApprovalsSummaryUseCase,
    required this.getPendingRequestsUseCase,
    required this.submitLeaveWorkflowActionUseCase,
    required this.submitAttendanceWorkflowActionUseCase,
    required this.submitTimesheetWorkflowActionUseCase,
    required this.submitCompOffWorkflowActionUseCase,
    required this.addCommentUseCase,
    required this.getCommentsUseCase,
    required this.getTimesheetDetailsUseCase,
    required this.syncTimesheetWeekWiseUseCase,
    required this.getProjectsUseCase,
    required this.getEmployeesUseCase,
    required this.deleteTimesheetUseCase,
  }) : super(const ApprovalsState.initial()) {
    on<Started>(_onStarted);
    on<CategoryChanged>(_onCategoryChanged);
    on<RefreshSummary>(_onRefreshSummary);
    on<WorkflowActionSubmitted>(_onWorkflowActionSubmitted);
    on<CommentSubmitted>(_onCommentSubmitted);
    on<CommentsRequested>(_onCommentsRequested);
    on<EditTimesheetRequested>(_onEditTimesheetRequested);
    on<UpdateTimesheetRequested>(_onUpdateTimesheetRequested);
    on<DeleteTimesheetRequested>(_onDeleteTimesheetRequested);
  }

  Future<void> _onStarted(Started event, Emitter<ApprovalsState> emit) async {
    emit(const ApprovalsState.loading());

    final accessResult = await getApprovalsAccessUseCase();

    await accessResult.fold(
          (failure) async => emit(ApprovalsState.failure(failure.message)),
          (access) async {
        final summaryResult = await getApprovalsSummaryUseCase();

        await summaryResult.fold(
              (failure) async => emit(ApprovalsState.failure(failure.message)),
              (summary) async {
            // If user is not an approver (can_access: false), default to
            // their own Raised requests so the list is never empty on first load.
            final defaultCategory = access.canAccess
                ? ApprovalCategory.team
                : ApprovalCategory.raised;

            // Initial emit with empty list and loading flag
            emit(ApprovalsState.success(
              access: access,
              summary: summary,
              isListLoading: true,
              requests: [],
            ));

            final requestsResult = await getPendingRequestsUseCase(
              ApprovalType.leave,
              defaultCategory,
            );

            requestsResult.fold(
                  (failure) => emit(ApprovalsState.failure(failure.message)),
                  (requests) => emit(ApprovalsState.success(
                access: access,
                summary: summary,
                requests: requests,
                isListLoading: false,
              )),
            );
          },
        );
      },
    );
  }

  Future<void> _onCategoryChanged(CategoryChanged event, Emitter<ApprovalsState> emit) async {
    // Correctly accessing the Success state using state.maybeMap or state.map
    await state.maybeMap(
      success: (currentState) async {
        // 1. Show shimmer by clearing list and setting loading true
        emit(currentState.copyWith(
          isListLoading: true,
          requests: [],
          successMessage: null,
          errorMessage: null,
        ));

        // 2. Fetch requests based on UI selection (Team/Raised + Type)
        final requestsResult = await getPendingRequestsUseCase(
          event.type,
          event.category,
        );

        requestsResult.fold(
              (failure) => emit(ApprovalsState.failure(failure.message)),
              (requests) => emit(currentState.copyWith(
            requests: requests,
            isListLoading: false,
            successMessage: null,
            errorMessage: null,
          )),
        );
      },
      orElse: () {},
    );
  }

  Future<void> _onRefreshSummary(RefreshSummary event, Emitter<ApprovalsState> emit) async {
    await state.maybeMap(
      success: (currentState) async {
        final summaryResult = await getApprovalsSummaryUseCase();

        summaryResult.fold(
              (_) => null, // Ignore background errors to keep UI stable
              (newSummary) => emit(currentState.copyWith(summary: newSummary)),
        );
      },
      orElse: () {},
    );
  }

  Future<void> _onWorkflowActionSubmitted(WorkflowActionSubmitted event, Emitter<ApprovalsState> emit) async {
    await state.maybeMap(
      success: (currentState) async {
        // 1. Optional: Show loading on the card or global shimmer?
        // For now, let's just trigger the use case. 
        
        late final dynamic result;
        if (event.type == ApprovalType.leave) {
          result = await submitLeaveWorkflowActionUseCase(event.requestId, event.action);
        } else if (event.type == ApprovalType.attendance) {
          result = await submitAttendanceWorkflowActionUseCase(event.requestId, event.action);
        } else if (event.type == ApprovalType.timesheet) {
          result = await submitTimesheetWorkflowActionUseCase(event.requestId, event.action);
        } else if (event.type == ApprovalType.compOff) {
          result = await submitCompOffWorkflowActionUseCase(event.requestId, event.action);
        } else {
          // Fallback for types not yet implemented
          return;
        }

        await result.fold(
          (failure) async {
            emit(currentState); 
          },
          (_) async {
            // Action success! 
            // 2. Refresh the summary
            final summaryResult = await getApprovalsSummaryUseCase();
            final newSummary = summaryResult.getOrElse(() => currentState.summary);

            // 3. Refresh the current list to remove the processed item
            final requestsResult = await getPendingRequestsUseCase(
              event.type,
              event.category,
            );

            requestsResult.fold(
              (failure) => emit(ApprovalsState.failure(failure.message)),
              (requests) => emit(currentState.copyWith(
                summary: newSummary,
                requests: requests,
                isListLoading: false,
              )),
            );
          },
        );
      },
      orElse: () {},
    );
  }

  Future<void> _onCommentSubmitted(CommentSubmitted event, Emitter<ApprovalsState> emit) async {
    await state.maybeMap(
      success: (currentState) async {
        final result = await addCommentUseCase(
          event.type.doctype,
          event.requestId,
          event.comment,
        );

        result.fold(
          (failure) => null, // TODO: Show error toast
          (_) => null, // TODO: Show success toast
        );
      },
      orElse: () {},
    );
  }

  Future<void> _onCommentsRequested(CommentsRequested event, Emitter<ApprovalsState> emit) async {
    final currentState = state;
    if (currentState is! Success) return;

    emit(currentState.copyWith(isCommentsLoading: true, comments: []));

    final result = await getCommentsUseCase(event.doctype, event.requestId);

    result.fold(
      (failure) => emit(currentState.copyWith(isCommentsLoading: false)),
      (comments) => emit(currentState.copyWith(
        isCommentsLoading: false,
        comments: comments,
      )),
    );
  }

  Future<void> _onEditTimesheetRequested(EditTimesheetRequested event, Emitter<ApprovalsState> emit) async {
    final currentState = state;
    if (currentState is! Success) return;

    emit(currentState.copyWith(
      isTimesheetLoading: true,
      successMessage: null,
      errorMessage: null,
    ));

    final results = await Future.wait([
      getTimesheetDetailsUseCase(event.requestId),
      getProjectsUseCase(),
      getEmployeesUseCase(),
    ]);

    final timesheetResult = results[0] as dynamic;
    final projectsResult = results[1] as dynamic;
    final employeesResult = results[2] as dynamic;

    timesheetResult.fold(
      (failure) => emit(currentState.copyWith(isTimesheetLoading: false, errorMessage: failure.message)),
      (timesheet) {
        final projects = projectsResult.getOrElse(() => <ProjectEntity>[]);
        final employees = employeesResult.getOrElse(() => <Map<String, dynamic>>[]);

        emit(currentState.copyWith(
          isTimesheetLoading: false,
          editingTimesheet: timesheet,
          projects: projects,
          employees: employees,
        ));
      },
    );
  }

  Future<void> _onUpdateTimesheetRequested(UpdateTimesheetRequested event, Emitter<ApprovalsState> emit) async {
    final currentState = state;
    if (currentState is! Success) return;

    emit(currentState.copyWith(
      isTimesheetLoading: true,
      successMessage: null,
      errorMessage: null,
    ));

    final result = await syncTimesheetWeekWiseUseCase(event.payload);

    result.fold(
      (failure) => emit(currentState.copyWith(isTimesheetLoading: false, errorMessage: failure.message)),
      (success) async {
        if (success) {
          add(const ApprovalsEvent.categoryChanged(ApprovalType.timesheet, ApprovalCategory.raised));
          emit(currentState.copyWith(isTimesheetLoading: false, editingTimesheet: null, successMessage: "Timesheet updated successfully"));
        } else {
          emit(currentState.copyWith(isTimesheetLoading: false, errorMessage: "Failed to update timesheet"));
        }
      },
    );
  }

  Future<void> _onDeleteTimesheetRequested(DeleteTimesheetRequested event, Emitter<ApprovalsState> emit) async {
    final currentState = state;
    if (currentState is! Success) return;

    emit(currentState.copyWith(
      isTimesheetLoading: true,
      successMessage: null,
      errorMessage: null,
    ));

    final result = await deleteTimesheetUseCase(event.requestId);

    result.fold(
      (failure) => emit(currentState.copyWith(isTimesheetLoading: false, errorMessage: failure.message)),
      (success) async {
        if (success) {
          add(const ApprovalsEvent.categoryChanged(ApprovalType.timesheet, ApprovalCategory.raised));
          emit(currentState.copyWith(isTimesheetLoading: false, successMessage: "Timesheet deleted successfully"));
        } else {
          emit(currentState.copyWith(isTimesheetLoading: false, errorMessage: "Failed to delete timesheet"));
        }
      },
    );
  }
}