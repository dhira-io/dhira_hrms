import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../bloc/organization_bloc.dart';
import '../bloc/organization_event.dart';
import '../bloc/organization_state.dart';
import '../widgets/org_chart_node_widget.dart';

class OrganizationChartScreen extends StatelessWidget {
  const OrganizationChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Get.find<OrganizationBloc>()..add(const OrganizationEvent.loadChartRequested()),
      child: const OrganizationChartView(),
    );
  }
}

class OrganizationChartView extends StatelessWidget {
  const OrganizationChartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Organization Chart')),
      body: BlocBuilder<OrganizationBloc, OrganizationState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            chartLoaded: (rootNode) => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32.0),
                child: Center(
                  child: OrgChartNodeWidget(node: rootNode),
                ),
              ),
            ),
            error: (message) => Center(child: Text(message)),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
