import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/organization_bloc.dart';
import '../bloc/organization_event.dart';
import '../bloc/organization_state.dart';
import '../widgets/org_card.dart';

class OrganizationScreen extends StatelessWidget {
  const OrganizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrganizationBloc>.value(
      value: Get.find<OrganizationBloc>()..add(const OrganizationEvent.started()),
      child: const OrganizationView(),
    );
  }
}

class OrganizationView extends StatelessWidget {
  const OrganizationView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.organizations),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_tree),
            tooltip: l10n.viewOrgChart,
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
                return Center(child: Text(l10n.noOrganizationsFound, style: AppTextStyle.bodyMedium));
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
            error: (message) => Center(child: Text(message, style: AppTextStyle.error)),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

