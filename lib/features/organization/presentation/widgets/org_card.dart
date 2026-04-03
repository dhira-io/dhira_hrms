import 'package:flutter/material.dart';
import '../../domain/entities/organization_entity.dart';

class OrgCard extends StatelessWidget {
  final OrganizationEntity organization;

  const OrgCard({super.key, required this.organization});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: const Icon(Icons.business, color: Colors.blue),
        ),
        title: Text(organization.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text('Department: ${organization.department}'),
            Text('Location: ${organization.location}'),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.people, size: 20, color: Colors.grey),
            const SizedBox(height: 4),
            Text('${organization.employeeCount}', style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
