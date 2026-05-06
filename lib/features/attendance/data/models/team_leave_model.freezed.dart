// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_leave_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TeamLeaveModel _$TeamLeaveModelFromJson(Map<String, dynamic> json) {
  return _TeamLeaveModel.fromJson(json);
}

/// @nodoc
mixin _$TeamLeaveModel {
  Map<String, dynamic> get employee => throw _privateConstructorUsedError;
  @JsonKey(name: 'leave_type')
  String get leaveType => throw _privateConstructorUsedError;
  @JsonKey(name: 'from_date')
  String get fromDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'to_date')
  String get toDate => throw _privateConstructorUsedError;

  /// Serializes this TeamLeaveModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TeamLeaveModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeamLeaveModelCopyWith<TeamLeaveModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamLeaveModelCopyWith<$Res> {
  factory $TeamLeaveModelCopyWith(
    TeamLeaveModel value,
    $Res Function(TeamLeaveModel) then,
  ) = _$TeamLeaveModelCopyWithImpl<$Res, TeamLeaveModel>;
  @useResult
  $Res call({
    Map<String, dynamic> employee,
    @JsonKey(name: 'leave_type') String leaveType,
    @JsonKey(name: 'from_date') String fromDate,
    @JsonKey(name: 'to_date') String toDate,
  });
}

/// @nodoc
class _$TeamLeaveModelCopyWithImpl<$Res, $Val extends TeamLeaveModel>
    implements $TeamLeaveModelCopyWith<$Res> {
  _$TeamLeaveModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TeamLeaveModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employee = null,
    Object? leaveType = null,
    Object? fromDate = null,
    Object? toDate = null,
  }) {
    return _then(
      _value.copyWith(
            employee: null == employee
                ? _value.employee
                : employee // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            leaveType: null == leaveType
                ? _value.leaveType
                : leaveType // ignore: cast_nullable_to_non_nullable
                      as String,
            fromDate: null == fromDate
                ? _value.fromDate
                : fromDate // ignore: cast_nullable_to_non_nullable
                      as String,
            toDate: null == toDate
                ? _value.toDate
                : toDate // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TeamLeaveModelImplCopyWith<$Res>
    implements $TeamLeaveModelCopyWith<$Res> {
  factory _$$TeamLeaveModelImplCopyWith(
    _$TeamLeaveModelImpl value,
    $Res Function(_$TeamLeaveModelImpl) then,
  ) = __$$TeamLeaveModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Map<String, dynamic> employee,
    @JsonKey(name: 'leave_type') String leaveType,
    @JsonKey(name: 'from_date') String fromDate,
    @JsonKey(name: 'to_date') String toDate,
  });
}

/// @nodoc
class __$$TeamLeaveModelImplCopyWithImpl<$Res>
    extends _$TeamLeaveModelCopyWithImpl<$Res, _$TeamLeaveModelImpl>
    implements _$$TeamLeaveModelImplCopyWith<$Res> {
  __$$TeamLeaveModelImplCopyWithImpl(
    _$TeamLeaveModelImpl _value,
    $Res Function(_$TeamLeaveModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TeamLeaveModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employee = null,
    Object? leaveType = null,
    Object? fromDate = null,
    Object? toDate = null,
  }) {
    return _then(
      _$TeamLeaveModelImpl(
        employee: null == employee
            ? _value._employee
            : employee // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        leaveType: null == leaveType
            ? _value.leaveType
            : leaveType // ignore: cast_nullable_to_non_nullable
                  as String,
        fromDate: null == fromDate
            ? _value.fromDate
            : fromDate // ignore: cast_nullable_to_non_nullable
                  as String,
        toDate: null == toDate
            ? _value.toDate
            : toDate // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamLeaveModelImpl extends _TeamLeaveModel {
  const _$TeamLeaveModelImpl({
    required final Map<String, dynamic> employee,
    @JsonKey(name: 'leave_type') required this.leaveType,
    @JsonKey(name: 'from_date') required this.fromDate,
    @JsonKey(name: 'to_date') required this.toDate,
  }) : _employee = employee,
       super._();

  factory _$TeamLeaveModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamLeaveModelImplFromJson(json);

  final Map<String, dynamic> _employee;
  @override
  Map<String, dynamic> get employee {
    if (_employee is EqualUnmodifiableMapView) return _employee;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_employee);
  }

  @override
  @JsonKey(name: 'leave_type')
  final String leaveType;
  @override
  @JsonKey(name: 'from_date')
  final String fromDate;
  @override
  @JsonKey(name: 'to_date')
  final String toDate;

  @override
  String toString() {
    return 'TeamLeaveModel(employee: $employee, leaveType: $leaveType, fromDate: $fromDate, toDate: $toDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamLeaveModelImpl &&
            const DeepCollectionEquality().equals(other._employee, _employee) &&
            (identical(other.leaveType, leaveType) ||
                other.leaveType == leaveType) &&
            (identical(other.fromDate, fromDate) ||
                other.fromDate == fromDate) &&
            (identical(other.toDate, toDate) || other.toDate == toDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_employee),
    leaveType,
    fromDate,
    toDate,
  );

  /// Create a copy of TeamLeaveModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamLeaveModelImplCopyWith<_$TeamLeaveModelImpl> get copyWith =>
      __$$TeamLeaveModelImplCopyWithImpl<_$TeamLeaveModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamLeaveModelImplToJson(this);
  }
}

abstract class _TeamLeaveModel extends TeamLeaveModel {
  const factory _TeamLeaveModel({
    required final Map<String, dynamic> employee,
    @JsonKey(name: 'leave_type') required final String leaveType,
    @JsonKey(name: 'from_date') required final String fromDate,
    @JsonKey(name: 'to_date') required final String toDate,
  }) = _$TeamLeaveModelImpl;
  const _TeamLeaveModel._() : super._();

  factory _TeamLeaveModel.fromJson(Map<String, dynamic> json) =
      _$TeamLeaveModelImpl.fromJson;

  @override
  Map<String, dynamic> get employee;
  @override
  @JsonKey(name: 'leave_type')
  String get leaveType;
  @override
  @JsonKey(name: 'from_date')
  String get fromDate;
  @override
  @JsonKey(name: 'to_date')
  String get toDate;

  /// Create a copy of TeamLeaveModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeamLeaveModelImplCopyWith<_$TeamLeaveModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
