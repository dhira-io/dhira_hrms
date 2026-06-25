import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/core/error/failures.dart';
import 'package:dhira_hrms/features/calendar/domain/entities/calendar_entity.dart';

abstract class ICalendarRepository {
  Future<Either<Failure, Map<String, String>>> getCalendarEvents({
    required String employee,
    required String fromDate,
    required String toDate,
  });

  Future<Either<Failure, CalendarSummaryEntity>> getCalendarSummary({
    required String employee,
    required int month,
    required int year,
  });
}
