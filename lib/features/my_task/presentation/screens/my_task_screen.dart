import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(l10n.myTasks)),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (tasks, hasReachedMax) {
              if (tasks.isEmpty) {
                return Center(child: Text(l10n.noTasksFound, style: AppTextStyle.bodyMedium));
              }
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<TaskBloc>().add(const TaskEvent.loadTasksRequested(isRefresh: true));
                },
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(vertical: AppConstants.p8),
                  itemCount: hasReachedMax ? tasks.length : tasks.length + 1,
                  itemBuilder: (context, index) {
                    if (index >= tasks.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(AppConstants.p16),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return TaskCard(task: tasks[index]);
                  },
                ),
              );
            },
            error: (message) => Center(child: Text(message, style: AppTextStyle.error)),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}


