import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:dhira_hrms/core/error/failures.dart';
import 'package:dhira_hrms/core/usecases/usecase.dart';
import 'package:dhira_hrms/features/calendar/domain/entities/calendar_entity.dart';
import 'package:dhira_hrms/features/calendar/domain/repositories/i_calendar_repository.dart';

class GetCalendarSummaryUseCase implements UseCase<CalendarSummaryEntity, GetCalendarSummaryParams> {
  final ICalendarRepository repository;

  GetCalendarSummaryUseCase(this.repository);

  @override
  Future<Either<Failure, CalendarSummaryEntity>> call(GetCalendarSummaryParams params) async {
    return await repository.getCalendarSummary(
      employee: params.employee,
      month: params.month,
      year: params.year,
    );
  }
}

class GetCalendarSummaryParams extends Equatable {
  final String employee;
  final int month;
  final int year;

  const GetCalendarSummaryParams({
    required this.employee,
    required this.month,
    required this.year,
  });

  @override
  List<Object?> get props => [employee, month, year];
}
