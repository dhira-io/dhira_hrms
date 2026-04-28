// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holiday_list_leave_policy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HolidayListLeavePolicyModel _$HolidayListLeavePolicyModelFromJson(
  Map<String, dynamic> json,
) => _HolidayListLeavePolicyModel(
  success: json['success'] as bool,
  employee: json['employee'] as String,
  employeeName: json['employee_name'] as String,
  company: json['company'] as String,
  holidayList: HolidayListModel.fromJson(
    json['holiday_list'] as Map<String, dynamic>,
  ),
  leavePolicy: LeavePolicyModel.fromJson(
    json['leave_policy'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$HolidayListLeavePolicyModelToJson(
  _HolidayListLeavePolicyModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'employee': instance.employee,
  'employee_name': instance.employeeName,
  'company': instance.company,
  'holiday_list': instance.holidayList,
  'leave_policy': instance.leavePolicy,
};

_HolidayListModel _$HolidayListModelFromJson(Map<String, dynamic> json) =>
    _HolidayListModel(
      name: json['name'] as String,
      holidayListName: json['holiday_list_name'] as String,
      fromDate: json['from_date'] as String,
      toDate: json['to_date'] as String,
      totalHolidays: (json['total_holidays'] as num).toInt(),
      customRestrictedHolidays:
          (json['custom_restricted_holidays'] as List<dynamic>)
              .map(
                (e) =>
                    RestrictedHolidayModel.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
      holidays: (json['holidays'] as List<dynamic>)
          .map((e) => HolidayModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HolidayListModelToJson(_HolidayListModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'holiday_list_name': instance.holidayListName,
      'from_date': instance.fromDate,
      'to_date': instance.toDate,
      'total_holidays': instance.totalHolidays,
      'custom_restricted_holidays': instance.customRestrictedHolidays,
      'holidays': instance.holidays,
    };

_RestrictedHolidayModel _$RestrictedHolidayModelFromJson(
  Map<String, dynamic> json,
) => _RestrictedHolidayModel(
  name: json['name'] as String,
  holidayDate: json['holiday_date'] as String,
  description: json['description'] as String,
);

Map<String, dynamic> _$RestrictedHolidayModelToJson(
  _RestrictedHolidayModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'holiday_date': instance.holidayDate,
  'description': instance.description,
};

_HolidayModel _$HolidayModelFromJson(Map<String, dynamic> json) =>
    _HolidayModel(
      holidayDate: json['holiday_date'] as String,
      description: json['description'] as String,
      weeklyOff: (json['weekly_off'] as num).toInt(),
    );

Map<String, dynamic> _$HolidayModelToJson(_HolidayModel instance) =>
    <String, dynamic>{
      'holiday_date': instance.holidayDate,
      'description': instance.description,
      'weekly_off': instance.weeklyOff,
    };

_LeavePolicyModel _$LeavePolicyModelFromJson(Map<String, dynamic> json) =>
    _LeavePolicyModel(
      filePath: json['file_path'] as String,
      fileUrl: json['file_url'] as String,
    );

Map<String, dynamic> _$LeavePolicyModelToJson(_LeavePolicyModel instance) =>
    <String, dynamic>{
      'file_path': instance.filePath,
      'file_url': instance.fileUrl,
    };
