// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'approvals_access_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ApprovalsAccessModel _$ApprovalsAccessModelFromJson(Map<String, dynamic> json) {
  return _ApprovalsAccessModel.fromJson(json);
}

/// @nodoc
mixin _$ApprovalsAccessModel {
  bool get success => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_access')
  bool get canAccess => throw _privateConstructorUsedError;

  /// Serializes this ApprovalsAccessModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApprovalsAccessModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApprovalsAccessModelCopyWith<ApprovalsAccessModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApprovalsAccessModelCopyWith<$Res> {
  factory $ApprovalsAccessModelCopyWith(
    ApprovalsAccessModel value,
    $Res Function(ApprovalsAccessModel) then,
  ) = _$ApprovalsAccessModelCopyWithImpl<$Res, ApprovalsAccessModel>;
  @useResult
  $Res call({bool success, @JsonKey(name: 'can_access') bool canAccess});
}

/// @nodoc
class _$ApprovalsAccessModelCopyWithImpl<
  $Res,
  $Val extends ApprovalsAccessModel
>
    implements $ApprovalsAccessModelCopyWith<$Res> {
  _$ApprovalsAccessModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApprovalsAccessModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? success = null, Object? canAccess = null}) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
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
abstract class _$$ApprovalsAccessModelImplCopyWith<$Res>
    implements $ApprovalsAccessModelCopyWith<$Res> {
  factory _$$ApprovalsAccessModelImplCopyWith(
    _$ApprovalsAccessModelImpl value,
    $Res Function(_$ApprovalsAccessModelImpl) then,
  ) = __$$ApprovalsAccessModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, @JsonKey(name: 'can_access') bool canAccess});
}

/// @nodoc
class __$$ApprovalsAccessModelImplCopyWithImpl<$Res>
    extends _$ApprovalsAccessModelCopyWithImpl<$Res, _$ApprovalsAccessModelImpl>
    implements _$$ApprovalsAccessModelImplCopyWith<$Res> {
  __$$ApprovalsAccessModelImplCopyWithImpl(
    _$ApprovalsAccessModelImpl _value,
    $Res Function(_$ApprovalsAccessModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApprovalsAccessModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? success = null, Object? canAccess = null}) {
    return _then(
      _$ApprovalsAccessModelImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        canAccess: null == canAccess
            ? _value.canAccess
            : canAccess // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ApprovalsAccessModelImpl extends _ApprovalsAccessModel {
  const _$ApprovalsAccessModelImpl({
    required this.success,
    @JsonKey(name: 'can_access') required this.canAccess,
  }) : super._();

  factory _$ApprovalsAccessModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApprovalsAccessModelImplFromJson(json);

  @override
  final bool success;
  @override
  @JsonKey(name: 'can_access')
  final bool canAccess;

  @override
  String toString() {
    return 'ApprovalsAccessModel(success: $success, canAccess: $canAccess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApprovalsAccessModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.canAccess, canAccess) ||
                other.canAccess == canAccess));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, canAccess);

  /// Create a copy of ApprovalsAccessModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApprovalsAccessModelImplCopyWith<_$ApprovalsAccessModelImpl>
  get copyWith =>
      __$$ApprovalsAccessModelImplCopyWithImpl<_$ApprovalsAccessModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ApprovalsAccessModelImplToJson(this);
  }
}

abstract class _ApprovalsAccessModel extends ApprovalsAccessModel {
  const factory _ApprovalsAccessModel({
    required final bool success,
    @JsonKey(name: 'can_access') required final bool canAccess,
  }) = _$ApprovalsAccessModelImpl;
  const _ApprovalsAccessModel._() : super._();

  factory _ApprovalsAccessModel.fromJson(Map<String, dynamic> json) =
      _$ApprovalsAccessModelImpl.fromJson;

  @override
  bool get success;
  @override
  @JsonKey(name: 'can_access')
  bool get canAccess;

  /// Create a copy of ApprovalsAccessModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApprovalsAccessModelImplCopyWith<_$ApprovalsAccessModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
