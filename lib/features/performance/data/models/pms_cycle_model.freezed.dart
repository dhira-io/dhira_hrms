// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pms_cycle_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PmsCycleModel _$PmsCycleModelFromJson(Map<String, dynamic> json) {
  return _PmsCycleModel.fromJson(json);
}

/// @nodoc
mixin _$PmsCycleModel {
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'cycle_name')
  String get cycleName => throw _privateConstructorUsedError;

  /// Serializes this PmsCycleModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PmsCycleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PmsCycleModelCopyWith<PmsCycleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PmsCycleModelCopyWith<$Res> {
  factory $PmsCycleModelCopyWith(
    PmsCycleModel value,
    $Res Function(PmsCycleModel) then,
  ) = _$PmsCycleModelCopyWithImpl<$Res, PmsCycleModel>;
  @useResult
  $Res call({String name, @JsonKey(name: 'cycle_name') String cycleName});
}

/// @nodoc
class _$PmsCycleModelCopyWithImpl<$Res, $Val extends PmsCycleModel>
    implements $PmsCycleModelCopyWith<$Res> {
  _$PmsCycleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PmsCycleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? cycleName = null}) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            cycleName: null == cycleName
                ? _value.cycleName
                : cycleName // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PmsCycleModelImplCopyWith<$Res>
    implements $PmsCycleModelCopyWith<$Res> {
  factory _$$PmsCycleModelImplCopyWith(
    _$PmsCycleModelImpl value,
    $Res Function(_$PmsCycleModelImpl) then,
  ) = __$$PmsCycleModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, @JsonKey(name: 'cycle_name') String cycleName});
}

/// @nodoc
class __$$PmsCycleModelImplCopyWithImpl<$Res>
    extends _$PmsCycleModelCopyWithImpl<$Res, _$PmsCycleModelImpl>
    implements _$$PmsCycleModelImplCopyWith<$Res> {
  __$$PmsCycleModelImplCopyWithImpl(
    _$PmsCycleModelImpl _value,
    $Res Function(_$PmsCycleModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PmsCycleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? cycleName = null}) {
    return _then(
      _$PmsCycleModelImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        cycleName: null == cycleName
            ? _value.cycleName
            : cycleName // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PmsCycleModelImpl extends _PmsCycleModel {
  const _$PmsCycleModelImpl({
    required this.name,
    @JsonKey(name: 'cycle_name') required this.cycleName,
  }) : super._();

  factory _$PmsCycleModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PmsCycleModelImplFromJson(json);

  @override
  final String name;
  @override
  @JsonKey(name: 'cycle_name')
  final String cycleName;

  @override
  String toString() {
    return 'PmsCycleModel(name: $name, cycleName: $cycleName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PmsCycleModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.cycleName, cycleName) ||
                other.cycleName == cycleName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, cycleName);

  /// Create a copy of PmsCycleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PmsCycleModelImplCopyWith<_$PmsCycleModelImpl> get copyWith =>
      __$$PmsCycleModelImplCopyWithImpl<_$PmsCycleModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PmsCycleModelImplToJson(this);
  }
}

abstract class _PmsCycleModel extends PmsCycleModel {
  const factory _PmsCycleModel({
    required final String name,
    @JsonKey(name: 'cycle_name') required final String cycleName,
  }) = _$PmsCycleModelImpl;
  const _PmsCycleModel._() : super._();

  factory _PmsCycleModel.fromJson(Map<String, dynamic> json) =
      _$PmsCycleModelImpl.fromJson;

  @override
  String get name;
  @override
  @JsonKey(name: 'cycle_name')
  String get cycleName;

  /// Create a copy of PmsCycleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PmsCycleModelImplCopyWith<_$PmsCycleModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
