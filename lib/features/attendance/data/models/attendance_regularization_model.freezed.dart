// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_regularization_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AttendanceRegularizationModel _$AttendanceRegularizationModelFromJson(
  Map<String, dynamic> json,
) {
  return _AttendanceRegularizationModel.fromJson(json);
}

/// @nodoc
mixin _$AttendanceRegularizationModel {
  @JsonKey(name: 'docstatus')
  int get docStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'doctype')
  String get docType => throw _privateConstructorUsedError;
  @JsonKey(name: 'attendance_date')
  String get attendanceDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'employee')
  String get employee => throw _privateConstructorUsedError;
  @JsonKey(name: 'manual_in_time')
  String get manualInTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'manual_out_time')
  String get manualOutTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'reason_category')
  String get reasonCategory => throw _privateConstructorUsedError;
  @JsonKey(name: 'employee_remarks')
  String get employeeRemarks => throw _privateConstructorUsedError;
  @JsonKey(name: 'routed_to_hr')
  int get routedToHr => throw _privateConstructorUsedError;
  @JsonKey(name: 'supporting_document')
  String? get supportingDocument => throw _privateConstructorUsedError;

  /// Serializes this AttendanceRegularizationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AttendanceRegularizationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttendanceRegularizationModelCopyWith<AttendanceRegularizationModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceRegularizationModelCopyWith<$Res> {
  factory $AttendanceRegularizationModelCopyWith(
    AttendanceRegularizationModel value,
    $Res Function(AttendanceRegularizationModel) then,
  ) =
      _$AttendanceRegularizationModelCopyWithImpl<
        $Res,
        AttendanceRegularizationModel
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'docstatus') int docStatus,
    @JsonKey(name: 'doctype') String docType,
    @JsonKey(name: 'attendance_date') String attendanceDate,
    @JsonKey(name: 'employee') String employee,
    @JsonKey(name: 'manual_in_time') String manualInTime,
    @JsonKey(name: 'manual_out_time') String manualOutTime,
    @JsonKey(name: 'reason_category') String reasonCategory,
    @JsonKey(name: 'employee_remarks') String employeeRemarks,
    @JsonKey(name: 'routed_to_hr') int routedToHr,
    @JsonKey(name: 'supporting_document') String? supportingDocument,
  });
}

/// @nodoc
class _$AttendanceRegularizationModelCopyWithImpl<
  $Res,
  $Val extends AttendanceRegularizationModel
>
    implements $AttendanceRegularizationModelCopyWith<$Res> {
  _$AttendanceRegularizationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttendanceRegularizationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docStatus = null,
    Object? docType = null,
    Object? attendanceDate = null,
    Object? employee = null,
    Object? manualInTime = null,
    Object? manualOutTime = null,
    Object? reasonCategory = null,
    Object? employeeRemarks = null,
    Object? routedToHr = null,
    Object? supportingDocument = freezed,
  }) {
    return _then(
      _value.copyWith(
            docStatus: null == docStatus
                ? _value.docStatus
                : docStatus // ignore: cast_nullable_to_non_nullable
                      as int,
            docType: null == docType
                ? _value.docType
                : docType // ignore: cast_nullable_to_non_nullable
                      as String,
            attendanceDate: null == attendanceDate
                ? _value.attendanceDate
                : attendanceDate // ignore: cast_nullable_to_non_nullable
                      as String,
            employee: null == employee
                ? _value.employee
                : employee // ignore: cast_nullable_to_non_nullable
                      as String,
            manualInTime: null == manualInTime
                ? _value.manualInTime
                : manualInTime // ignore: cast_nullable_to_non_nullable
                      as String,
            manualOutTime: null == manualOutTime
                ? _value.manualOutTime
                : manualOutTime // ignore: cast_nullable_to_non_nullable
                      as String,
            reasonCategory: null == reasonCategory
                ? _value.reasonCategory
                : reasonCategory // ignore: cast_nullable_to_non_nullable
                      as String,
            employeeRemarks: null == employeeRemarks
                ? _value.employeeRemarks
                : employeeRemarks // ignore: cast_nullable_to_non_nullable
                      as String,
            routedToHr: null == routedToHr
                ? _value.routedToHr
                : routedToHr // ignore: cast_nullable_to_non_nullable
                      as int,
            supportingDocument: freezed == supportingDocument
                ? _value.supportingDocument
                : supportingDocument // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AttendanceRegularizationModelImplCopyWith<$Res>
    implements $AttendanceRegularizationModelCopyWith<$Res> {
  factory _$$AttendanceRegularizationModelImplCopyWith(
    _$AttendanceRegularizationModelImpl value,
    $Res Function(_$AttendanceRegularizationModelImpl) then,
  ) = __$$AttendanceRegularizationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'docstatus') int docStatus,
    @JsonKey(name: 'doctype') String docType,
    @JsonKey(name: 'attendance_date') String attendanceDate,
    @JsonKey(name: 'employee') String employee,
    @JsonKey(name: 'manual_in_time') String manualInTime,
    @JsonKey(name: 'manual_out_time') String manualOutTime,
    @JsonKey(name: 'reason_category') String reasonCategory,
    @JsonKey(name: 'employee_remarks') String employeeRemarks,
    @JsonKey(name: 'routed_to_hr') int routedToHr,
    @JsonKey(name: 'supporting_document') String? supportingDocument,
  });
}

/// @nodoc
class __$$AttendanceRegularizationModelImplCopyWithImpl<$Res>
    extends
        _$AttendanceRegularizationModelCopyWithImpl<
          $Res,
          _$AttendanceRegularizationModelImpl
        >
    implements _$$AttendanceRegularizationModelImplCopyWith<$Res> {
  __$$AttendanceRegularizationModelImplCopyWithImpl(
    _$AttendanceRegularizationModelImpl _value,
    $Res Function(_$AttendanceRegularizationModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceRegularizationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docStatus = null,
    Object? docType = null,
    Object? attendanceDate = null,
    Object? employee = null,
    Object? manualInTime = null,
    Object? manualOutTime = null,
    Object? reasonCategory = null,
    Object? employeeRemarks = null,
    Object? routedToHr = null,
    Object? supportingDocument = freezed,
  }) {
    return _then(
      _$AttendanceRegularizationModelImpl(
        docStatus: null == docStatus
            ? _value.docStatus
            : docStatus // ignore: cast_nullable_to_non_nullable
                  as int,
        docType: null == docType
            ? _value.docType
            : docType // ignore: cast_nullable_to_non_nullable
                  as String,
        attendanceDate: null == attendanceDate
            ? _value.attendanceDate
            : attendanceDate // ignore: cast_nullable_to_non_nullable
                  as String,
        employee: null == employee
            ? _value.employee
            : employee // ignore: cast_nullable_to_non_nullable
                  as String,
        manualInTime: null == manualInTime
            ? _value.manualInTime
            : manualInTime // ignore: cast_nullable_to_non_nullable
                  as String,
        manualOutTime: null == manualOutTime
            ? _value.manualOutTime
            : manualOutTime // ignore: cast_nullable_to_non_nullable
                  as String,
        reasonCategory: null == reasonCategory
            ? _value.reasonCategory
            : reasonCategory // ignore: cast_nullable_to_non_nullable
                  as String,
        employeeRemarks: null == employeeRemarks
            ? _value.employeeRemarks
            : employeeRemarks // ignore: cast_nullable_to_non_nullable
                  as String,
        routedToHr: null == routedToHr
            ? _value.routedToHr
            : routedToHr // ignore: cast_nullable_to_non_nullable
                  as int,
        supportingDocument: freezed == supportingDocument
            ? _value.supportingDocument
            : supportingDocument // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AttendanceRegularizationModelImpl
    extends _AttendanceRegularizationModel {
  const _$AttendanceRegularizationModelImpl({
    @JsonKey(name: 'docstatus') this.docStatus = AppConstants.docStatusDraft,
    @JsonKey(name: 'doctype')
    this.docType = 'Attendance Regularization Request',
    @JsonKey(name: 'attendance_date') required this.attendanceDate,
    @JsonKey(name: 'employee') required this.employee,
    @JsonKey(name: 'manual_in_time') required this.manualInTime,
    @JsonKey(name: 'manual_out_time') required this.manualOutTime,
    @JsonKey(name: 'reason_category') required this.reasonCategory,
    @JsonKey(name: 'employee_remarks') required this.employeeRemarks,
    @JsonKey(name: 'routed_to_hr') required this.routedToHr,
    @JsonKey(name: 'supporting_document') this.supportingDocument,
  }) : super._();

  factory _$AttendanceRegularizationModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$AttendanceRegularizationModelImplFromJson(json);

  @override
  @JsonKey(name: 'docstatus')
  final int docStatus;
  @override
  @JsonKey(name: 'doctype')
  final String docType;
  @override
  @JsonKey(name: 'attendance_date')
  final String attendanceDate;
  @override
  @JsonKey(name: 'employee')
  final String employee;
  @override
  @JsonKey(name: 'manual_in_time')
  final String manualInTime;
  @override
  @JsonKey(name: 'manual_out_time')
  final String manualOutTime;
  @override
  @JsonKey(name: 'reason_category')
  final String reasonCategory;
  @override
  @JsonKey(name: 'employee_remarks')
  final String employeeRemarks;
  @override
  @JsonKey(name: 'routed_to_hr')
  final int routedToHr;
  @override
  @JsonKey(name: 'supporting_document')
  final String? supportingDocument;

  @override
  String toString() {
    return 'AttendanceRegularizationModel(docStatus: $docStatus, docType: $docType, attendanceDate: $attendanceDate, employee: $employee, manualInTime: $manualInTime, manualOutTime: $manualOutTime, reasonCategory: $reasonCategory, employeeRemarks: $employeeRemarks, routedToHr: $routedToHr, supportingDocument: $supportingDocument)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceRegularizationModelImpl &&
            (identical(other.docStatus, docStatus) ||
                other.docStatus == docStatus) &&
            (identical(other.docType, docType) || other.docType == docType) &&
            (identical(other.attendanceDate, attendanceDate) ||
                other.attendanceDate == attendanceDate) &&
            (identical(other.employee, employee) ||
                other.employee == employee) &&
            (identical(other.manualInTime, manualInTime) ||
                other.manualInTime == manualInTime) &&
            (identical(other.manualOutTime, manualOutTime) ||
                other.manualOutTime == manualOutTime) &&
            (identical(other.reasonCategory, reasonCategory) ||
                other.reasonCategory == reasonCategory) &&
            (identical(other.employeeRemarks, employeeRemarks) ||
                other.employeeRemarks == employeeRemarks) &&
            (identical(other.routedToHr, routedToHr) ||
                other.routedToHr == routedToHr) &&
            (identical(other.supportingDocument, supportingDocument) ||
                other.supportingDocument == supportingDocument));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    docStatus,
    docType,
    attendanceDate,
    employee,
    manualInTime,
    manualOutTime,
    reasonCategory,
    employeeRemarks,
    routedToHr,
    supportingDocument,
  );

  /// Create a copy of AttendanceRegularizationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceRegularizationModelImplCopyWith<
    _$AttendanceRegularizationModelImpl
  >
  get copyWith =>
      __$$AttendanceRegularizationModelImplCopyWithImpl<
        _$AttendanceRegularizationModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendanceRegularizationModelImplToJson(this);
  }
}

abstract class _AttendanceRegularizationModel
    extends AttendanceRegularizationModel {
  const factory _AttendanceRegularizationModel({
    @JsonKey(name: 'docstatus') final int docStatus,
    @JsonKey(name: 'doctype') final String docType,
    @JsonKey(name: 'attendance_date') required final String attendanceDate,
    @JsonKey(name: 'employee') required final String employee,
    @JsonKey(name: 'manual_in_time') required final String manualInTime,
    @JsonKey(name: 'manual_out_time') required final String manualOutTime,
    @JsonKey(name: 'reason_category') required final String reasonCategory,
    @JsonKey(name: 'employee_remarks') required final String employeeRemarks,
    @JsonKey(name: 'routed_to_hr') required final int routedToHr,
    @JsonKey(name: 'supporting_document') final String? supportingDocument,
  }) = _$AttendanceRegularizationModelImpl;
  const _AttendanceRegularizationModel._() : super._();

  factory _AttendanceRegularizationModel.fromJson(Map<String, dynamic> json) =
      _$AttendanceRegularizationModelImpl.fromJson;

  @override
  @JsonKey(name: 'docstatus')
  int get docStatus;
  @override
  @JsonKey(name: 'doctype')
  String get docType;
  @override
  @JsonKey(name: 'attendance_date')
  String get attendanceDate;
  @override
  @JsonKey(name: 'employee')
  String get employee;
  @override
  @JsonKey(name: 'manual_in_time')
  String get manualInTime;
  @override
  @JsonKey(name: 'manual_out_time')
  String get manualOutTime;
  @override
  @JsonKey(name: 'reason_category')
  String get reasonCategory;
  @override
  @JsonKey(name: 'employee_remarks')
  String get employeeRemarks;
  @override
  @JsonKey(name: 'routed_to_hr')
  int get routedToHr;
  @override
  @JsonKey(name: 'supporting_document')
  String? get supportingDocument;

  /// Create a copy of AttendanceRegularizationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendanceRegularizationModelImplCopyWith<
    _$AttendanceRegularizationModelImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
