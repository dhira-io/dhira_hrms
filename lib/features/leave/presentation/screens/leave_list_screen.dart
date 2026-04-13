import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
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
import 'apply_leave_screen.dart';

class LeaveListScreen extends StatefulWidget {
  const LeaveListScreen({super.key});

  @override
  State<LeaveListScreen> createState() => _LeaveListScreenState();
}

class _LeaveListScreenState extends State<LeaveListScreen> {
  String? _empid;
  String? _empname;
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
    setState(() {
      _empid = prefs.getString(StorageConstants.empId);
      _empname = prefs.getString('empname');
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocProvider.value(
      value: Get.find<LeaveBloc>(),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text(l10n.leaveApplications),
          elevation: 0,
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
        body: Column(
          children: [
            _buildSearchBox(),
            const LeaveSummaryHeader(),
            Expanded(
              child: BlocConsumer<LeaveBloc, LeaveState>(
                listener: (context, state) {
                  if (state.errorMessage != null) {
                    ToastUtils.showError(state.errorMessage!);
                  }
                  if (state.success) {
                    ToastUtils.showSuccess("Action completed successfully");
                    if (_empid != null) {
                      context.read<LeaveBloc>().add(LeaveEvent.refreshRequested(_empid!));
                    }
                  }
                },
                builder: (context, state) {
                  if (state.isLoading && state.leaves.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
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
                      if (_empid != null) {
                        context.read<LeaveBloc>().add(LeaveEvent.refreshRequested(_empid!));
                      }
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
                          onAction: () {
                             if (_empid != null) {
                               context.read<LeaveBloc>().add(LeaveEvent.refreshRequested(_empid!));
                             }
                          },
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
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ApplyLeaveScreen(employeeId: _empid!)),
          ).then((_) {
            if (_empid != null) {
              context.read<LeaveBloc>().add(LeaveEvent.refreshRequested(_empid!));
            }
          }),
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSearchBox() {
    return BlocBuilder<LeaveBloc, LeaveState>(
      buildWhen: (previous, current) => previous.searchQuery != current.searchQuery,
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(12),
          color: AppColors.primary,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                context.read<LeaveBloc>().add(LeaveEvent.searchChanged(value));
              },
              decoration: InputDecoration(
                hintText: "Search Employee or Leave Type",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _searchController.clear();
                          context.read<LeaveBloc>().add(LeaveEvent.searchChanged(''));
                        },
                      )
                    : null,
              ),
            ),
          ),
        );
      },
    );
  }
}
