// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'approvals_access_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ApprovalsAccessEntity {
  bool get canAccess => throw _privateConstructorUsedError;

  /// Create a copy of ApprovalsAccessEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApprovalsAccessEntityCopyWith<ApprovalsAccessEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApprovalsAccessEntityCopyWith<$Res> {
  factory $ApprovalsAccessEntityCopyWith(
    ApprovalsAccessEntity value,
    $Res Function(ApprovalsAccessEntity) then,
  ) = _$ApprovalsAccessEntityCopyWithImpl<$Res, ApprovalsAccessEntity>;
  @useResult
  $Res call({bool canAccess});
}

/// @nodoc
class _$ApprovalsAccessEntityCopyWithImpl<
  $Res,
  $Val extends ApprovalsAccessEntity
>
    implements $ApprovalsAccessEntityCopyWith<$Res> {
  _$ApprovalsAccessEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApprovalsAccessEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? canAccess = null}) {
    return _then(
      _value.copyWith(
            canAccess: null == canAccess
                ? _value.canAccess
                : canAccess // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ApprovalsAccessEntityImplCopyWith<$Res>
    implements $ApprovalsAccessEntityCopyWith<$Res> {
  factory _$$ApprovalsAccessEntityImplCopyWith(
    _$ApprovalsAccessEntityImpl value,
    $Res Function(_$ApprovalsAccessEntityImpl) then,
  ) = __$$ApprovalsAccessEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool canAccess});
}

/// @nodoc
class __$$ApprovalsAccessEntityImplCopyWithImpl<$Res>
    extends
        _$ApprovalsAccessEntityCopyWithImpl<$Res, _$ApprovalsAccessEntityImpl>
    implements _$$ApprovalsAccessEntityImplCopyWith<$Res> {
  __$$ApprovalsAccessEntityImplCopyWithImpl(
    _$ApprovalsAccessEntityImpl _value,
    $Res Function(_$ApprovalsAccessEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApprovalsAccessEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? canAccess = null}) {
    return _then(
      _$ApprovalsAccessEntityImpl(
        canAccess: null == canAccess
            ? _value.canAccess
            : canAccess // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$ApprovalsAccessEntityImpl implements _ApprovalsAccessEntity {
  const _$ApprovalsAccessEntityImpl({required this.canAccess});

  @override
  final bool canAccess;

  @override
  String toString() {
    return 'ApprovalsAccessEntity(canAccess: $canAccess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApprovalsAccessEntityImpl &&
            (identical(other.canAccess, canAccess) ||
                other.canAccess == canAccess));
  }

  @override
  int get hashCode => Object.hash(runtimeType, canAccess);

  /// Create a copy of ApprovalsAccessEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApprovalsAccessEntityImplCopyWith<_$ApprovalsAccessEntityImpl>
  get copyWith =>
      __$$ApprovalsAccessEntityImplCopyWithImpl<_$ApprovalsAccessEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _ApprovalsAccessEntity implements ApprovalsAccessEntity {
  const factory _ApprovalsAccessEntity({required final bool canAccess}) =
      _$ApprovalsAccessEntityImpl;

  @override
  bool get canAccess;

  /// Create a copy of ApprovalsAccessEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApprovalsAccessEntityImplCopyWith<_$ApprovalsAccessEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}
