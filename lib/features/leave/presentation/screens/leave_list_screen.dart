import 'package:dhira_hrms/features/leave/presentation/widgets/leave_application_card.dart';
import 'package:dhira_hrms/features/leave/presentation/widgets/leave_summary_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/dialogs/app_dialogs.dart';
import '../bloc/leave_bloc.dart';
import '../bloc/leave_event.dart';
import '../bloc/leave_state.dart';
import 'apply_leave_screen.dart';

class LeaveListScreen extends StatefulWidget {
  const LeaveListScreen({super.key});

  @override
  State<LeaveListScreen> createState() => _LeaveListScreenState();
}

class _LeaveListScreenState extends State<LeaveListScreen> {
  String? _empid;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadEmpId();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadEmpId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _empid = prefs.getString('empid');
    });
  }

  void _onScroll() {
    if (_empid != null && _scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.9) {
      context.read<LeaveBloc>().add(LeaveEvent.loadMoreRequested(_empid!));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_empid == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final l10n = AppLocalizations.of(context)!;
    return BlocProvider<LeaveBloc>(
      create: (context) => Get.find<LeaveBloc>()..add(LeaveEvent.started(_empid!)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.leaveApplications),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ApplyLeaveScreen(employeeId: _empid!)),
              ),
            ),
          ],
        ),
        body: BlocListener<LeaveBloc, LeaveState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (message) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              ),
              error: (message) => AppDialogs.showAlertDialog(context, message),
            );
          },
          child: BlocBuilder<LeaveBloc, LeaveState>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => const Center(child: CircularProgressIndicator()),
                loaded: (leaves, types, balance, hasMore, isFetchingMore) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<LeaveBloc>().add(LeaveEvent.started(_empid!));
                    },
                    child: Column(
                      children: [
                        const LeaveSummaryHeader(),
                        Expanded(
                          child: leaves.isEmpty
                              ? Center(
                                  child: Text(
                                    l10n.noLeaveApplicationsFound,
                                    style: AppTextStyle.bodyMedium,
                                  ),
                                )
                              : ListView.builder(
                                  controller: _scrollController,
                                  padding: const EdgeInsets.all(AppConstants.p15),
                                  itemCount: hasMore ? leaves.length + 1 : leaves.length,
                                  itemBuilder: (context, index) {
                                    if (index >= leaves.length) {
                                      return const Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(AppConstants.p8),
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }
                                    final leave = leaves[index];
                                    return LeaveApplicationCard(
                                      leave: leave,
                                      onDelete: () => context.read<LeaveBloc>().add(LeaveEvent.deleteRequested(leave.name, _empid!)),
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
                  );
                },
                error: (message) => Center(child: Text(message, style: AppTextStyle.error)),
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
        ),
      ),
    );
  }
}

