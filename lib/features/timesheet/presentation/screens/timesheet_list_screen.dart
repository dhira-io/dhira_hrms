import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    return BlocProvider<TimesheetBloc>(
      create: (context) => Get.find<TimesheetBloc>()..add(TimesheetEvent.started(_empid!)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Timesheets'),
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
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search timesheets...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onChanged: (val) {
                  // Local search logic could be added here if needed, 
                  // but for now we rely on BLoC for data.
                },
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
                              ? const Center(child: Text('No timesheets found.'))
                              : ListView.builder(
                                  controller: _scrollController,
                                  padding: const EdgeInsets.all(12),
                                  itemCount: hasMore ? filtered.length + 1 : filtered.length,
                                  itemBuilder: (context, index) {
                                    if (index >= filtered.length) {
                                      return const Center(child: Padding(padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()));
                                    }
                                    final ts = filtered[index];
                                    return _buildTimesheetCard(context, ts);
                                  },
                                ),
                        );
                      },
                      error: (message) => Center(child: Text(message)),
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
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(ts.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                _buildStatusBadge(ts.docStatus),
              ],
            ),
            const SizedBox(height: 8),
            Text('${DateFormat('dd MMM').format(DateTime.parse(ts.fromDate))} - ${DateFormat('dd MMM yyyy').format(DateTime.parse(ts.toDate))}', 
                 style: TextStyle(color: Colors.grey.shade600)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Hours: ${ts.hoursTotal.toStringAsFixed(1)}', style: const TextStyle(fontWeight: FontWeight.w500)),
                    Text('Spent: ${ts.totalSpentHours.toStringAsFixed(1)}', style: const TextStyle(fontSize: 12, color: Colors.blue)),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ApplyTimesheetScreen(timesheetId: ts.name)),
                  ),
                  child: const Text('Edit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(int docStatus) {
    final status = docStatus == 0 ? "Draft" : "Saved";
    final color = docStatus == 0 ? Colors.orange : Colors.green;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
      child: Text(status, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }
}
