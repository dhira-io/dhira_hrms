import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/attendance_bloc.dart';
import '../bloc/attendance_state.dart';

class AttendanceLogList extends StatelessWidget {
  const AttendanceLogList({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        return state.maybeWhen(
          loaded: (status, logs) {
            if (logs.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Text(l10n.noAttendanceFound, style: AppTextStyle.bodyMedium),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5, bottom: 15),
                    child: Text(
                      'Recent Logs', // TODO: Add to l10n if needed
                      style: AppTextStyle.h3,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: logs.length,
                    itemBuilder: (context, index) {
                      final log = logs[index];
                      final bool isAbsent = log.status == 'Absent';

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: isAbsent ? Colors.red.shade50 : Colors.green.shade50,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                log.date.split('-').last,
                                style: AppTextStyle.h2.copyWith(
                                  color: isAbsent ? Colors.red : Colors.green,
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            log.dayName,
                            style: AppTextStyle.h3.copyWith(fontSize: 16),
                          ),
                          subtitle: Text(
                            log.date,
                            style: AppTextStyle.bodySmall.copyWith(color: Colors.grey.shade600, fontSize: 13),
                          ),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                log.status,
                                style: AppTextStyle.label.copyWith(
                                  color: isAbsent ? Colors.red : Colors.green,
                                ),
                              ),
                              Text(
                                'In: ${log.inTime}',
                                style: AppTextStyle.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
