import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:dhira_hrms/core/error/failures.dart';
import 'package:dhira_hrms/core/usecases/usecase.dart';
import 'package:dhira_hrms/features/calendar/domain/repositories/i_calendar_repository.dart';

class GetCalendarMonthEventsUseCase implements UseCase<Map<String, String>, GetCalendarMonthEventsParams> {
  final ICalendarRepository repository;

  GetCalendarMonthEventsUseCase(this.repository);

  @override
  Future<Either<Failure, Map<String, String>>> call(GetCalendarMonthEventsParams params) async {
    return await repository.getCalendarEvents(
      employee: params.employee,
      fromDate: params.fromDate,
      toDate: params.toDate,
    );
  }
}

class GetCalendarMonthEventsParams extends Equatable {
  final String employee;
  final String fromDate;
  final String toDate;

  const GetCalendarMonthEventsParams({
    required this.employee,
    required this.fromDate,
    required this.toDate,
  });

  @override
  List<Object?> get props => [employee, fromDate, toDate];
}
