import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../bloc/task_state.dart';
import '../widgets/task_card.dart';

class MyTaskScreen extends StatelessWidget {
  const MyTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Get.find<TaskBloc>()..add(const TaskEvent.started()),
      child: const MyTaskView(),
    );
  }
}

class MyTaskView extends StatefulWidget {
  const MyTaskView({super.key});

  @override
  State<MyTaskView> createState() => _MyTaskViewState();
}

class _MyTaskViewState extends State<MyTaskView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<TaskBloc>().add(const TaskEvent.loadMoreTasksRequested());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Tasks')),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (tasks, hasReachedMax) {
              if (tasks.isEmpty) {
                return const Center(child: Text("No tasks found"));
              }
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<TaskBloc>().add(const TaskEvent.loadTasksRequested(isRefresh: true));
                },
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: hasReachedMax ? tasks.length : tasks.length + 1,
                  itemBuilder: (context, index) {
                    if (index >= tasks.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return TaskCard(task: tasks[index]);
                  },
                ),
              );
            },
            error: (message) => Center(child: Text(message)),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
