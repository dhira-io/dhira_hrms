import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_router.dart';
import '../bloc/organization_bloc.dart';
import '../bloc/organization_event.dart';
import '../bloc/organization_state.dart';
import '../widgets/org_card.dart';

class OrganizationScreen extends StatelessWidget {
  const OrganizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Get.find<OrganizationBloc>()..add(const OrganizationEvent.started()),
      child: const OrganizationView(),
    );
  }
}

class OrganizationView extends StatelessWidget {
  const OrganizationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organizations'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_tree),
            tooltip: 'View Org Chart',
            onPressed: () {
              context.push(AppRouter.organizationChartPath);
            },
          )
        ],
      ),
      body: BlocBuilder<OrganizationBloc, OrganizationState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            organizationsLoaded: (organizations) {
              if (organizations.isEmpty) {
                return const Center(child: Text("No organizations found"));
              }
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<OrganizationBloc>().add(const OrganizationEvent.loadOrganizationsRequested());
                },
                child: ListView.builder(
                  itemCount: organizations.length,
                  itemBuilder: (context, index) {
                    return OrgCard(organization: organizations[index]);
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
