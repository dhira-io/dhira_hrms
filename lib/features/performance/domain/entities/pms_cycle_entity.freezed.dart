// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pms_cycle_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PmsCycleEntity {
  String get name => throw _privateConstructorUsedError;
  String get cycleName => throw _privateConstructorUsedError;

  /// Create a copy of PmsCycleEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PmsCycleEntityCopyWith<PmsCycleEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PmsCycleEntityCopyWith<$Res> {
  factory $PmsCycleEntityCopyWith(
    PmsCycleEntity value,
    $Res Function(PmsCycleEntity) then,
  ) = _$PmsCycleEntityCopyWithImpl<$Res, PmsCycleEntity>;
  @useResult
  $Res call({String name, String cycleName});
}

/// @nodoc
class _$PmsCycleEntityCopyWithImpl<$Res, $Val extends PmsCycleEntity>
    implements $PmsCycleEntityCopyWith<$Res> {
  _$PmsCycleEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PmsCycleEntity
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
abstract class _$$PmsCycleEntityImplCopyWith<$Res>
    implements $PmsCycleEntityCopyWith<$Res> {
  factory _$$PmsCycleEntityImplCopyWith(
    _$PmsCycleEntityImpl value,
    $Res Function(_$PmsCycleEntityImpl) then,
  ) = __$$PmsCycleEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String cycleName});
}

/// @nodoc
class __$$PmsCycleEntityImplCopyWithImpl<$Res>
    extends _$PmsCycleEntityCopyWithImpl<$Res, _$PmsCycleEntityImpl>
    implements _$$PmsCycleEntityImplCopyWith<$Res> {
  __$$PmsCycleEntityImplCopyWithImpl(
    _$PmsCycleEntityImpl _value,
    $Res Function(_$PmsCycleEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PmsCycleEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? cycleName = null}) {
    return _then(
      _$PmsCycleEntityImpl(
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

class _$PmsCycleEntityImpl implements _PmsCycleEntity {
  const _$PmsCycleEntityImpl({required this.name, required this.cycleName});

  @override
  final String name;
  @override
  final String cycleName;

  @override
  String toString() {
    return 'PmsCycleEntity(name: $name, cycleName: $cycleName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PmsCycleEntityImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.cycleName, cycleName) ||
                other.cycleName == cycleName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, cycleName);

  /// Create a copy of PmsCycleEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PmsCycleEntityImplCopyWith<_$PmsCycleEntityImpl> get copyWith =>
      __$$PmsCycleEntityImplCopyWithImpl<_$PmsCycleEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _PmsCycleEntity implements PmsCycleEntity {
  const factory _PmsCycleEntity({
    required final String name,
    required final String cycleName,
  }) = _$PmsCycleEntityImpl;

  @override
  String get name;
  @override
  String get cycleName;

  /// Create a copy of PmsCycleEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PmsCycleEntityImplCopyWith<_$PmsCycleEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
