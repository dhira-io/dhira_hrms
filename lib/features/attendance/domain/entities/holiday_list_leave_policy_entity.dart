import 'package:freezed_annotation/freezed_annotation.dart';

part 'holiday_list_leave_policy_entity.freezed.dart';

@freezed
abstract class HolidayListLeavePolicyEntity with _$HolidayListLeavePolicyEntity {
  const factory HolidayListLeavePolicyEntity({
    required bool success,
    required String employee,
    required String employeeName,
    required String company,
    required HolidayListEntity holidayList,
    required LeavePolicyEntity leavePolicy,
  }) = _HolidayListLeavePolicyEntity;
}

@freezed
abstract class HolidayListEntity with _$HolidayListEntity {
  const factory HolidayListEntity({
    required String name,
    required String holidayListName,
    required String fromDate,
    required String toDate,
    required int totalHolidays,
    required List<RestrictedHolidayEntity> customRestrictedHolidays,
    required List<HolidayEntity> holidays,
  }) = _HolidayListEntity;
}

@freezed
abstract class RestrictedHolidayEntity with _$RestrictedHolidayEntity {
  const factory RestrictedHolidayEntity({
    required String name,
    required String holidayDate,
    required String description,
  }) = _RestrictedHolidayEntity;
}

@freezed
abstract class HolidayEntity with _$HolidayEntity {
  const factory HolidayEntity({
    required String holidayDate,
    required String description,
    required int weeklyOff,
  }) = _HolidayEntity;
}

@freezed
abstract class LeavePolicyEntity with _$LeavePolicyEntity {
  const factory LeavePolicyEntity({
    required String filePath,
    required String fileUrl,
  }) = _LeavePolicyEntity;
}
