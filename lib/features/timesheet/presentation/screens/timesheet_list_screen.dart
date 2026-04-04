import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/dialogs/app_dialogs.dart';
import '../bloc/timesheet_bloc.dart';
import '../bloc/timesheet_event.dart';
import '../bloc/timesheet_state.dart';
import 'apply_timesheet_screen.dart';

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
    setState(() {
      _empid = prefs.getString('empid');
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider<TimesheetBloc>(
      create: (context) => Get.find<TimesheetBloc>()..add(TimesheetEvent.started(_empid!)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.timesheets),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ApplyTimesheetScreen(timesheetId: "0")),
              ),
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
                    success: (message) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message))),
                    error: (message) => AppDialogs.showAlertDialog(context, message),
                  );
                },
                child: BlocBuilder<TimesheetBloc, TimesheetState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      loading: () => const Center(child: CircularProgressIndicator()),
                      loaded: (timesheets, hasMore, isFetchingMore) {
                        final filtered = timesheets.where((t) {
                          final query = _searchController.text.toLowerCase();
                          return t.name.toLowerCase().contains(query) || 
                                 t.employeeName.toLowerCase().contains(query);
                        }).toList();

                        return RefreshIndicator(
                          onRefresh: () async {
                            context.read<TimesheetBloc>().add(TimesheetEvent.started(_empid!));
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
                      error: (message) => Center(child: Text(message, style: AppTextStyle.error)),
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

  Widget _buildTimesheetCard(BuildContext context, dynamic ts) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.p12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r12)),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(ts.name, style: AppTextStyle.h3.copyWith(fontSize: 16)),
                _buildStatusBadge(context, ts.docStatus),
              ],
            ),
            const SizedBox(height: AppConstants.p8),
            Text(
              '${DateFormat('dd MMM').format(DateTime.parse(ts.fromDate))} - ${DateFormat('dd MMM yyyy').format(DateTime.parse(ts.toDate))}', 
              style: AppTextStyle.bodySmall.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppConstants.p12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.totalHours(ts.hoursTotal.toStringAsFixed(1)), 
                      style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      l10n.spentLabel(ts.totalSpentHours.toStringAsFixed(1)), 
                      style: AppTextStyle.bodySmall.copyWith(color: AppColors.primary),
                    ),
                  ],
                ),
                SizedBox(
                  height: 36,
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ApplyTimesheetScreen(timesheetId: ts.name)),
                    ),
                    child: Text(l10n.edit, style: AppTextStyle.button.copyWith(fontSize: 14)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, int docStatus) {
    final l10n = AppLocalizations.of(context)!;
    final status = docStatus == 0 ? l10n.draft : l10n.saved;
    final color = docStatus == 0 ? AppColors.warning : AppColors.success;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.p10, vertical: AppConstants.p4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1), 
        borderRadius: BorderRadius.circular(AppConstants.r20),
        border: Border.all(color: color, width: 0.5),
      ),
      child: Text(
        status, 
        style: AppTextStyle.bodySmall.copyWith(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}


