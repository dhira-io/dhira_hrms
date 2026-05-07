// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'approvals_summary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ApprovalsSummaryModel _$ApprovalsSummaryModelFromJson(
  Map<String, dynamic> json,
) {
  return _ApprovalsSummaryModel.fromJson(json);
}

/// @nodoc
mixin _$ApprovalsSummaryModel {
  @JsonKey(name: 'leave_approvals_pending')
  int get leaveApprovalsPending => throw _privateConstructorUsedError;
  @JsonKey(name: 'attendance_regularization_pending')
  int get attendanceRegularizationPending => throw _privateConstructorUsedError;
  @JsonKey(name: 'timesheet_approvals_pending')
  int get timesheetApprovalsPending => throw _privateConstructorUsedError;
  @JsonKey(name: 'compensatory_leave_pending')
  int get compensatoryLeavePending => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_all_pending')
  int get totalAllPending => throw _privateConstructorUsedError;
  String? get timestamp => throw _privateConstructorUsedError;

  /// Serializes this ApprovalsSummaryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApprovalsSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApprovalsSummaryModelCopyWith<ApprovalsSummaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApprovalsSummaryModelCopyWith<$Res> {
  factory $ApprovalsSummaryModelCopyWith(
    ApprovalsSummaryModel value,
    $Res Function(ApprovalsSummaryModel) then,
  ) = _$ApprovalsSummaryModelCopyWithImpl<$Res, ApprovalsSummaryModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'leave_approvals_pending') int leaveApprovalsPending,
    @JsonKey(name: 'attendance_regularization_pending')
    int attendanceRegularizationPending,
    @JsonKey(name: 'timesheet_approvals_pending') int timesheetApprovalsPending,
    @JsonKey(name: 'compensatory_leave_pending') int compensatoryLeavePending,
    @JsonKey(name: 'total_all_pending') int totalAllPending,
    String? timestamp,
  });
}

/// @nodoc
class _$ApprovalsSummaryModelCopyWithImpl<
  $Res,
  $Val extends ApprovalsSummaryModel
>
    implements $ApprovalsSummaryModelCopyWith<$Res> {
  _$ApprovalsSummaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApprovalsSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? leaveApprovalsPending = null,
    Object? attendanceRegularizationPending = null,
    Object? timesheetApprovalsPending = null,
    Object? compensatoryLeavePending = null,
    Object? totalAllPending = null,
    Object? timestamp = freezed,
  }) {
    return _then(
      _value.copyWith(
            leaveApprovalsPending: null == leaveApprovalsPending
                ? _value.leaveApprovalsPending
                : leaveApprovalsPending // ignore: cast_nullable_to_non_nullable
                      as int,
            attendanceRegularizationPending:
                null == attendanceRegularizationPending
                ? _value.attendanceRegularizationPending
                : attendanceRegularizationPending // ignore: cast_nullable_to_non_nullable
                      as int,
            timesheetApprovalsPending: null == timesheetApprovalsPending
                ? _value.timesheetApprovalsPending
                : timesheetApprovalsPending // ignore: cast_nullable_to_non_nullable
                      as int,
            compensatoryLeavePending: null == compensatoryLeavePending
                ? _value.compensatoryLeavePending
                : compensatoryLeavePending // ignore: cast_nullable_to_non_nullable
                      as int,
            totalAllPending: null == totalAllPending
                ? _value.totalAllPending
                : totalAllPending // ignore: cast_nullable_to_non_nullable
                      as int,
            timestamp: freezed == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ApprovalsSummaryModelImplCopyWith<$Res>
    implements $ApprovalsSummaryModelCopyWith<$Res> {
  factory _$$ApprovalsSummaryModelImplCopyWith(
    _$ApprovalsSummaryModelImpl value,
    $Res Function(_$ApprovalsSummaryModelImpl) then,
  ) = __$$ApprovalsSummaryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'leave_approvals_pending') int leaveApprovalsPending,
    @JsonKey(name: 'attendance_regularization_pending')
    int attendanceRegularizationPending,
    @JsonKey(name: 'timesheet_approvals_pending') int timesheetApprovalsPending,
    @JsonKey(name: 'compensatory_leave_pending') int compensatoryLeavePending,
    @JsonKey(name: 'total_all_pending') int totalAllPending,
    String? timestamp,
  });
}

/// @nodoc
class __$$ApprovalsSummaryModelImplCopyWithImpl<$Res>
    extends
        _$ApprovalsSummaryModelCopyWithImpl<$Res, _$ApprovalsSummaryModelImpl>
    implements _$$ApprovalsSummaryModelImplCopyWith<$Res> {
  __$$ApprovalsSummaryModelImplCopyWithImpl(
    _$ApprovalsSummaryModelImpl _value,
    $Res Function(_$ApprovalsSummaryModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApprovalsSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? leaveApprovalsPending = null,
    Object? attendanceRegularizationPending = null,
    Object? timesheetApprovalsPending = null,
    Object? compensatoryLeavePending = null,
    Object? totalAllPending = null,
    Object? timestamp = freezed,
  }) {
    return _then(
      _$ApprovalsSummaryModelImpl(
        leaveApprovalsPending: null == leaveApprovalsPending
            ? _value.leaveApprovalsPending
            : leaveApprovalsPending // ignore: cast_nullable_to_non_nullable
                  as int,
        attendanceRegularizationPending: null == attendanceRegularizationPending
            ? _value.attendanceRegularizationPending
            : attendanceRegularizationPending // ignore: cast_nullable_to_non_nullable
                  as int,
        timesheetApprovalsPending: null == timesheetApprovalsPending
            ? _value.timesheetApprovalsPending
            : timesheetApprovalsPending // ignore: cast_nullable_to_non_nullable
                  as int,
        compensatoryLeavePending: null == compensatoryLeavePending
            ? _value.compensatoryLeavePending
            : compensatoryLeavePending // ignore: cast_nullable_to_non_nullable
                  as int,
        totalAllPending: null == totalAllPending
            ? _value.totalAllPending
            : totalAllPending // ignore: cast_nullable_to_non_nullable
                  as int,
        timestamp: freezed == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ApprovalsSummaryModelImpl extends _ApprovalsSummaryModel {
  const _$ApprovalsSummaryModelImpl({
    @JsonKey(name: 'leave_approvals_pending')
    required this.leaveApprovalsPending,
    @JsonKey(name: 'attendance_regularization_pending')
    required this.attendanceRegularizationPending,
    @JsonKey(name: 'timesheet_approvals_pending')
    required this.timesheetApprovalsPending,
    @JsonKey(name: 'compensatory_leave_pending')
    required this.compensatoryLeavePending,
    @JsonKey(name: 'total_all_pending') required this.totalAllPending,
    this.timestamp,
  }) : super._();

  factory _$ApprovalsSummaryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApprovalsSummaryModelImplFromJson(json);

  @override
  @JsonKey(name: 'leave_approvals_pending')
  final int leaveApprovalsPending;
  @override
  @JsonKey(name: 'attendance_regularization_pending')
  final int attendanceRegularizationPending;
  @override
  @JsonKey(name: 'timesheet_approvals_pending')
  final int timesheetApprovalsPending;
  @override
  @JsonKey(name: 'compensatory_leave_pending')
  final int compensatoryLeavePending;
  @override
  @JsonKey(name: 'total_all_pending')
  final int totalAllPending;
  @override
  final String? timestamp;

  @override
  String toString() {
    return 'ApprovalsSummaryModel(leaveApprovalsPending: $leaveApprovalsPending, attendanceRegularizationPending: $attendanceRegularizationPending, timesheetApprovalsPending: $timesheetApprovalsPending, compensatoryLeavePending: $compensatoryLeavePending, totalAllPending: $totalAllPending, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApprovalsSummaryModelImpl &&
            (identical(other.leaveApprovalsPending, leaveApprovalsPending) ||
                other.leaveApprovalsPending == leaveApprovalsPending) &&
            (identical(
                  other.attendanceRegularizationPending,
                  attendanceRegularizationPending,
                ) ||
                other.attendanceRegularizationPending ==
                    attendanceRegularizationPending) &&
            (identical(
                  other.timesheetApprovalsPending,
                  timesheetApprovalsPending,
                ) ||
                other.timesheetApprovalsPending == timesheetApprovalsPending) &&
            (identical(
                  other.compensatoryLeavePending,
                  compensatoryLeavePending,
                ) ||
                other.compensatoryLeavePending == compensatoryLeavePending) &&
            (identical(other.totalAllPending, totalAllPending) ||
                other.totalAllPending == totalAllPending) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    leaveApprovalsPending,
    attendanceRegularizationPending,
    timesheetApprovalsPending,
    compensatoryLeavePending,
    totalAllPending,
    timestamp,
  );

  /// Create a copy of ApprovalsSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApprovalsSummaryModelImplCopyWith<_$ApprovalsSummaryModelImpl>
  get copyWith =>
      __$$ApprovalsSummaryModelImplCopyWithImpl<_$ApprovalsSummaryModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ApprovalsSummaryModelImplToJson(this);
  }
}

abstract class _ApprovalsSummaryModel extends ApprovalsSummaryModel {
  const factory _ApprovalsSummaryModel({
    @JsonKey(name: 'leave_approvals_pending')
    required final int leaveApprovalsPending,
    @JsonKey(name: 'attendance_regularization_pending')
    required final int attendanceRegularizationPending,
    @JsonKey(name: 'timesheet_approvals_pending')
    required final int timesheetApprovalsPending,
    @JsonKey(name: 'compensatory_leave_pending')
    required final int compensatoryLeavePending,
    @JsonKey(name: 'total_all_pending') required final int totalAllPending,
    final String? timestamp,
  }) = _$ApprovalsSummaryModelImpl;
  const _ApprovalsSummaryModel._() : super._();

  factory _ApprovalsSummaryModel.fromJson(Map<String, dynamic> json) =
      _$ApprovalsSummaryModelImpl.fromJson;

  @override
  @JsonKey(name: 'leave_approvals_pending')
  int get leaveApprovalsPending;
  @override
  @JsonKey(name: 'attendance_regularization_pending')
  int get attendanceRegularizationPending;
  @override
  @JsonKey(name: 'timesheet_approvals_pending')
  int get timesheetApprovalsPending;
  @override
  @JsonKey(name: 'compensatory_leave_pending')
  int get compensatoryLeavePending;
  @override
  @JsonKey(name: 'total_all_pending')
  int get totalAllPending;
  @override
  String? get timestamp;

  /// Create a copy of ApprovalsSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApprovalsSummaryModelImplCopyWith<_$ApprovalsSummaryModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ApprovalsSummaryResponse _$ApprovalsSummaryResponseFromJson(
  Map<String, dynamic> json,
) {
  return _ApprovalsSummaryResponse.fromJson(json);
}

/// @nodoc
mixin _$ApprovalsSummaryResponse {
  bool get success => throw _privateConstructorUsedError;
  ApprovalsSummaryModel get data => throw _privateConstructorUsedError;

  /// Serializes this ApprovalsSummaryResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApprovalsSummaryResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApprovalsSummaryResponseCopyWith<ApprovalsSummaryResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApprovalsSummaryResponseCopyWith<$Res> {
  factory $ApprovalsSummaryResponseCopyWith(
    ApprovalsSummaryResponse value,
    $Res Function(ApprovalsSummaryResponse) then,
  ) = _$ApprovalsSummaryResponseCopyWithImpl<$Res, ApprovalsSummaryResponse>;
  @useResult
  $Res call({bool success, ApprovalsSummaryModel data});

  $ApprovalsSummaryModelCopyWith<$Res> get data;
}

/// @nodoc
class _$ApprovalsSummaryResponseCopyWithImpl<
  $Res,
  $Val extends ApprovalsSummaryResponse
>
    implements $ApprovalsSummaryResponseCopyWith<$Res> {
  _$ApprovalsSummaryResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApprovalsSummaryResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? success = null, Object? data = null}) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as ApprovalsSummaryModel,
          )
          as $Val,
    );
  }

  /// Create a copy of ApprovalsSummaryResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApprovalsSummaryModelCopyWith<$Res> get data {
    return $ApprovalsSummaryModelCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ApprovalsSummaryResponseImplCopyWith<$Res>
    implements $ApprovalsSummaryResponseCopyWith<$Res> {
  factory _$$ApprovalsSummaryResponseImplCopyWith(
    _$ApprovalsSummaryResponseImpl value,
    $Res Function(_$ApprovalsSummaryResponseImpl) then,
  ) = __$$ApprovalsSummaryResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, ApprovalsSummaryModel data});

  @override
  $ApprovalsSummaryModelCopyWith<$Res> get data;
}

/// @nodoc
class __$$ApprovalsSummaryResponseImplCopyWithImpl<$Res>
    extends
        _$ApprovalsSummaryResponseCopyWithImpl<
          $Res,
          _$ApprovalsSummaryResponseImpl
        >
    implements _$$ApprovalsSummaryResponseImplCopyWith<$Res> {
  __$$ApprovalsSummaryResponseImplCopyWithImpl(
    _$ApprovalsSummaryResponseImpl _value,
    $Res Function(_$ApprovalsSummaryResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApprovalsSummaryResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? success = null, Object? data = null}) {
    return _then(
      _$ApprovalsSummaryResponseImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        data: null == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as ApprovalsSummaryModel,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ApprovalsSummaryResponseImpl implements _ApprovalsSummaryResponse {
  const _$ApprovalsSummaryResponseImpl({
    required this.success,
    required this.data,
  });

  factory _$ApprovalsSummaryResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApprovalsSummaryResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final ApprovalsSummaryModel data;

  @override
  String toString() {
    return 'ApprovalsSummaryResponse(success: $success, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApprovalsSummaryResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, data);

  /// Create a copy of ApprovalsSummaryResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApprovalsSummaryResponseImplCopyWith<_$ApprovalsSummaryResponseImpl>
  get copyWith =>
      __$$ApprovalsSummaryResponseImplCopyWithImpl<
        _$ApprovalsSummaryResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApprovalsSummaryResponseImplToJson(this);
  }
}

abstract class _ApprovalsSummaryResponse implements ApprovalsSummaryResponse {
  const factory _ApprovalsSummaryResponse({
    required final bool success,
    required final ApprovalsSummaryModel data,
  }) = _$ApprovalsSummaryResponseImpl;

  factory _ApprovalsSummaryResponse.fromJson(Map<String, dynamic> json) =
      _$ApprovalsSummaryResponseImpl.fromJson;

  @override
  bool get success;
  @override
  ApprovalsSummaryModel get data;

  /// Create a copy of ApprovalsSummaryResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApprovalsSummaryResponseImplCopyWith<_$ApprovalsSummaryResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}
