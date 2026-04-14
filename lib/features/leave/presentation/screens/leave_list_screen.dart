import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/storage_constants.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/utils/toast_utils.dart';
import '../bloc/leave_bloc.dart';
import '../bloc/leave_event.dart';
import '../bloc/leave_state.dart';
import '../widgets/leave_application_card.dart';
import '../widgets/leave_summary_header.dart';
import '../widgets/leave_search_box.dart';
import 'package:dhira_hrms/core/routing/app_router.dart';
import 'package:go_router/go_router.dart';

class LeaveListScreen extends StatefulWidget {
  const LeaveListScreen({super.key});

  @override
  State<LeaveListScreen> createState() => _LeaveListScreenState();
}

class _LeaveListScreenState extends State<LeaveListScreen> {
  String? _empid;
  String? _useremail;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadEmpInfo();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadEmpInfo() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _empid = prefs.getString(StorageConstants.empId);
      _useremail = prefs.getString(StorageConstants.userEmail);
    });
    if (_empid != null) {
      context.read<LeaveBloc>().add(LeaveEvent.started(_empid!));
    }
  }

  void _onScroll() {
    if (_empid != null &&
        _scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.9) {
      context.read<LeaveBloc>().add(LeaveEvent.loadMoreRequested(_empid!));
    }
  }

  void _refreshLeaves() {
    if (_empid != null) {
      context.read<LeaveBloc>().add(LeaveEvent.refreshRequested(_empid!));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.leaveApplications),
        elevation: 0,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: Column(
        children: [
          LeaveSearchBox(controller: _searchController),
          const LeaveSummaryHeader(),
          Expanded(
            child: BlocConsumer<LeaveBloc, LeaveState>(
              listener: (context, state) {
                if (state.errorMessage != null) {
                  ToastUtils.showError(state.errorMessage!);
                }
                if (state.success) {
                  ToastUtils.showSuccess(l10n.actionCompletedSuccessfully);
                  _refreshLeaves();
                }
              },
              builder: (context, state) {
                if (state.isLoading && state.leaves.isEmpty) {
                  return const Center(child: CircularProgressIndicator(color: AppColors.primary));
                }

                if (state.leaves.isEmpty && !state.isLoading) {
                   return Center(
                    child: Text(
                      l10n.noLeaveApplicationsFound,
                      style: AppTextStyle.bodyMedium,
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    _refreshLeaves();
                  },
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    itemCount: state.hasMore ? state.filteredLeaves.length + 1 : state.filteredLeaves.length,
                    itemBuilder: (context, index) {
                      if (index >= state.filteredLeaves.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(AppConstants.p8),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      final leave = state.filteredLeaves[index];
                      return LeaveApplicationCard(
                        leave: leave,
                        currentEmpId: _empid ?? "",
                        userEmail: _useremail ?? "",
                        onAction: _refreshLeaves,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(
          AppRouter.applyLeavePath,
          extra: {'employeeId': _empid!},
        ).then((_) {
          if (mounted) {
            _refreshLeaves();
          }
        }),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
