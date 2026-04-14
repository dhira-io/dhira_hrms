import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/organization_bloc.dart';
import '../bloc/organization_event.dart';
import '../bloc/organization_state.dart';
import '../widgets/org_chart_node_widget.dart';

class OrganizationChartScreen extends StatelessWidget {
  const OrganizationChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrganizationBloc>.value(
      value: Get.find<OrganizationBloc>()..add(const OrganizationEvent.loadChartRequested()),
      child: const OrganizationChartView(),
    );
  }
}

class OrganizationChartView extends StatelessWidget {
  const OrganizationChartView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.organizationChart)),
      body: BlocBuilder<OrganizationBloc, OrganizationState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            chartLoaded: (rootNode) => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppConstants.p32),
                child: Center(
                  child: OrgChartNodeWidget(node: rootNode),
                ),
              ),
            ),
            error: (message) => Center(child: Text(message, style: AppTextStyle.error)),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

