// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_evaluation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TeamEvaluationModel _$TeamEvaluationModelFromJson(Map<String, dynamic> json) {
  return _TeamEvaluationModel.fromJson(json);
}

/// @nodoc
mixin _$TeamEvaluationModel {
  String get name => throw _privateConstructorUsedError;
  String get employee => throw _privateConstructorUsedError;
  String? get employeeName => throw _privateConstructorUsedError;
  String? get employeeStatus => throw _privateConstructorUsedError;
  String get department => throw _privateConstructorUsedError;
  String get cycle => throw _privateConstructorUsedError;
  int get docstatus => throw _privateConstructorUsedError;
  DateTime get creation => throw _privateConstructorUsedError;
  DateTime get modified => throw _privateConstructorUsedError;
  @JsonKey(name: 'overall_rating')
  double get overallRating => throw _privateConstructorUsedError;
  @JsonKey(name: 'goal_score')
  double get goalScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'self_assesment')
  String get selfAssessment => throw _privateConstructorUsedError;
  String get manager => throw _privateConstructorUsedError;

  /// Serializes this TeamEvaluationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TeamEvaluationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeamEvaluationModelCopyWith<TeamEvaluationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamEvaluationModelCopyWith<$Res> {
  factory $TeamEvaluationModelCopyWith(
    TeamEvaluationModel value,
    $Res Function(TeamEvaluationModel) then,
  ) = _$TeamEvaluationModelCopyWithImpl<$Res, TeamEvaluationModel>;
  @useResult
  $Res call({
    String name,
    String employee,
    String? employeeName,
    String? employeeStatus,
    String department,
    String cycle,
    int docstatus,
    DateTime creation,
    DateTime modified,
    @JsonKey(name: 'overall_rating') double overallRating,
    @JsonKey(name: 'goal_score') double goalScore,
    @JsonKey(name: 'self_assesment') String selfAssessment,
    String manager,
  });
}

/// @nodoc
class _$TeamEvaluationModelCopyWithImpl<$Res, $Val extends TeamEvaluationModel>
    implements $TeamEvaluationModelCopyWith<$Res> {
  _$TeamEvaluationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TeamEvaluationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? employee = null,
    Object? employeeName = freezed,
    Object? employeeStatus = freezed,
    Object? department = null,
    Object? cycle = null,
    Object? docstatus = null,
    Object? creation = null,
    Object? modified = null,
    Object? overallRating = null,
    Object? goalScore = null,
    Object? selfAssessment = null,
    Object? manager = null,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            employee: null == employee
                ? _value.employee
                : employee // ignore: cast_nullable_to_non_nullable
                      as String,
            employeeName: freezed == employeeName
                ? _value.employeeName
                : employeeName // ignore: cast_nullable_to_non_nullable
                      as String?,
            employeeStatus: freezed == employeeStatus
                ? _value.employeeStatus
                : employeeStatus // ignore: cast_nullable_to_non_nullable
                      as String?,
            department: null == department
                ? _value.department
                : department // ignore: cast_nullable_to_non_nullable
                      as String,
            cycle: null == cycle
                ? _value.cycle
                : cycle // ignore: cast_nullable_to_non_nullable
                      as String,
            docstatus: null == docstatus
                ? _value.docstatus
                : docstatus // ignore: cast_nullable_to_non_nullable
                      as int,
            creation: null == creation
                ? _value.creation
                : creation // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            modified: null == modified
                ? _value.modified
                : modified // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            overallRating: null == overallRating
                ? _value.overallRating
                : overallRating // ignore: cast_nullable_to_non_nullable
                      as double,
            goalScore: null == goalScore
                ? _value.goalScore
                : goalScore // ignore: cast_nullable_to_non_nullable
                      as double,
            selfAssessment: null == selfAssessment
                ? _value.selfAssessment
                : selfAssessment // ignore: cast_nullable_to_non_nullable
                      as String,
            manager: null == manager
                ? _value.manager
                : manager // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TeamEvaluationModelImplCopyWith<$Res>
    implements $TeamEvaluationModelCopyWith<$Res> {
  factory _$$TeamEvaluationModelImplCopyWith(
    _$TeamEvaluationModelImpl value,
    $Res Function(_$TeamEvaluationModelImpl) then,
  ) = __$$TeamEvaluationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String employee,
    String? employeeName,
    String? employeeStatus,
    String department,
    String cycle,
    int docstatus,
    DateTime creation,
    DateTime modified,
    @JsonKey(name: 'overall_rating') double overallRating,
    @JsonKey(name: 'goal_score') double goalScore,
    @JsonKey(name: 'self_assesment') String selfAssessment,
    String manager,
  });
}

/// @nodoc
class __$$TeamEvaluationModelImplCopyWithImpl<$Res>
    extends _$TeamEvaluationModelCopyWithImpl<$Res, _$TeamEvaluationModelImpl>
    implements _$$TeamEvaluationModelImplCopyWith<$Res> {
  __$$TeamEvaluationModelImplCopyWithImpl(
    _$TeamEvaluationModelImpl _value,
    $Res Function(_$TeamEvaluationModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TeamEvaluationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? employee = null,
    Object? employeeName = freezed,
    Object? employeeStatus = freezed,
    Object? department = null,
    Object? cycle = null,
    Object? docstatus = null,
    Object? creation = null,
    Object? modified = null,
    Object? overallRating = null,
    Object? goalScore = null,
    Object? selfAssessment = null,
    Object? manager = null,
  }) {
    return _then(
      _$TeamEvaluationModelImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        employee: null == employee
            ? _value.employee
            : employee // ignore: cast_nullable_to_non_nullable
                  as String,
        employeeName: freezed == employeeName
            ? _value.employeeName
            : employeeName // ignore: cast_nullable_to_non_nullable
                  as String?,
        employeeStatus: freezed == employeeStatus
            ? _value.employeeStatus
            : employeeStatus // ignore: cast_nullable_to_non_nullable
                  as String?,
        department: null == department
            ? _value.department
            : department // ignore: cast_nullable_to_non_nullable
                  as String,
        cycle: null == cycle
            ? _value.cycle
            : cycle // ignore: cast_nullable_to_non_nullable
                  as String,
        docstatus: null == docstatus
            ? _value.docstatus
            : docstatus // ignore: cast_nullable_to_non_nullable
                  as int,
        creation: null == creation
            ? _value.creation
            : creation // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        modified: null == modified
            ? _value.modified
            : modified // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        overallRating: null == overallRating
            ? _value.overallRating
            : overallRating // ignore: cast_nullable_to_non_nullable
                  as double,
        goalScore: null == goalScore
            ? _value.goalScore
            : goalScore // ignore: cast_nullable_to_non_nullable
                  as double,
        selfAssessment: null == selfAssessment
            ? _value.selfAssessment
            : selfAssessment // ignore: cast_nullable_to_non_nullable
                  as String,
        manager: null == manager
            ? _value.manager
            : manager // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamEvaluationModelImpl extends _TeamEvaluationModel {
  const _$TeamEvaluationModelImpl({
    required this.name,
    required this.employee,
    this.employeeName,
    this.employeeStatus,
    required this.department,
    required this.cycle,
    required this.docstatus,
    required this.creation,
    required this.modified,
    @JsonKey(name: 'overall_rating') required this.overallRating,
    @JsonKey(name: 'goal_score') required this.goalScore,
    @JsonKey(name: 'self_assesment') required this.selfAssessment,
    required this.manager,
  }) : super._();

  factory _$TeamEvaluationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamEvaluationModelImplFromJson(json);

  @override
  final String name;
  @override
  final String employee;
  @override
  final String? employeeName;
  @override
  final String? employeeStatus;
  @override
  final String department;
  @override
  final String cycle;
  @override
  final int docstatus;
  @override
  final DateTime creation;
  @override
  final DateTime modified;
  @override
  @JsonKey(name: 'overall_rating')
  final double overallRating;
  @override
  @JsonKey(name: 'goal_score')
  final double goalScore;
  @override
  @JsonKey(name: 'self_assesment')
  final String selfAssessment;
  @override
  final String manager;

  @override
  String toString() {
    return 'TeamEvaluationModel(name: $name, employee: $employee, employeeName: $employeeName, employeeStatus: $employeeStatus, department: $department, cycle: $cycle, docstatus: $docstatus, creation: $creation, modified: $modified, overallRating: $overallRating, goalScore: $goalScore, selfAssessment: $selfAssessment, manager: $manager)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamEvaluationModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.employee, employee) ||
                other.employee == employee) &&
            (identical(other.employeeName, employeeName) ||
                other.employeeName == employeeName) &&
            (identical(other.employeeStatus, employeeStatus) ||
                other.employeeStatus == employeeStatus) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.cycle, cycle) || other.cycle == cycle) &&
            (identical(other.docstatus, docstatus) ||
                other.docstatus == docstatus) &&
            (identical(other.creation, creation) ||
                other.creation == creation) &&
            (identical(other.modified, modified) ||
                other.modified == modified) &&
            (identical(other.overallRating, overallRating) ||
                other.overallRating == overallRating) &&
            (identical(other.goalScore, goalScore) ||
                other.goalScore == goalScore) &&
            (identical(other.selfAssessment, selfAssessment) ||
                other.selfAssessment == selfAssessment) &&
            (identical(other.manager, manager) || other.manager == manager));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    employee,
    employeeName,
    employeeStatus,
    department,
    cycle,
    docstatus,
    creation,
    modified,
    overallRating,
    goalScore,
    selfAssessment,
    manager,
  );

  /// Create a copy of TeamEvaluationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamEvaluationModelImplCopyWith<_$TeamEvaluationModelImpl> get copyWith =>
      __$$TeamEvaluationModelImplCopyWithImpl<_$TeamEvaluationModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamEvaluationModelImplToJson(this);
  }
}

abstract class _TeamEvaluationModel extends TeamEvaluationModel {
  const factory _TeamEvaluationModel({
    required final String name,
    required final String employee,
    final String? employeeName,
    final String? employeeStatus,
    required final String department,
    required final String cycle,
    required final int docstatus,
    required final DateTime creation,
    required final DateTime modified,
    @JsonKey(name: 'overall_rating') required final double overallRating,
    @JsonKey(name: 'goal_score') required final double goalScore,
    @JsonKey(name: 'self_assesment') required final String selfAssessment,
    required final String manager,
  }) = _$TeamEvaluationModelImpl;
  const _TeamEvaluationModel._() : super._();

  factory _TeamEvaluationModel.fromJson(Map<String, dynamic> json) =
      _$TeamEvaluationModelImpl.fromJson;

  @override
  String get name;
  @override
  String get employee;
  @override
  String? get employeeName;
  @override
  String? get employeeStatus;
  @override
  String get department;
  @override
  String get cycle;
  @override
  int get docstatus;
  @override
  DateTime get creation;
  @override
  DateTime get modified;
  @override
  @JsonKey(name: 'overall_rating')
  double get overallRating;
  @override
  @JsonKey(name: 'goal_score')
  double get goalScore;
  @override
  @JsonKey(name: 'self_assesment')
  String get selfAssessment;
  @override
  String get manager;

  /// Create a copy of TeamEvaluationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeamEvaluationModelImplCopyWith<_$TeamEvaluationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
