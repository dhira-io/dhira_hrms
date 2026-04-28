import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_type.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import '../../domain/usecases/get_approvals_access_usecase.dart';
import '../../domain/usecases/get_approvals_summary_usecase.dart';
import '../../domain/usecases/get_pending_requests_usecase.dart';
import 'approvals_event.dart';
import 'approvals_state.dart';

class ApprovalsBloc extends Bloc<ApprovalsEvent, ApprovalsState> {
  final GetApprovalsAccessUseCase getApprovalsAccessUseCase;
  final GetApprovalsSummaryUseCase getApprovalsSummaryUseCase;
  final GetPendingRequestsUseCase getPendingRequestsUseCase;

  ApprovalsBloc({
    required this.getApprovalsAccessUseCase,
    required this.getApprovalsSummaryUseCase,
    required this.getPendingRequestsUseCase,
  }) : super(const ApprovalsState.initial()) {

    // Registering all event handlers
    on<Started>(_onStarted);
    on<CategoryChanged>(_onCategoryChanged);
    on<RefreshSummary>(_onRefreshSummary);
  }

  /// Initial load sequence:
  /// 1. Check if user can access the approval page.
  /// 2. Get the numerical summary (badges) for the top tabs.
  /// 3. Fetch the default list (Leave requests).
  Future<void> _onStarted(Started event, Emitter<ApprovalsState> emit) async {
    emit(const ApprovalsState.loading());

    // Step 1: Verify Access
    final accessResult = await getApprovalsAccessUseCase();

    await accessResult.fold(
          (failure) async => emit(ApprovalsState.failure(failure.message)),
          (access) async {
        // Step 2: Fetch Summary Statistics for counts/badges
        final summaryResult = await getApprovalsSummaryUseCase();

        await summaryResult.fold(
              (failure) async => emit(ApprovalsState.failure(failure.message)),
              (summary) async {
            // Set basic success state with counts and start list loading
            emit(ApprovalsState.success(
              access: access,
              summary: summary,
              isListLoading: true,
              requests: [],
            ));

            // Step 3: Automatically fetch the initial data list (Leave)
            final requestsResult = await getPendingRequestsUseCase(ApprovalType.leave);

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

  /// Handles switching between tabs (Leave, Attendance, Timesheet, Comp-off).
  /// This ensures that clicking a tab immediately triggers the correct API.
  Future<void> _onCategoryChanged(CategoryChanged event, Emitter<ApprovalsState> emit) async {
    final currentState = state;

    if (currentState is Success) {
      // 1. Maintain current badges but set the list to loading state (shimmer)
      emit(currentState.copyWith(
        isListLoading: true,
        requests: [], // Clear old list so users see fresh shimmer
      ));

      // 2. Fetch data based on the specific tab clicked
      final requestsResult = await getPendingRequestsUseCase(event.type);

      requestsResult.fold(
            (failure) => emit(ApprovalsState.failure(failure.message)),
            (requests) => emit(currentState.copyWith(
          requests: requests,
          isListLoading: false,
        )),
      );
    }
  }

  /// Periodically refreshes the counts in the top tabs without interrupting the user.
  Future<void> _onRefreshSummary(RefreshSummary event, Emitter<ApprovalsState> emit) async {
    final currentState = state;
    if (currentState is Success) {
      final summaryResult = await getApprovalsSummaryUseCase();

      summaryResult.fold(
            (_) => null, // Background failure: keep existing UI data
            (newSummary) => emit(currentState.copyWith(summary: newSummary)),
      );
    }
  }
}