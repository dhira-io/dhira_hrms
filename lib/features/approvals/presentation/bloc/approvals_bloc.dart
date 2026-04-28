import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/approval_type.dart';
import '../../domain/entities/approval_request_entity.dart';
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
    on<Started>(_onStarted);
    on<CategoryChanged>(_onCategoryChanged);
    on<RefreshSummary>(_onRefreshSummary);
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
            // Initial emit with empty list and loading flag
            emit(ApprovalsState.success(
              access: access,
              summary: summary,
              isListLoading: true,
              requests: [],
            ));

            // Default load: Team Approvals -> Leave
            final requestsResult = await getPendingRequestsUseCase(
              ApprovalType.leave,
              ApprovalCategory.team,
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
}