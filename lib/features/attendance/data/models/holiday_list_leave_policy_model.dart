import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/holiday_list_leave_policy_entity.dart';
import '../../../../core/utils/string_utils.dart';

part 'holiday_list_leave_policy_model.freezed.dart';
part 'holiday_list_leave_policy_model.g.dart';

@freezed
abstract class HolidayListLeavePolicyModel with _$HolidayListLeavePolicyModel {
  const factory HolidayListLeavePolicyModel({
    required bool success,
    required String employee,
    @JsonKey(name: 'employee_name') required String employeeName,
    required String company,
    @JsonKey(name: 'holiday_list') required HolidayListModel holidayList,
    @JsonKey(name: 'leave_policy') required LeavePolicyModel leavePolicy,
  }) = _HolidayListLeavePolicyModel;

  const HolidayListLeavePolicyModel._();

  factory HolidayListLeavePolicyModel.fromJson(Map<String, dynamic> json) =>
      _$HolidayListLeavePolicyModelFromJson(json);

  HolidayListLeavePolicyEntity toEntity() => HolidayListLeavePolicyEntity(
        success: success,
        employee: employee,
        employeeName: employeeName,
        company: company,
        holidayList: holidayList.toEntity(),
        leavePolicy: leavePolicy.toEntity(),
      );
}

@freezed
abstract class HolidayListModel with _$HolidayListModel {
  const factory HolidayListModel({
    required String name,
    @JsonKey(name: 'holiday_list_name') required String holidayListName,
    @JsonKey(name: 'from_date') required String fromDate,
    @JsonKey(name: 'to_date') required String toDate,
    @JsonKey(name: 'total_holidays') required int totalHolidays,
    @JsonKey(name: 'custom_restricted_holidays')
    required List<RestrictedHolidayModel> customRestrictedHolidays,
    required List<HolidayModel> holidays,
  }) = _HolidayListModel;

  const HolidayListModel._();

  factory HolidayListModel.fromJson(Map<String, dynamic> json) =>
      _$HolidayListModelFromJson(json);

  HolidayListEntity toEntity() => HolidayListEntity(
        name: name,
        holidayListName: holidayListName,
        fromDate: fromDate,
        toDate: toDate,
        totalHolidays: totalHolidays,
        customRestrictedHolidays:
            customRestrictedHolidays.map((e) => e.toEntity()).toList(),
        holidays: holidays.map((e) => e.toEntity()).toList(),
      );
}

@freezed
abstract class RestrictedHolidayModel with _$RestrictedHolidayModel {
  const factory RestrictedHolidayModel({
    required String name,
    @JsonKey(name: 'holiday_date') required String holidayDate,
    required String description,
  }) = _RestrictedHolidayModel;

  const RestrictedHolidayModel._();

  factory RestrictedHolidayModel.fromJson(Map<String, dynamic> json) =>
      _$RestrictedHolidayModelFromJson(json);

  RestrictedHolidayEntity toEntity() => RestrictedHolidayEntity(
        name: name,
        holidayDate: holidayDate,
        description: StringUtils.stripHtml(description),
      );
}

@freezed
abstract class HolidayModel with _$HolidayModel {
  const factory HolidayModel({
    @JsonKey(name: 'holiday_date') required String holidayDate,
    required String description,
    @JsonKey(name: 'weekly_off') required int weeklyOff,
  }) = _HolidayModel;

  const HolidayModel._();

  factory HolidayModel.fromJson(Map<String, dynamic> json) =>
      _$HolidayModelFromJson(json);

  HolidayEntity toEntity() => HolidayEntity(
        holidayDate: holidayDate,
        description: StringUtils.stripHtml(description),
        weeklyOff: weeklyOff,
      );
}

@freezed
abstract class LeavePolicyModel with _$LeavePolicyModel {
  const factory LeavePolicyModel({
    @JsonKey(name: 'file_path') required String filePath,
    @JsonKey(name: 'file_url') required String fileUrl,
  }) = _LeavePolicyModel;

  const LeavePolicyModel._();

  factory LeavePolicyModel.fromJson(Map<String, dynamic> json) =>
      _$LeavePolicyModelFromJson(json);

  LeavePolicyEntity toEntity() => LeavePolicyEntity(
        filePath: filePath,
        fileUrl: fileUrl,
      );
}
