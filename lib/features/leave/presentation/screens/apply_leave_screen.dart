import 'package:dhira_hrms/core/constants/storage_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/utils/toast_utils.dart';
import '../bloc/leave_bloc.dart';
import '../bloc/leave_state.dart';
import '../bloc/leave_event.dart';
import '../widgets/leave_apply_form.dart';

class ApplyLeaveScreen extends StatefulWidget {
  final String employeeId;
  final LeaveEntity? leave;
  const ApplyLeaveScreen({super.key, required this.employeeId, this.leave});

  @override
  State<ApplyLeaveScreen> createState() => _ApplyLeaveScreenState();
}

class _ApplyLeaveScreenState extends State<ApplyLeaveScreen> {
  String _gender = "";
  String _effectiveEmployeeId = "";

  @override
  void initState() {
    super.initState();
    _effectiveEmployeeId = widget.employeeId;
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _gender = prefs.getString(StorageConstants.gender) ?? "";
      if (_effectiveEmployeeId.isEmpty) {
        _effectiveEmployeeId = prefs.getString(StorageConstants.empId) ?? "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_gender == "" || _effectiveEmployeeId == "") {
      // Small delay or loading state while gender is being fetched
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider<LeaveBloc>(
      create: (context) => LeaveBloc(
        getLeaveTypesUseCase: Get.find(),
        getLeaveBalanceUseCase: Get.find(),
        getLeaveStatisticsUseCase: Get.find(),
        submitLeaveUseCase: Get.find(),
        updateLeaveUseCase: Get.find(),
      )..add(const LeaveEvent.typesRequested())..add(LeaveEvent.balanceRequested(
          employeeId: _effectiveEmployeeId, 
          todayDate: DateTimeUtils.todayDate(),
          gender: _gender,
        )),
      child: Scaffold(
        backgroundColor: AppColors.surface, // Match modern off-white aesthetic
        body: SafeArea(
          child: BlocListener<LeaveBloc, LeaveState>(
            listener: (context, state) {
              if (state.success) {
                ToastUtils.showSuccess(l10n.leaveSubmitSuccess);
                context.pop();
              }
              if (state.errorMessage != null) {
                ToastUtils.showError(state.errorMessage!);
              }
            },
            child: CustomScrollView(
              slivers: [
                _buildSliverAppBar(context, l10n),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: AppConstants.p20, vertical: AppConstants.p16),
                  sliver: SliverToBoxAdapter(
                    child: LeaveApplyForm(employeeId: _effectiveEmployeeId, leave: widget.leave),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 100), // Space for bottom nav or padding
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, AppLocalizations l10n) {
    return SliverAppBar(
      pinned: true,
      floating: false,
      elevation: 0,
      backgroundColor: AppColors.surface.withOpacity(0.8), // Glass effect base
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ColorFilter.mode(
            AppColors.surface.withOpacity(0.8),
            BlendMode.srcOver,
          ),
          child: Container(),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.primaryContainer),
        onPressed: () => context.pop(),
      ),
      title: Text(
        l10n.applyLeave,
        style: AppTextStyle.h2.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.onSurface,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: AppConstants.p16),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surfaceContainer,
              image: const DecorationImage(
                image: AssetImage(AppAssets.defaultProfile),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

