import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';


import '../../../../core/routing/app_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';

import '../bloc/timesheet_bloc.dart';
import '../bloc/timesheet_event.dart';
import '../bloc/timesheet_state.dart';
import '../widgets/timesheet_card.dart';


class TimesheetListScreen extends StatefulWidget {
  const TimesheetListScreen({super.key});

  @override
  State<TimesheetListScreen> createState() => _TimesheetListScreenState();
}

class _TimesheetListScreenState extends State<TimesheetListScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TimesheetBloc>().add(const TimesheetEvent.started());
    });
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      context.read<TimesheetBloc>().add(const TimesheetEvent.loadMoreRequested());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.timesheets),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                context.push(AppRouter.applyTimesheetPath, extra: "0"),
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
            child: BlocBuilder<TimesheetBloc, TimesheetState>(
              builder: (context, state) {
                return state.maybeWhen(
                  initial: (user, from, to, selectedDate, list, more, assignments, projects) =>
                      const Center(child: CircularProgressIndicator()),
                  loading: (
                    user,
                    from,
                    to,
                    selectedDate,
                    list,
                    more,
                    assignments,
                    projects,
                  ) => const Center(child: CircularProgressIndicator()),
                  loaded: (
                    timesheets,
                    hasMore,
                    isFetchingMore,
                    user,
                    editFromDate,
                    editToDate,
                    selectedDate,
                    editAssignments,
                    projects,
                  ) {


                    final filtered =
                        timesheets.where((t) {
                          final query = _searchController.text.toLowerCase();
                          return t.name.toLowerCase().contains(query) ||
                              (t.employeeName?.toLowerCase().contains(query) ??
                                  false);
                        }).toList();

                    if (filtered.isEmpty && !isFetchingMore) {
                      return Center(
                        child: Text(
                          l10n.noTimesheetsFound,
                          style: AppTextStyle.bodyMedium,
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<TimesheetBloc>().add(
                          const TimesheetEvent.started(),
                        );
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(AppConstants.p12),
                        itemCount:
                            hasMore ? filtered.length + 1 : filtered.length,
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
                          return TimesheetCard(ts: ts);
                        },
                      ),
                    );

                  },
                  error: (
                    message,
                    user,
                    from,
                    to,
                    selectedDate,
                    list,
                    more,
                    assignments,
                    projects,
                  ) => Center(child: Text(message, style: AppTextStyle.error)),

                  orElse: () => const SizedBox(),

                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

