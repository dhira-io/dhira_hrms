import 'package:get/get.dart';
import '../../../../core/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/widgets/common_app_bar.dart';
import '../widgets/self_assessment_widgets.dart';

class SelfAssessmentScreen extends StatefulWidget {
  const SelfAssessmentScreen({super.key});

  @override
  State<SelfAssessmentScreen> createState() => _SelfAssessmentScreenState();
}

class _SelfAssessmentScreenState extends State<SelfAssessmentScreen> {
  int _selectedKraIndex = 0;
  late final LocalStorageService _localStorageService;
  String _empName = '';
  String _empId = '';
  String _department = '';

  final List<String> _dummyKras = [
    'Technical (40%)',
    'Teamwork (20%)',
    'Delivery (15%)',
    'Management (15%)',
    'Growth (10%)',
  ];

  @override
  void initState() {
    super.initState();
    _localStorageService = Get.find<LocalStorageService>();
    _empName = _localStorageService.getEmpName() ?? '';
    _empId = _localStorageService.getEmpId() ?? '';
    _department = _localStorageService.getDepartment() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CommonAppBar(
        title: l10n.selfAssessment,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppConstants.p16),
              child: Column(
                children: [
                  SelfAssessmentEmployeeCard(
                    name: _empName,
                    employeeId: _empId,
                    department: _department,
                    dueDate: '03 April 2026',
                    progress: 1.0,
                    progressItems: '15/15 Items',
                  ),
                  const SizedBox(height: AppConstants.p16),
                  SelfAssessmentAssessmentSection(
                    kras: _dummyKras,
                    selectedKraIndex: _selectedKraIndex,
                    onKraSelected: (index) {
                      setState(() {
                        _selectedKraIndex = index;
                      });
                    },
                  ),
                  const SizedBox(height: AppConstants.p16),
                  const SelfAssessmentTimelineSection(),
                ],
              ),
            ),
          ),
          SelfAssessmentBottomActions(
            onSaveDraft: () {
              // TODO: Implement save draft
            },
            onSubmit: () {
              // TODO: Implement submit
            },
          ),
        ],
      ),
    );
  }
}
