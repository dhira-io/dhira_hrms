import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/organization_entity.dart';

class OrgCard extends StatelessWidget {
  final OrganizationEntity organization;

  const OrgCard({super.key, required this.organization});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: AppConstants.p16, vertical: AppConstants.p8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(AppConstants.p16),
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: const Icon(Icons.business, color: Colors.blue),
        ),
        title: Text(organization.name, style: AppTextStyle.h3.copyWith(fontSize: 16)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppConstants.p8),
            Text('${l10n.department}: ${organization.department}', style: AppTextStyle.bodySmall),
            Text('${l10n.location}: ${organization.location}', style: AppTextStyle.bodySmall),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.people, size: 20, color: Colors.grey),
            const SizedBox(height: AppConstants.p4),
            Text('${organization.employeeCount}', style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

