import 'package:dhira_hrms/services/api_service.dart';
import 'package:flutter/material.dart';
import '../model/organization_emp_model.dart';

class OrgChartProvider extends ChangeNotifier {
  // OrganizationEmpModel? organizationData;
  bool isLoading = false;
  String? error;
  Data? rootEmployee;

  Future<void> fetchOrganizationData() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final response = await ApiService.fetchOrgChart();
      rootEmployee = response.message?.data;
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
