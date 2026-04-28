import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_approvals_access_usecase.dart';
import '../../domain/usecases/get_approvals_summary_usecase.dart';
import '../../domain/usecases/get_pending_requests_usecase.dart';
import '../../domain/entities/approval_type.dart';
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
    // Event Handlers
    on<Started>(_onStarted);
    on<RefreshSummary>(_onRefreshSummary);
  }

  /// Initial load sequence: Permissions -> Summary -> Initial List (Leaves)
  Future<void> _onStarted(Started event, Emitter<ApprovalsState> emit) async {
    emit(const ApprovalsState.loading());

    // 1. Verify Access Permissions
    final accessResult = await getApprovalsAccessUseCase();

    await accessResult.fold(
          (failure) async => emit(ApprovalsState.failure(failure.message)),
          (access) async {
        // 2. Fetch Pending Counts Summary
        final summaryResult = await getApprovalsSummaryUseCase();

        await summaryResult.fold(
              (failure) async => emit(ApprovalsState.failure(failure.message)),
              (summary) async {
            // 3. Set basic success state and trigger initial list fetch
            emit(ApprovalsState.success(
              access: access,
              summary: summary,
              isListLoading: true,
            ));

            // Fetch default tab data (Leave Requests)
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

  /// Background refresh for summary counts
  Future<void> _onRefreshSummary(RefreshSummary event, Emitter<ApprovalsState> emit) async {
    final currentState = state;
    if (currentState is Success) {
      final summaryResult = await getApprovalsSummaryUseCase();

      summaryResult.fold(
            (_) => null, // Background failure: keep existing UI counts
            (newSummary) => emit(currentState.copyWith(summary: newSummary)),
      );
    }
  }
}