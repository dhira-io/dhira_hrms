import 'package:dhira_hrms/features/approvals/domain/entities/approval_type.dart';
import 'dart:async';
import 'dart:developer' as dev;
import 'package:dhira_hrms/features/approvals/leaveapproval/domain/usecases/submit_leave_workflow_action_usecase.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/approval_request_entity.dart';
import '../../domain/usecases/get_approvals_access_usecase.dart';
import '../../domain/usecases/get_approvals_summary_usecase.dart';
import '../../domain/usecases/get_pending_requests_usecase.dart';
import '../../domain/usecases/submit_attendance_workflow_action_usecase.dart';
import '../../domain/usecases/submit_timesheet_workflow_action_usecase.dart';
import '../../domain/usecases/submit_comp_off_workflow_action_usecase.dart';
import '../../domain/usecases/add_comment_usecase.dart';
import '../../domain/usecases/get_comments_usecase.dart';
import '../../timesheetapproval/domain/usecases/get_timesheet_details_usecase.dart';
import '../../timesheetapproval/domain/usecases/sync_timesheet_week_wise_usecase.dart';
import '../../../../features/timesheet/domain/usecases/get_projects_usecase.dart';
import '../../timesheetapproval/domain/usecases/get_employees_usecase.dart';
import '../../../../features/timesheet/domain/entities/project_entity.dart';
import '../../timesheetapproval/domain/usecases/delete_approval_timesheet_usecase.dart';
import 'approvals_event.dart';
import 'approvals_state.dart';
import 'approvals_success_data.dart';
import '../../data/constants/approvals_api_constants.dart';

class ApprovalsBloc extends Bloc<ApprovalsEvent, ApprovalsState> {
  final GetApprovalsAccessUseCase getApprovalsAccessUseCase;
  final GetApprovalsSummaryUseCase getApprovalsSummaryUseCase;
  final GetPendingRequestsUseCase getPendingRequestsUseCase;
  final SubmitLeaveWorkflowActionUseCase submitLeaveWorkflowActionUseCase;
  final SubmitAttendanceWorkflowActionUseCase
  submitAttendanceWorkflowActionUseCase;
  final SubmitTimesheetWorkflowActionUseCase
  submitTimesheetWorkflowActionUseCase;
  final SubmitCompOffWorkflowActionUseCase submitCompOffWorkflowActionUseCase;
  final AddCommentUseCase addCommentUseCase;
  final GetCommentsUseCase getCommentsUseCase;
  final GetTimesheetDetailsUseCase getTimesheetDetailsUseCase;
  final SyncTimesheetWeekWiseUseCase syncTimesheetWeekWiseUseCase;
  final GetProjectsUseCase getProjectsUseCase;
  final GetEmployeesUseCase getEmployeesUseCase;
  final DeleteApprovalTimesheetUseCase deleteTimesheetUseCase;

  ApprovalCategory? _pendingCategory;
  ApprovalType? _pendingType;

  ApprovalsSuccessData get data => state.data!;

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
  }) : super(const ApprovalsState(status: ApprovalsStatus.initial)) {
    on<Started>(_onStarted);
    on<RefreshRequested>(_onRefreshRequested);
    on<LoadMoreRequested>(_onLoadMoreRequested);
    on<CategoryChanged>(_onCategoryChanged);
    on<RefreshSummary>(_onRefreshSummary);
    on<WorkflowActionSubmitted>(_onWorkflowActionSubmitted);
    on<CommentSubmitted>(_onCommentSubmitted);
    on<CommentsRequested>(_onCommentsRequested);
    on<EditTimesheetRequested>(_onEditTimesheetRequested);
    on<UpdateTimesheetRequested>(_onUpdateTimesheetRequested);
    on<SyncTimesheetRequested>(_onSyncTimesheetRequested);
    on<DeleteTimesheetRequested>(_onDeleteTimesheetRequested);
    on<SearchQueryChanged>(
      _onSearchQueryChanged,
      transformer: _debounce(const Duration(milliseconds: 300)),
    );
    on<StatusFilterChanged>(_onStatusFilterChanged);
    on<RequestSelectionToggled>(_onRequestSelectionToggled);
    on<SelectAllToggled>(_onSelectAllToggled);
    on<BulkWorkflowActionSubmitted>(_onBulkWorkflowActionSubmitted);
    on<ClearMessages>(_onClearMessages);
  }

  Future<void> _onStarted(Started event, Emitter<ApprovalsState> emit) async {
    emit(const ApprovalsState(status: ApprovalsStatus.loading));

    final results = await Future.wait([
      getApprovalsAccessUseCase() as Future<dynamic>,
      getApprovalsSummaryUseCase() as Future<dynamic>,
      getEmployeesUseCase() as Future<dynamic>,
    ]);

    final accessResult = results[0];
    final summaryResult = results[1];
    final employeesResult = results[2];

    String? errorMessage;
    dynamic access;
    dynamic summary;

    accessResult.fold(
      (f) => errorMessage = f.message,
      (a) => access = a,
    );
    if (errorMessage != null) {
      emit(ApprovalsState(status: ApprovalsStatus.failure, errorMessage: errorMessage!));
      return;
    }

    summaryResult.fold(
      (f) => errorMessage = f.message,
      (s) => summary = s,
    );
    if (errorMessage != null) {
      emit(ApprovalsState(status: ApprovalsStatus.failure, errorMessage: errorMessage!));
      return;
    }

    final employees = employeesResult.getOrElse(() => <Map<String, dynamic>>[]);

    // If user is not an approver (can_access: false), default to
    // their own Raised requests so the list is never empty on first load.
    final defaultCategory =
        _pendingCategory ??
        event.initialCategory ??
        (access.canAccess
            ? ApprovalCategory.team
            : ApprovalCategory.raised);

    final defaultType =
        _pendingType ?? event.initialType ?? ApprovalType.leave;

    // Clear the pending values
    _pendingCategory = null;
    _pendingType = null;

    // Initial emit with empty list and loading flag
    emit(
      ApprovalsState(status: ApprovalsStatus.success, data: 
        ApprovalsSuccessData(
          access: access,
          summary: summary,
          category: defaultCategory,
          isListLoading: true,
          requests: [],
          employees: employees,
          targetCategory: defaultCategory,
          type: defaultType,
          targetType: defaultType,
        ),
      ),
    );

    final requestsResult = await getPendingRequestsUseCase(
      defaultType,
      defaultCategory,
      page: 1,
    );

    requestsResult.fold(
      (failure) {
        emit(
          ApprovalsState(status: ApprovalsStatus.success, data: 
            ApprovalsSuccessData(
              access: access,
              summary: summary,
              category: defaultCategory,
              isListLoading: false,
              requests: [],
              employees: employees,
              targetCategory: defaultCategory,
              type: defaultType,
              targetType: defaultType,
              hasMore: false,
            ),
          ),
        );
      },
      (models) {
        emit(
          ApprovalsState(status: ApprovalsStatus.success, data: 
            ApprovalsSuccessData(
              access: access,
              summary: summary,
              category: defaultCategory,
              isListLoading: false,
              requests: models,
              employees: employees,
              targetCategory: defaultCategory,
              type: defaultType,
              targetType: defaultType,
              page: 1,
              hasMore: models.length >= 10,
            ),
          ),
        );
      },
    );
  }

  Future<void> _onRefreshRequested(
    RefreshRequested event,
    Emitter<ApprovalsState> emit,
  ) async {
    final currentState = state;
    if (currentState.status != ApprovalsStatus.success || currentState.data == null) {
      event.completer?.complete();
      return;
    }

    try {
      // Fetch summary and current list data in parallel
      final results = await Future.wait([
        getApprovalsSummaryUseCase(),
        getPendingRequestsUseCase(
          data.type,
          data.category,
          page: 1,
        ),
      ]);

      final summaryResult = results[0] as dynamic;
      final requestsResult = results[1] as dynamic;

      final newSummary = summaryResult.fold(
        (failure) => data.summary,
        (summary) => summary,
      );

      final newRequests = requestsResult.fold(
        (failure) => data.requests,
        (requests) => requests,
      );

      if (state.status == ApprovalsStatus.success && state.data != null) {
        final latestSuccessState = state;
        emit(
          ApprovalsState(status: ApprovalsStatus.success, data: 
            latestSuccessState.data!.copyWith(
              summary: newSummary,
              requests: _sortRequests(newRequests),
              isListLoading: false, // Ensure shimmer is off
              page: 1,
              hasMore: requestsResult.isRight()
                  ? requestsResult
                            .getOrElse(() => <ApprovalRequestEntity>[])
                            .length >=
                        10
                  : data.hasMore,
              successMessage: null,
              errorMessage: requestsResult.isLeft()
                  ? requestsResult.fold((f) => f.message, (_) => null)
                  : null,
            ),
          ),
        );
      }
    } catch (e, stackTrace) {
      dev.log(
        'Error in _onRefreshRequested: $e',
        stackTrace: stackTrace,
        name: 'ApprovalsBloc',
      );

      if (state.status == ApprovalsStatus.success && state.data != null) {
        final latestSuccessState = state;
        emit(
          ApprovalsState(status: ApprovalsStatus.success, data: 
            latestSuccessState.data!.copyWith(
              isListLoading: false,
              errorMessage: '${ApprovalsApiConstants.msgFailedToRefreshPrefix}$e',
            ),
          ),
        );
      }
    } finally {
      event.completer?.complete();
    }
  }

  Future<void> _onLoadMoreRequested(
    LoadMoreRequested event,
    Emitter<ApprovalsState> emit,
  ) async {
    if (state.status != ApprovalsStatus.success || state.data == null) return;

    if (data.isLoadMoreLoading || !data.hasMore) {
      return;
    }

    emit(
      ApprovalsState(status: ApprovalsStatus.success, data: 
        data.copyWith(isLoadMoreLoading: true),
      ),
    );

    final nextPage = data.page + 1;
    final requestsResult = await getPendingRequestsUseCase(
      data.type,
      data.category,
      page: nextPage,
    );

    requestsResult.fold(
      (failure) {
        if (state.status == ApprovalsStatus.success && state.data != null) {
          final latestSuccessState = state;
          emit(
            ApprovalsState(status: ApprovalsStatus.success, data: 
              latestSuccessState.data!.copyWith(
                isLoadMoreLoading: false,
                errorMessage: failure.message,
              ),
            ),
          );
        }
      },
      (newRequests) {
        if (state.status == ApprovalsStatus.success && state.data != null) {
          final combinedRequests = [
            ...data.requests,
            ...newRequests,
          ];
          emit(
            ApprovalsState(status: ApprovalsStatus.success, data: 
              data.copyWith(
                requests: _sortRequests(combinedRequests),
                isLoadMoreLoading: false,
                page: nextPage,
                hasMore: newRequests.length >= 10,
              ),
            ),
          );
        }
      },
    );
  }

  Future<void> _onCategoryChanged(
    CategoryChanged event,
    Emitter<ApprovalsState> emit,
  ) async {
    if (state.status != ApprovalsStatus.success || state.data == null) {
      _pendingCategory = event.category;
      _pendingType = event.type;
      return;
    }

    // 1. Show shimmer by clearing list and setting loading true
    emit(
      ApprovalsState(status: ApprovalsStatus.success, data: 
        data.copyWith(
          category: event.category,
          type: event.type,
          isListLoading: true,
          requests: [],
          successMessage: null,
          errorMessage: null,
          targetCategory: event.category,
          targetType: event.type,
        ),
      ),
    );

    // 2. Fetch requests based on UI selection (Team/Raised + Type)
    final requestsResult = await getPendingRequestsUseCase(
      event.type,
      event.category,
      page: 1,
    );

    requestsResult.fold(
      (failure) => emit(ApprovalsState(status: ApprovalsStatus.failure, errorMessage: failure.message)),
      (requests) {
        if (state.status == ApprovalsStatus.success && state.data != null) {
          final latestSuccessState = state;
          emit(
            ApprovalsState(status: ApprovalsStatus.success, data: 
              latestSuccessState.data!.copyWith(
                category: event.category,
                type: event.type,
                requests: _sortRequests(requests),
                isListLoading: false,
                successMessage: null,
                errorMessage: null,
                targetCategory: event.category,
                targetType: event.type,
                page: 1,
                hasMore: requests.length >= 10,
              ),
            ),
          );
        }
      },
    );
  }

  Future<void> _onRefreshSummary(
    RefreshSummary event,
    Emitter<ApprovalsState> emit,
  ) async {
    if (state.status != ApprovalsStatus.success || state.data == null) return;

    final summaryResult = await getApprovalsSummaryUseCase();

    summaryResult.fold(
      (_) => null, // Ignore background errors to keep UI stable
      (newSummary) {
        if (state.status == ApprovalsStatus.success && state.data != null) {
          final latestSuccessState = state;
          emit(
            ApprovalsState(status: ApprovalsStatus.success, data: 
              latestSuccessState.data!.copyWith(
                summary: newSummary,
                successMessage: null,
                errorMessage: null,
              ),
            ),
          );
        }
      },
    );
  }

  Future<void> _onWorkflowActionSubmitted(
    WorkflowActionSubmitted event,
    Emitter<ApprovalsState> emit,
  ) async {
    if (state.status != ApprovalsStatus.success || state.data == null) return;

    // 1. Mark item as processing
    emit(
      ApprovalsState(status: ApprovalsStatus.success, data: 
        data.copyWith(
          processingIds: {
            ...data.processingIds,
            event.requestId,
          },
        ),
      ),
    );

    late final dynamic result;
    if (event.type == ApprovalType.leave) {
      result = await submitLeaveWorkflowActionUseCase(
        event.requestId,
        event.action,
      );
    } else if (event.type == ApprovalType.attendance) {
      result = await submitAttendanceWorkflowActionUseCase(
        event.requestId,
        event.action,
      );
    } else if (event.type == ApprovalType.timesheet) {
      result = await submitTimesheetWorkflowActionUseCase(
        event.requestId,
        event.action,
      );
    } else if (event.type == ApprovalType.compOff) {
      result = await submitCompOffWorkflowActionUseCase(
        event.requestId,
        event.action,
      );
    } else {
      return;
    }

    await result.fold(
      (failure) async {
        if (state.status == ApprovalsStatus.success && state.data != null) {
          final latestSuccessState = state;
          emit(
            ApprovalsState(status: ApprovalsStatus.success, data: 
              latestSuccessState.data!.copyWith(
                processingIds: Set.from(latestSuccessState.data!.processingIds)
                  ..remove(event.requestId),
                errorMessage: failure.message,
                successMessage: null,
              ),
            ),
          );
        }
      },
      (successMessage) async {
        if (state.status == ApprovalsStatus.success && state.data != null) {
          // Action success!
          // 2. Locally update the list (remove processed item)
          final updatedRequests = data.requests
              .where((r) => r.id != event.requestId)
              .toList();

          // 3. Remove from processing and update list
          emit(
            ApprovalsState(status: ApprovalsStatus.success, data: 
              data.copyWith(
                requests: updatedRequests,
                processingIds: Set.from(data.processingIds)
                  ..remove(event.requestId),
                successMessage: successMessage,
                errorMessage: null,
              ),
            ),
          );
        }

        // 4. Refresh the summary in the background
        final summaryResult = await getApprovalsSummaryUseCase();
        summaryResult.fold((_) => null, (newSummary) {
          if (state.status == ApprovalsStatus.success && state.data != null) {
            final latestSuccessState = state;
            emit(
              ApprovalsState(status: ApprovalsStatus.success, data: 
                latestSuccessState.data!.copyWith(
                  summary: newSummary,
                  successMessage: null,
                  errorMessage: null,
                ),
              ),
            );
          }
        });
      },
    );
  }

  Future<void> _onCommentSubmitted(
    CommentSubmitted event,
    Emitter<ApprovalsState> emit,
  ) async {
    if (state.status == ApprovalsStatus.success && state.data != null) {
      final data = state.data!;
        final result = await addCommentUseCase(
          event.type.doctype,
          event.requestId,
          event.comment,
        );

        result.fold(
          (failure) {
            emit(ApprovalsState(status: ApprovalsStatus.success, data: 
              data.copyWith(
                errorMessage: failure.message,
                successMessage: null,
              ),
            ));
          },
          (_) {
            emit(ApprovalsState(status: ApprovalsStatus.success, data: 
              data.copyWith(
                successMessage: 'Comment added successfully',
                errorMessage: null,
              ),
            ));
            add(ApprovalsEvent.commentsRequested(doctype: event.type.doctype, requestId: event.requestId));
          },
        );
    }
  }

  Future<void> _onCommentsRequested(
    CommentsRequested event,
    Emitter<ApprovalsState> emit,
  ) async {
    final currentState = state;
    final data = currentState.data;
    if (currentState.status != ApprovalsStatus.success || data == null) return;

    emit(
      ApprovalsState(status: ApprovalsStatus.success, data: 
        data.copyWith(isCommentsLoading: true, comments: []),
      ),
    );

    final result = await getCommentsUseCase(event.doctype, event.requestId);

    result.fold(
      (failure) => emit(
        ApprovalsState(status: ApprovalsStatus.success, data: 
          data.copyWith(
            isCommentsLoading: false,
            errorMessage: failure.message,
          ),
        ),
      ),
      (comments) => emit(
        ApprovalsState(status: ApprovalsStatus.success, data: 
          data.copyWith(
            isCommentsLoading: false,
            comments: comments,
          ),
        ),
      ),
    );
  }

  Future<void> _onEditTimesheetRequested(
    EditTimesheetRequested event,
    Emitter<ApprovalsState> emit,
  ) async {
    final currentState = state;
    final data = currentState.data;
    if (currentState.status != ApprovalsStatus.success || data == null) return;

    emit(
      ApprovalsState(status: ApprovalsStatus.success, data: 
        data.copyWith(
          isTimesheetLoading: true,
          successMessage: null,
          errorMessage: null,
        ),
      ),
    );

    final results = await Future.wait([
      getTimesheetDetailsUseCase(event.requestId),
      getProjectsUseCase(),
      getEmployeesUseCase(),
    ]);

    final timesheetResult = results[0] as dynamic;
    final projectsResult = results[1] as dynamic;
    final employeesResult = results[2] as dynamic;

    timesheetResult.fold(
      (failure) => emit(
        ApprovalsState(status: ApprovalsStatus.success, data: 
          data.copyWith(
            isTimesheetLoading: false,
            errorMessage: failure.message,
          ),
        ),
      ),
      (timesheet) {
        final projects = projectsResult.getOrElse(() => <ProjectEntity>[]);
        final employees = employeesResult.getOrElse(
          () => <Map<String, dynamic>>[],
        );

        emit(
          ApprovalsState(status: ApprovalsStatus.success, data: 
            data.copyWith(
              isTimesheetLoading: false,
              editingTimesheet: timesheet,
              projects: projects,
              employees: employees,
            ),
          ),
        );
      },
    );
  }

  Future<void> _onSyncTimesheetRequested(
    SyncTimesheetRequested event,
    Emitter<ApprovalsState> emit,
  ) async {
    final currentState = state;
    final data = currentState.data;
    if (currentState.status != ApprovalsStatus.success || data == null) return;

    emit(
      ApprovalsState(status: ApprovalsStatus.success, data: 
        data.copyWith(
          processingIds: Set.from(data.processingIds)
            ..add(event.timesheet.name),
          successMessage: null,
          errorMessage: null,
        ),
      ),
    );

    // Build the API payload from raw entity data — business logic stays in the BLoC
    final Map<String, List<Map<String, dynamic>>> innerDetails = {};

    for (final a in event.assignments) {
      final dateStr = a.date ?? '';
      final dateKey = DateTimeUtils.formatDateString(dateStr);

      if (dateKey == '—' || dateKey.isEmpty) continue;

      innerDetails.putIfAbsent(dateKey, () => []).add({
        TimesheetApiKeys.name: a.name,
        TimesheetApiKeys.date: dateStr,
        TimesheetApiKeys.project: a.project,
        TimesheetApiKeys.taskData: a.taskData,
        TimesheetApiKeys.description: a.description,
        TimesheetApiKeys.expectedHours: a.expectedHours,
        TimesheetApiKeys.spentHours: a.spentHours,
        TimesheetApiKeys.status: a.status ?? TimesheetStatus.pending,
      });
    }

    final weekRange =
        '${DateTimeUtils.formatDateString(event.timesheet.fromDate)} - ${DateTimeUtils.formatDateString(event.timesheet.toDate)}';
    final payload = {
      TimesheetApiKeys.changes: {weekRange: innerDetails},
    };

    final result = await syncTimesheetWeekWiseUseCase(payload);

    result.fold(
      (failure) => emit(
        ApprovalsState(status: ApprovalsStatus.success, data: 
          data.copyWith(
            processingIds: Set.from(data.processingIds)
              ..remove(event.timesheet.name),
            errorMessage: failure.message,
          ),
        ),
      ),
      (success) async {
        if (success) {
          add(
            const ApprovalsEvent.categoryChanged(
              ApprovalType.timesheet,
              ApprovalCategory.raised,
            ),
          );
          emit(
            ApprovalsState(status: ApprovalsStatus.success, data: 
              data.copyWith(
                processingIds: Set.from(data.processingIds)
                  ..remove(event.timesheet.name),
                editingTimesheet: null,
                successMessage: ApprovalsApiConstants.msgTimesheetUpdated,
              ),
            ),
          );
        } else {
          emit(
            ApprovalsState(status: ApprovalsStatus.success, data: 
              data.copyWith(
                processingIds: Set.from(data.processingIds)
                  ..remove(event.timesheet.name),
                errorMessage: ApprovalsApiConstants.msgTimesheetUpdateFailed,
              ),
            ),
          );
        }
      },
    );
  }

  Future<void> _onUpdateTimesheetRequested(
    UpdateTimesheetRequested event,
    Emitter<ApprovalsState> emit,
  ) async {
    final currentState = state;
    final data = currentState.data;
    if (currentState.status != ApprovalsStatus.success || data == null) return;

    emit(
      ApprovalsState(status: ApprovalsStatus.success, data: 
        data.copyWith(
          isTimesheetLoading: true,
          successMessage: null,
          errorMessage: null,
        ),
      ),
    );

    final result = await syncTimesheetWeekWiseUseCase(event.payload);

    result.fold(
      (failure) => emit(
        ApprovalsState(status: ApprovalsStatus.success, data: 
          data.copyWith(
            isTimesheetLoading: false,
            errorMessage: failure.message,
          ),
        ),
      ),
      (success) async {
        if (success) {
          add(
            const ApprovalsEvent.categoryChanged(
              ApprovalType.timesheet,
              ApprovalCategory.raised,
            ),
          );
          emit(
            ApprovalsState(status: ApprovalsStatus.success, data: 
              data.copyWith(
                isTimesheetLoading: false,
                editingTimesheet: null,
                successMessage: ApprovalsApiConstants.msgTimesheetUpdated,
              ),
            ),
          );
        } else {
          emit(
            ApprovalsState(status: ApprovalsStatus.success, data: 
              data.copyWith(
                isTimesheetLoading: false,
                errorMessage: ApprovalsApiConstants.msgTimesheetUpdateFailed,
              ),
            ),
          );
        }
      },
    );
  }

  Future<void> _onDeleteTimesheetRequested(
    DeleteTimesheetRequested event,
    Emitter<ApprovalsState> emit,
  ) async {
    final currentState = state;
    final data = currentState.data;
    if (currentState.status != ApprovalsStatus.success || data == null) return;

    // 1. Mark item as processing
    emit(
      ApprovalsState(status: ApprovalsStatus.success, data: 
        data.copyWith(
          processingIds: {...data.processingIds, event.requestId},
          successMessage: null,
          errorMessage: null,
        ),
      ),
    );

    final result = await deleteTimesheetUseCase(event.requestId);

    result.fold(
      (failure) => emit(
        ApprovalsState(status: ApprovalsStatus.success, data: 
          data.copyWith(
            processingIds: Set.from(data.processingIds)
              ..remove(event.requestId),
            errorMessage: failure.message,
          ),
        ),
      ),
      (success) async {
        if (success) {
          // 2. Locally update the list (remove processed item)
          final updatedRequests = data.requests
              .where((r) => r.id != event.requestId)
              .toList();

          // 3. Remove from processing and update list
          emit(
            ApprovalsState(status: ApprovalsStatus.success, data: 
              data.copyWith(
                requests: updatedRequests,
                processingIds: Set.from(data.processingIds)
                  ..remove(event.requestId),
                successMessage: ApprovalsApiConstants.msgTimesheetDeleted,
                errorMessage: null,
              ),
            ),
          );

          // 4. Refresh the summary in the background
          add(const ApprovalsEvent.refreshSummary());
        } else {
          emit(
            ApprovalsState(status: ApprovalsStatus.success, data: 
              data.copyWith(
                processingIds: Set.from(data.processingIds)
                  ..remove(event.requestId),
                errorMessage: ApprovalsApiConstants.msgTimesheetDeleteFailed,
              ),
            ),
          );
        }
      },
    );
  }

  List<ApprovalRequestEntity> _sortRequests(
    List<ApprovalRequestEntity> requests,
  ) {
    return List<ApprovalRequestEntity>.from(requests)..sort((a, b) {
      int getPriority(String status) {
        final s = status.toLowerCase();
        if (s == ApprovalStatus.pending.toLowerCase() || s == 'open') return 1;
        if (s.contains(ApprovalStatus.pending.toLowerCase())) return 2;
        if (s == ApprovalStatus.rejected.toLowerCase()) return 3;
        if (s == ApprovalStatus.approved.toLowerCase()) return 4;
        return 5;
      }

      return getPriority(a.status).compareTo(getPriority(b.status));
    });
  }

  EventTransformer<Event> _debounce<Event>(Duration duration) {
    return (events, mapper) {
      Timer? timer;
      StreamController<Event>? controller;
      StreamSubscription<Event>? subscription;

      controller = StreamController<Event>(
        onListen: () {
          subscription = events.listen(
            (data) {
              timer?.cancel();
              timer = Timer(duration, () {
                if (controller != null && !controller.isClosed) {
                  controller.add(data);
                }
              });
            },
            onError: (err) {
              if (controller != null && !controller.isClosed) {
                controller.addError(err);
              }
            },
            onDone: () {
              timer?.cancel();
              if (controller != null && !controller.isClosed) {
                controller.close();
              }
            },
          );
        },
        onCancel: () {
          timer?.cancel();
          subscription?.cancel();
        },
      );

      return controller.stream.asyncExpand(mapper);
    };
  }

  Future<void> _onClearMessages(
    ClearMessages event,
    Emitter<ApprovalsState> emit,
  ) async {
    if (state.status == ApprovalsStatus.success && state.data != null) {
      final successState = state;
      emit(
        ApprovalsState(status: ApprovalsStatus.success, data: 
          successState.data!.copyWith(
            successMessage: null,
            errorMessage: null,
          ),
        ),
      );
    }
  }

  void _onSearchQueryChanged(SearchQueryChanged event, Emitter<ApprovalsState> emit) {
    if (state.status == ApprovalsStatus.success && state.data != null) {
      final s = state;
      emit(ApprovalsState(status: ApprovalsStatus.success, data: s.data!.copyWith(searchQuery: event.query)));
    }
  }

  void _onStatusFilterChanged(StatusFilterChanged event, Emitter<ApprovalsState> emit) {
    if (state.status == ApprovalsStatus.success && state.data != null) {
      final s = state;
      // Clear selections when status changes to avoid invalid states
      emit(ApprovalsState(status: ApprovalsStatus.success, data: s.data!.copyWith(
        statusFilter: event.status,
        selectedRequestIds: {},
      )));
    }
  }

  void _onRequestSelectionToggled(RequestSelectionToggled event, Emitter<ApprovalsState> emit) {
    if (state.status == ApprovalsStatus.success && state.data != null) {
      final s = state;
      final newSelection = Set<String>.from(s.data!.selectedRequestIds);
      if (event.selected) {
        newSelection.add(event.id);
      } else {
        newSelection.remove(event.id);
      }
      emit(ApprovalsState(status: ApprovalsStatus.success, data: s.data!.copyWith(selectedRequestIds: newSelection)));
    }
  }

  void _onSelectAllToggled(SelectAllToggled event, Emitter<ApprovalsState> emit) {
    if (state.status == ApprovalsStatus.success && state.data != null) {
      final s = state;
      if (event.selected) {
        final allIds = s.data!.filteredRequests.map((e) => e.id).toSet();
        emit(ApprovalsState(status: ApprovalsStatus.success, data: s.data!.copyWith(selectedRequestIds: allIds)));
      } else {
        emit(ApprovalsState(status: ApprovalsStatus.success, data: s.data!.copyWith(selectedRequestIds: {})));
      }
    }
  }

  Future<void> _onBulkWorkflowActionSubmitted(
    BulkWorkflowActionSubmitted event,
    Emitter<ApprovalsState> emit,
  ) async {
    if (state.status != ApprovalsStatus.success || state.data == null) return;
    final successState = state;

    emit(ApprovalsState(status: ApprovalsStatus.success, data: successState.data!.copyWith(isBulkActionLoading: true)));

    List<Future<void>> futures = [];
    bool hasError = false;

    for (final requestId in event.requestIds) {
      futures.add(() async {
        try {
          switch (event.type) {
            case ApprovalType.leave:
              final res = await submitLeaveWorkflowActionUseCase(requestId, event.action);
              if (res.isLeft()) hasError = true;
              break;
            case ApprovalType.attendance:
              final res = await submitAttendanceWorkflowActionUseCase(requestId, event.action);
              if (res.isLeft()) hasError = true;
              break;
            case ApprovalType.timesheet:
              final res = await submitTimesheetWorkflowActionUseCase(requestId, event.action);
              if (res.isLeft()) hasError = true;
              break;
            case ApprovalType.compOff:
              final res = await submitCompOffWorkflowActionUseCase(requestId, event.action);
              if (res.isLeft()) hasError = true;
              break;
          }
        } catch (e) {
          hasError = true;
        }
      }());
    }

    await Future.wait(futures);

    // Refresh after bulk action
    final requestsResult = await getPendingRequestsUseCase(
      event.type,
      event.category,
      page: 1,
    );

    final summaryResult = await getApprovalsSummaryUseCase();
    final newSummary = summaryResult.fold(
      (failure) => successState.data!.summary,
      (summary) => summary,
    );

    requestsResult.fold(
      (failure) {
        emit(ApprovalsState(status: ApprovalsStatus.success, data: 
          successState.data!.copyWith(
            isBulkActionLoading: false,
            errorMessage: failure.message,
            summary: newSummary,
          ),
        ));
      },
      (requests) {
        emit(ApprovalsState(status: ApprovalsStatus.success, data: 
          successState.data!.copyWith(
            isBulkActionLoading: false,
            requests: _sortRequests(requests),
            summary: newSummary,
            selectedRequestIds: {}, // Clear selection on success
            successMessage: hasError ? ApprovalsApiConstants.msgBulkActionPartialError : ApprovalsApiConstants.msgBulkActionSuccess,
          ),
        ));
      },
    );
  }
}
