// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kpi_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

KpiModel _$KpiModelFromJson(Map<String, dynamic> json) {
  return _KpiModel.fromJson(json);
}

/// @nodoc
mixin _$KpiModel {
  @JsonKey(includeIfNull: false)
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'kpi')
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'kras')
  String get kra => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get weightage => throw _privateConstructorUsedError;
  double get target => throw _privateConstructorUsedError;
  int? get idx => throw _privateConstructorUsedError;

  /// Serializes this KpiModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KpiModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KpiModelCopyWith<KpiModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KpiModelCopyWith<$Res> {
  factory $KpiModelCopyWith(KpiModel value, $Res Function(KpiModel) then) =
      _$KpiModelCopyWithImpl<$Res, KpiModel>;
  @useResult
  $Res call({
    @JsonKey(includeIfNull: false) String? name,
    @JsonKey(name: 'kpi') String title,
    @JsonKey(name: 'kras') String kra,
    String description,
    double weightage,
    double target,
    int? idx,
  });
}

/// @nodoc
class _$KpiModelCopyWithImpl<$Res, $Val extends KpiModel>
    implements $KpiModelCopyWith<$Res> {
  _$KpiModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KpiModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? title = null,
    Object? kra = null,
    Object? description = null,
    Object? weightage = null,
    Object? target = null,
    Object? idx = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            kra: null == kra
                ? _value.kra
                : kra // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            weightage: null == weightage
                ? _value.weightage
                : weightage // ignore: cast_nullable_to_non_nullable
                      as double,
            target: null == target
                ? _value.target
                : target // ignore: cast_nullable_to_non_nullable
                      as double,
            idx: freezed == idx
                ? _value.idx
                : idx // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$KpiModelImplCopyWith<$Res>
    implements $KpiModelCopyWith<$Res> {
  factory _$$KpiModelImplCopyWith(
    _$KpiModelImpl value,
    $Res Function(_$KpiModelImpl) then,
  ) = __$$KpiModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(includeIfNull: false) String? name,
    @JsonKey(name: 'kpi') String title,
    @JsonKey(name: 'kras') String kra,
    String description,
    double weightage,
    double target,
    int? idx,
  });
}

/// @nodoc
class __$$KpiModelImplCopyWithImpl<$Res>
    extends _$KpiModelCopyWithImpl<$Res, _$KpiModelImpl>
    implements _$$KpiModelImplCopyWith<$Res> {
  __$$KpiModelImplCopyWithImpl(
    _$KpiModelImpl _value,
    $Res Function(_$KpiModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of KpiModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? title = null,
    Object? kra = null,
    Object? description = null,
    Object? weightage = null,
    Object? target = null,
    Object? idx = freezed,
  }) {
    return _then(
      _$KpiModelImpl(
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        kra: null == kra
            ? _value.kra
            : kra // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        weightage: null == weightage
            ? _value.weightage
            : weightage // ignore: cast_nullable_to_non_nullable
                  as double,
        target: null == target
            ? _value.target
            : target // ignore: cast_nullable_to_non_nullable
                  as double,
        idx: freezed == idx
            ? _value.idx
            : idx // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$KpiModelImpl extends _KpiModel {
  const _$KpiModelImpl({
    @JsonKey(includeIfNull: false) this.name,
    @JsonKey(name: 'kpi') this.title = '',
    @JsonKey(name: 'kras') this.kra = '',
    this.description = '',
    this.weightage = 0.0,
    this.target = 0.0,
    this.idx,
  }) : super._();

  factory _$KpiModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$KpiModelImplFromJson(json);

  @override
  @JsonKey(includeIfNull: false)
  final String? name;
  @override
  @JsonKey(name: 'kpi')
  final String title;
  @override
  @JsonKey(name: 'kras')
  final String kra;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final double weightage;
  @override
  @JsonKey()
  final double target;
  @override
  final int? idx;

  @override
  String toString() {
    return 'KpiModel(name: $name, title: $title, kra: $kra, description: $description, weightage: $weightage, target: $target, idx: $idx)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KpiModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.kra, kra) || other.kra == kra) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.weightage, weightage) ||
                other.weightage == weightage) &&
            (identical(other.target, target) || other.target == target) &&
            (identical(other.idx, idx) || other.idx == idx));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    title,
    kra,
    description,
    weightage,
    target,
    idx,
  );

  /// Create a copy of KpiModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KpiModelImplCopyWith<_$KpiModelImpl> get copyWith =>
      __$$KpiModelImplCopyWithImpl<_$KpiModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KpiModelImplToJson(this);
  }
}

abstract class _KpiModel extends KpiModel {
  const factory _KpiModel({
    @JsonKey(includeIfNull: false) final String? name,
    @JsonKey(name: 'kpi') final String title,
    @JsonKey(name: 'kras') final String kra,
    final String description,
    final double weightage,
    final double target,
    final int? idx,
  }) = _$KpiModelImpl;
  const _KpiModel._() : super._();

  factory _KpiModel.fromJson(Map<String, dynamic> json) =
      _$KpiModelImpl.fromJson;

  @override
  @JsonKey(includeIfNull: false)
  String? get name;
  @override
  @JsonKey(name: 'kpi')
  String get title;
  @override
  @JsonKey(name: 'kras')
  String get kra;
  @override
  String get description;
  @override
  double get weightage;
  @override
  double get target;
  @override
  int? get idx;

  /// Create a copy of KpiModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KpiModelImplCopyWith<_$KpiModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
