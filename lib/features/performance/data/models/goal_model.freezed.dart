// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goal_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GoalModel _$GoalModelFromJson(Map<String, dynamic> json) {
  return _GoalModel.fromJson(json);
}

/// @nodoc
mixin _$GoalModel {
  String get name => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'employee')
  String get employeeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'job_family')
  String? get jobFamily => throw _privateConstructorUsedError;
  @JsonKey(name: 'pms_cycle')
  String? get pmsCycle => throw _privateConstructorUsedError;
  List<KraModel> get kras => throw _privateConstructorUsedError;
  List<KpiModel> get kpis => throw _privateConstructorUsedError;

  /// Serializes this GoalModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GoalModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GoalModelCopyWith<GoalModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoalModelCopyWith<$Res> {
  factory $GoalModelCopyWith(GoalModel value, $Res Function(GoalModel) then) =
      _$GoalModelCopyWithImpl<$Res, GoalModel>;
  @useResult
  $Res call({
    String name,
    String status,
    @JsonKey(name: 'employee') String employeeId,
    @JsonKey(name: 'job_family') String? jobFamily,
    @JsonKey(name: 'pms_cycle') String? pmsCycle,
    List<KraModel> kras,
    List<KpiModel> kpis,
  });
}

/// @nodoc
class _$GoalModelCopyWithImpl<$Res, $Val extends GoalModel>
    implements $GoalModelCopyWith<$Res> {
  _$GoalModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GoalModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? status = null,
    Object? employeeId = null,
    Object? jobFamily = freezed,
    Object? pmsCycle = freezed,
    Object? kras = null,
    Object? kpis = null,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            employeeId: null == employeeId
                ? _value.employeeId
                : employeeId // ignore: cast_nullable_to_non_nullable
                      as String,
            jobFamily: freezed == jobFamily
                ? _value.jobFamily
                : jobFamily // ignore: cast_nullable_to_non_nullable
                      as String?,
            pmsCycle: freezed == pmsCycle
                ? _value.pmsCycle
                : pmsCycle // ignore: cast_nullable_to_non_nullable
                      as String?,
            kras: null == kras
                ? _value.kras
                : kras // ignore: cast_nullable_to_non_nullable
                      as List<KraModel>,
            kpis: null == kpis
                ? _value.kpis
                : kpis // ignore: cast_nullable_to_non_nullable
                      as List<KpiModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GoalModelImplCopyWith<$Res>
    implements $GoalModelCopyWith<$Res> {
  factory _$$GoalModelImplCopyWith(
    _$GoalModelImpl value,
    $Res Function(_$GoalModelImpl) then,
  ) = __$$GoalModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String status,
    @JsonKey(name: 'employee') String employeeId,
    @JsonKey(name: 'job_family') String? jobFamily,
    @JsonKey(name: 'pms_cycle') String? pmsCycle,
    List<KraModel> kras,
    List<KpiModel> kpis,
  });
}

/// @nodoc
class __$$GoalModelImplCopyWithImpl<$Res>
    extends _$GoalModelCopyWithImpl<$Res, _$GoalModelImpl>
    implements _$$GoalModelImplCopyWith<$Res> {
  __$$GoalModelImplCopyWithImpl(
    _$GoalModelImpl _value,
    $Res Function(_$GoalModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GoalModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? status = null,
    Object? employeeId = null,
    Object? jobFamily = freezed,
    Object? pmsCycle = freezed,
    Object? kras = null,
    Object? kpis = null,
  }) {
    return _then(
      _$GoalModelImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        employeeId: null == employeeId
            ? _value.employeeId
            : employeeId // ignore: cast_nullable_to_non_nullable
                  as String,
        jobFamily: freezed == jobFamily
            ? _value.jobFamily
            : jobFamily // ignore: cast_nullable_to_non_nullable
                  as String?,
        pmsCycle: freezed == pmsCycle
            ? _value.pmsCycle
            : pmsCycle // ignore: cast_nullable_to_non_nullable
                  as String?,
        kras: null == kras
            ? _value._kras
            : kras // ignore: cast_nullable_to_non_nullable
                  as List<KraModel>,
        kpis: null == kpis
            ? _value._kpis
            : kpis // ignore: cast_nullable_to_non_nullable
                  as List<KpiModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GoalModelImpl extends _GoalModel {
  const _$GoalModelImpl({
    required this.name,
    this.status = 'Draft',
    @JsonKey(name: 'employee') this.employeeId = '',
    @JsonKey(name: 'job_family') this.jobFamily,
    @JsonKey(name: 'pms_cycle') this.pmsCycle,
    final List<KraModel> kras = const [],
    final List<KpiModel> kpis = const [],
  }) : _kras = kras,
       _kpis = kpis,
       super._();

  factory _$GoalModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GoalModelImplFromJson(json);

  @override
  final String name;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey(name: 'employee')
  final String employeeId;
  @override
  @JsonKey(name: 'job_family')
  final String? jobFamily;
  @override
  @JsonKey(name: 'pms_cycle')
  final String? pmsCycle;
  final List<KraModel> _kras;
  @override
  @JsonKey()
  List<KraModel> get kras {
    if (_kras is EqualUnmodifiableListView) return _kras;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_kras);
  }

  final List<KpiModel> _kpis;
  @override
  @JsonKey()
  List<KpiModel> get kpis {
    if (_kpis is EqualUnmodifiableListView) return _kpis;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_kpis);
  }

  @override
  String toString() {
    return 'GoalModel(name: $name, status: $status, employeeId: $employeeId, jobFamily: $jobFamily, pmsCycle: $pmsCycle, kras: $kras, kpis: $kpis)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoalModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.jobFamily, jobFamily) ||
                other.jobFamily == jobFamily) &&
            (identical(other.pmsCycle, pmsCycle) ||
                other.pmsCycle == pmsCycle) &&
            const DeepCollectionEquality().equals(other._kras, _kras) &&
            const DeepCollectionEquality().equals(other._kpis, _kpis));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    status,
    employeeId,
    jobFamily,
    pmsCycle,
    const DeepCollectionEquality().hash(_kras),
    const DeepCollectionEquality().hash(_kpis),
  );

  /// Create a copy of GoalModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GoalModelImplCopyWith<_$GoalModelImpl> get copyWith =>
      __$$GoalModelImplCopyWithImpl<_$GoalModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GoalModelImplToJson(this);
  }
}

abstract class _GoalModel extends GoalModel {
  const factory _GoalModel({
    required final String name,
    final String status,
    @JsonKey(name: 'employee') final String employeeId,
    @JsonKey(name: 'job_family') final String? jobFamily,
    @JsonKey(name: 'pms_cycle') final String? pmsCycle,
    final List<KraModel> kras,
    final List<KpiModel> kpis,
  }) = _$GoalModelImpl;
  const _GoalModel._() : super._();

  factory _GoalModel.fromJson(Map<String, dynamic> json) =
      _$GoalModelImpl.fromJson;

  @override
  String get name;
  @override
  String get status;
  @override
  @JsonKey(name: 'employee')
  String get employeeId;
  @override
  @JsonKey(name: 'job_family')
  String? get jobFamily;
  @override
  @JsonKey(name: 'pms_cycle')
  String? get pmsCycle;
  @override
  List<KraModel> get kras;
  @override
  List<KpiModel> get kpis;

  /// Create a copy of GoalModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoalModelImplCopyWith<_$GoalModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
