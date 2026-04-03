import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_tasks_usecase.dart';
import 'task_event.dart';
import 'task_state.dart';

const int _tasksLimit = 15;

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasksUseCase getTasksUseCase;

  TaskBloc({required this.getTasksUseCase}) : super(const TaskState.initial()) {
    on<TaskEvent>((event, emit) async {
      await event.when(
        started: () => _onLoadTasksRequested(emit, isRefresh: false),
        loadTasksRequested: (isRefresh) => _onLoadTasksRequested(emit, isRefresh: isRefresh),
        loadMoreTasksRequested: () => _onLoadMoreTasksRequested(emit),
      );
    });
  }

  Future<void> _onLoadTasksRequested(Emitter<TaskState> emit, {bool isRefresh = false}) async {
    if (!isRefresh) {
      emit(const TaskState.loading());
    }

    final result = await getTasksUseCase(start: 0, length: _tasksLimit);

    result.fold(
      (failure) => emit(TaskState.error(failure.message)),
      (tasks) => emit(TaskState.loaded(
        tasks: tasks,
        hasReachedMax: tasks.length < _tasksLimit,
      )),
    );
  }

  Future<void> _onLoadMoreTasksRequested(Emitter<TaskState> emit) async {
    await state.maybeMap(
      loaded: (currentState) async {
        if (currentState.hasReachedMax) return;
        
        final result = await getTasksUseCase(start: currentState.tasks.length, length: _tasksLimit);

        result.fold(
          (failure) => emit(TaskState.error(failure.message)),
          (tasks) {
            if (tasks.isEmpty) {
              emit(currentState.copyWith(hasReachedMax: true));
            } else {
              emit(TaskState.loaded(
                tasks: List.of(currentState.tasks)..addAll(tasks),
                hasReachedMax: tasks.length < _tasksLimit,
              ));
            }
          },
        );
      },
      orElse: () async {},
    );
  }
}
