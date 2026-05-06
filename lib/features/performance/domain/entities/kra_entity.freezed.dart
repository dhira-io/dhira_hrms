// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kra_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$KraEntity {
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get weightage => throw _privateConstructorUsedError;

  /// Create a copy of KraEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KraEntityCopyWith<KraEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KraEntityCopyWith<$Res> {
  factory $KraEntityCopyWith(KraEntity value, $Res Function(KraEntity) then) =
      _$KraEntityCopyWithImpl<$Res, KraEntity>;
  @useResult
  $Res call({String? id, String name, double weightage});
}

/// @nodoc
class _$KraEntityCopyWithImpl<$Res, $Val extends KraEntity>
    implements $KraEntityCopyWith<$Res> {
  _$KraEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KraEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? weightage = null,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            weightage: null == weightage
                ? _value.weightage
                : weightage // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$KraEntityImplCopyWith<$Res>
    implements $KraEntityCopyWith<$Res> {
  factory _$$KraEntityImplCopyWith(
    _$KraEntityImpl value,
    $Res Function(_$KraEntityImpl) then,
  ) = __$$KraEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String name, double weightage});
}

/// @nodoc
class __$$KraEntityImplCopyWithImpl<$Res>
    extends _$KraEntityCopyWithImpl<$Res, _$KraEntityImpl>
    implements _$$KraEntityImplCopyWith<$Res> {
  __$$KraEntityImplCopyWithImpl(
    _$KraEntityImpl _value,
    $Res Function(_$KraEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of KraEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? weightage = null,
  }) {
    return _then(
      _$KraEntityImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        weightage: null == weightage
            ? _value.weightage
            : weightage // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$KraEntityImpl implements _KraEntity {
  const _$KraEntityImpl({this.id, required this.name, this.weightage = 0.0});

  @override
  final String? id;
  @override
  final String name;
  @override
  @JsonKey()
  final double weightage;

  @override
  String toString() {
    return 'KraEntity(id: $id, name: $name, weightage: $weightage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KraEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.weightage, weightage) ||
                other.weightage == weightage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, weightage);

  /// Create a copy of KraEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KraEntityImplCopyWith<_$KraEntityImpl> get copyWith =>
      __$$KraEntityImplCopyWithImpl<_$KraEntityImpl>(this, _$identity);
}

abstract class _KraEntity implements KraEntity {
  const factory _KraEntity({
    final String? id,
    required final String name,
    final double weightage,
  }) = _$KraEntityImpl;

  @override
  String? get id;
  @override
  String get name;
  @override
  double get weightage;

  /// Create a copy of KraEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KraEntityImplCopyWith<_$KraEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
