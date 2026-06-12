import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/entities/compensatory_leave_eligible_date_entity.dart';

part 'compensatory_leave_eligible_date_model.freezed.dart';
part 'compensatory_leave_eligible_date_model.g.dart';

@freezed
class CompensatoryLeaveEligibleDateModel
    with _$CompensatoryLeaveEligibleDateModel {
  const factory CompensatoryLeaveEligibleDateModel({
    required String date,
    @JsonKey(name: 'working_hours') required double workingHours,
    @JsonKey(name: 'eligibility_type') required String eligibilityType,
  }) = _CompensatoryLeaveEligibleDateModel;

  const CompensatoryLeaveEligibleDateModel._();

  factory CompensatoryLeaveEligibleDateModel.fromJson(
    Map<String, dynamic> json,
  ) => _$CompensatoryLeaveEligibleDateModelFromJson(json);

  CompensatoryLeaveEligibleDateEntity toEntity() {
    String formattedDate = date;
    final parts = date.split('-');
    if (parts.length == 3) {
      formattedDate = "${parts[2]}-${parts[1]}-${parts[0]}";
    }

    final hoursString = workingHours == workingHours.toInt()
        ? workingHours.toInt().toString()
        : workingHours.toString();

    String mappedWorkType = eligibilityType.toLowerCase();
    if (mappedWorkType == 'holiday_work') mappedWorkType = 'holiday';
    if (mappedWorkType == 'weekend_work') mappedWorkType = 'weekend';

    return CompensatoryLeaveEligibleDateEntity(
      date: date,
      displayLabel: "$formattedDate ($hoursString Hours)",
      workedHours: workingHours,
      workType: mappedWorkType,
    );
  }
}
