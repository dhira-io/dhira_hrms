// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goal_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$GoalEntity {
  String get name => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get employeeId => throw _privateConstructorUsedError;
  String? get jobFamily => throw _privateConstructorUsedError;
  String? get pmsCycle => throw _privateConstructorUsedError;
  List<KraEntity> get kras => throw _privateConstructorUsedError;
  List<KpiEntity> get kpis => throw _privateConstructorUsedError;

  /// Create a copy of GoalEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GoalEntityCopyWith<GoalEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoalEntityCopyWith<$Res> {
  factory $GoalEntityCopyWith(
    GoalEntity value,
    $Res Function(GoalEntity) then,
  ) = _$GoalEntityCopyWithImpl<$Res, GoalEntity>;
  @useResult
  $Res call({
    String name,
    String status,
    String employeeId,
    String? jobFamily,
    String? pmsCycle,
    List<KraEntity> kras,
    List<KpiEntity> kpis,
  });
}

/// @nodoc
class _$GoalEntityCopyWithImpl<$Res, $Val extends GoalEntity>
    implements $GoalEntityCopyWith<$Res> {
  _$GoalEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GoalEntity
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
                      as List<KraEntity>,
            kpis: null == kpis
                ? _value.kpis
                : kpis // ignore: cast_nullable_to_non_nullable
                      as List<KpiEntity>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GoalEntityImplCopyWith<$Res>
    implements $GoalEntityCopyWith<$Res> {
  factory _$$GoalEntityImplCopyWith(
    _$GoalEntityImpl value,
    $Res Function(_$GoalEntityImpl) then,
  ) = __$$GoalEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String status,
    String employeeId,
    String? jobFamily,
    String? pmsCycle,
    List<KraEntity> kras,
    List<KpiEntity> kpis,
  });
}

/// @nodoc
class __$$GoalEntityImplCopyWithImpl<$Res>
    extends _$GoalEntityCopyWithImpl<$Res, _$GoalEntityImpl>
    implements _$$GoalEntityImplCopyWith<$Res> {
  __$$GoalEntityImplCopyWithImpl(
    _$GoalEntityImpl _value,
    $Res Function(_$GoalEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GoalEntity
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
      _$GoalEntityImpl(
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
                  as List<KraEntity>,
        kpis: null == kpis
            ? _value._kpis
            : kpis // ignore: cast_nullable_to_non_nullable
                  as List<KpiEntity>,
      ),
    );
  }
}

/// @nodoc

class _$GoalEntityImpl implements _GoalEntity {
  const _$GoalEntityImpl({
    required this.name,
    this.status = 'Draft',
    this.employeeId = '',
    this.jobFamily,
    this.pmsCycle,
    final List<KraEntity> kras = const [],
    final List<KpiEntity> kpis = const [],
  }) : _kras = kras,
       _kpis = kpis;

  @override
  final String name;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String employeeId;
  @override
  final String? jobFamily;
  @override
  final String? pmsCycle;
  final List<KraEntity> _kras;
  @override
  @JsonKey()
  List<KraEntity> get kras {
    if (_kras is EqualUnmodifiableListView) return _kras;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_kras);
  }

  final List<KpiEntity> _kpis;
  @override
  @JsonKey()
  List<KpiEntity> get kpis {
    if (_kpis is EqualUnmodifiableListView) return _kpis;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_kpis);
  }

  @override
  String toString() {
    return 'GoalEntity(name: $name, status: $status, employeeId: $employeeId, jobFamily: $jobFamily, pmsCycle: $pmsCycle, kras: $kras, kpis: $kpis)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoalEntityImpl &&
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

  /// Create a copy of GoalEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GoalEntityImplCopyWith<_$GoalEntityImpl> get copyWith =>
      __$$GoalEntityImplCopyWithImpl<_$GoalEntityImpl>(this, _$identity);
}

abstract class _GoalEntity implements GoalEntity {
  const factory _GoalEntity({
    required final String name,
    final String status,
    final String employeeId,
    final String? jobFamily,
    final String? pmsCycle,
    final List<KraEntity> kras,
    final List<KpiEntity> kpis,
  }) = _$GoalEntityImpl;

  @override
  String get name;
  @override
  String get status;
  @override
  String get employeeId;
  @override
  String? get jobFamily;
  @override
  String? get pmsCycle;
  @override
  List<KraEntity> get kras;
  @override
  List<KpiEntity> get kpis;

  /// Create a copy of GoalEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoalEntityImplCopyWith<_$GoalEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
