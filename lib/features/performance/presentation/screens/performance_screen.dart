import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/performance_bloc.dart';
import '../bloc/performance_event.dart';
import '../bloc/performance_state.dart';

class PerformanceScreen extends StatefulWidget {
  const PerformanceScreen({super.key});

  @override
  State<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PerformanceBloc>().add(const PerformanceEvent.started());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Performance'),
      ),
      body: BlocBuilder<PerformanceBloc, PerformanceState>(
        builder: (context, state) {
          return state.when(
            initial: (summary, isLoading, isActionLoading, error) =>
                const Center(child: CircularProgressIndicator()),
            loading: (summary, isLoading, isActionLoading, error) =>
                const Center(child: CircularProgressIndicator()),
            loaded: (summary, isLoading, isActionLoading, error) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Employee: ${summary.employeeId}'),
                  Text('Score: ${summary.score}'),
                  Text('Period: ${summary.period}'),
                ],
              ),
            ),
            error: (summary, isLoading, isActionLoading, error) =>
                Center(child: Text(error)),
          );
        },
      ),
    );
  }
}
