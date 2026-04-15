import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/constants/storage_constants.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/utils/toast_utils.dart';
import '../bloc/timesheet_bloc.dart';
import '../bloc/timesheet_event.dart';
import '../bloc/timesheet_state.dart';
import 'apply_timesheet_screen.dart';
import '../../domain/entities/timesheet_entities.dart';

class TimesheetListScreen extends StatefulWidget {
  const TimesheetListScreen({super.key});

  @override
  State<TimesheetListScreen> createState() => _TimesheetListScreenState();
}

class _TimesheetListScreenState extends State<TimesheetListScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  String? _empid;

  @override
  void initState() {
    super.initState();
    _loadEmpId();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.9) {
      if (_empid != null) {
        context.read<TimesheetBloc>().add(TimesheetEvent.loadMoreRequested(_empid!));
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadEmpId() async {
    final prefs = await SharedPreferences.getInstance();
    final empId = prefs.getString(StorageConstants.empId);

    setState(() {
      _empid = empId;
    });

    // 👉 CALL BLOC ONLY AFTER VALUE READY
    if (empId != null) {
      context.read<TimesheetBloc>().add(
        TimesheetEvent.started(empId),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_empid == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final l10n = AppLocalizations.of(context)!;
    return BlocProvider<TimesheetBloc>.value(
      value:  Get.find<TimesheetBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.timesheets),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => context.push(AppRouter.applyTimesheetPath, extra: "0"),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppConstants.p12),
              child: TextField(
                controller: _searchController,
                style: AppTextStyle.bodyMedium,
                decoration: InputDecoration(
                  hintText: l10n.searchTimesheets,
                  prefixIcon: const Icon(Icons.search),
                ),
                onChanged: (val) => setState(() {}),
              ),
            ),
            Expanded(
              child: BlocListener<TimesheetBloc, TimesheetState>(
                listener: (context, state) {
                  state.whenOrNull(
                    success: (message, _, __, ___, ____) => ToastUtils.showSuccess(message),
                    error: (message, _, __, ___, ____) => ToastUtils.showError(message),
                  );
                },
                child: BlocBuilder<TimesheetBloc, TimesheetState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      loading: (_, __, ___, ____) => const Center(child: CircularProgressIndicator()),
                      loaded: (timesheets, hasMore, isFetchingMore, _, __, ___, ____) {
                        final filtered = timesheets.where((t) {
                          final query = _searchController.text.toLowerCase();
                          return t.name.toLowerCase().contains(query) || 
                                 t.employeeName.toLowerCase().contains(query);
                        }).toList();

                        return RefreshIndicator(
                          onRefresh: () async {

                            if (_empid != null) {
                              context.read<TimesheetBloc>().add(
                                TimesheetEvent.started(_empid!),
                              );
                            }

                          },
                          child: filtered.isEmpty
                              ? Center(
                                  child: Text(
                                    l10n.noTimesheetsFound,
                                    style: AppTextStyle.bodyMedium,
                                  ),
                                )
                              : ListView.builder(
                                  controller: _scrollController,
                                  padding: const EdgeInsets.all(AppConstants.p12),
                                  itemCount: hasMore ? filtered.length + 1 : filtered.length,
                                  itemBuilder: (context, index) {
                                    if (index >= filtered.length) {
                                      return const Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(AppConstants.p8), 
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }
                                    final ts = filtered[index];
                                    return _buildTimesheetCard(context, ts);
                                  },
                                ),
                        );
                      },
                      error: (message, _, __, ___, ____) => Center(child: Text(message, style: AppTextStyle.error)),
                      orElse: () => const SizedBox.shrink(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimesheetCard(BuildContext context, TimesheetEntity ts) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.p16),
      padding: const EdgeInsets.all(AppConstants.p16),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F2F7),
        borderRadius: BorderRadius.circular(AppConstants.r12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(l10n.id, ts.name),
          _buildInfoRow(l10n.employeeName, ts.employeeName),
          _buildInfoRow(l10n.fromDate, _formatDate(ts.fromDate)),
          _buildInfoRow(l10n.toDate, _formatDate(ts.toDate)),
          _buildStatusRow(context, ts.docStatus),
          _buildInfoRow(l10n.organization, ts.department ?? "—"),
          _buildInfoRow(l10n.approver, ts.approverName),
          const SizedBox(height: AppConstants.p12),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              height: 40,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ApplyTimesheetScreen(timesheetId: ts.name)),
                ),
                icon: const Icon(Icons.edit, size: 18, color: Colors.white),
                label: Text(l10n.edit, style: AppTextStyle.button.copyWith(color: Colors.white, fontSize: 14)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B0EC1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r8)),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd-MM-yyyy').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: AppTextStyle.bodyMedium.copyWith(fontSize: 13, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(BuildContext context, int docStatus) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              l10n.statusLabel,
              style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
          const SizedBox(width: 8),
          _buildStatusBadge(context, docStatus),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, int docStatus) {
    final l10n = AppLocalizations.of(context)!;
    final status = docStatus == 0 ? l10n.draft : l10n.saved;
    final color = docStatus == 0 ? AppColors.warning : AppColors.success;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.3), width: 0.5),
      ),
      child: Text(
        status,
        style: AppTextStyle.bodySmall.copyWith(color: color, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}


