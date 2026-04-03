import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_organizations_usecase.dart';
import '../../domain/usecases/get_org_chart_usecase.dart';
import 'organization_event.dart';
import 'organization_state.dart';

class OrganizationBloc extends Bloc<OrganizationEvent, OrganizationState> {
  final GetOrganizationsUseCase getOrganizationsUseCase;
  final GetOrgChartUseCase getOrgChartUseCase;

  OrganizationBloc({
    required this.getOrganizationsUseCase,
    required this.getOrgChartUseCase,
  }) : super(const OrganizationState.initial()) {
    on<OrganizationEvent>((event, emit) async {
      await event.when(
        started: () => _onLoadOrganizationsRequested(emit), // load organizations by default
        loadOrganizationsRequested: () => _onLoadOrganizationsRequested(emit),
        loadChartRequested: () => _onLoadChartRequested(emit),
      );
    });
  }

  Future<void> _onLoadOrganizationsRequested(Emitter<OrganizationState> emit) async {
    emit(const OrganizationState.loading());
    final result = await getOrganizationsUseCase();
    result.fold(
      (failure) => emit(OrganizationState.error(failure.message)),
      (organizations) => emit(OrganizationState.organizationsLoaded(organizations)),
    );
  }

  Future<void> _onLoadChartRequested(Emitter<OrganizationState> emit) async {
    emit(const OrganizationState.loading());
    final result = await getOrgChartUseCase();
    result.fold(
      (failure) => emit(OrganizationState.error(failure.message)),
      (rootNode) => emit(OrganizationState.chartLoaded(rootNode)),
    );
  }
}
