// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kra_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

KraModel _$KraModelFromJson(Map<String, dynamic> json) {
  return _KraModel.fromJson(json);
}

/// @nodoc
mixin _$KraModel {
  @JsonKey(name: 'name', includeIfNull: false)
  String? get docName => throw _privateConstructorUsedError;
  @JsonKey(name: 'kra')
  String get name => throw _privateConstructorUsedError;
  double get weightage => throw _privateConstructorUsedError;
  int? get idx => throw _privateConstructorUsedError;

  /// Serializes this KraModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KraModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KraModelCopyWith<KraModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KraModelCopyWith<$Res> {
  factory $KraModelCopyWith(KraModel value, $Res Function(KraModel) then) =
      _$KraModelCopyWithImpl<$Res, KraModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'name', includeIfNull: false) String? docName,
    @JsonKey(name: 'kra') String name,
    double weightage,
    int? idx,
  });
}

/// @nodoc
class _$KraModelCopyWithImpl<$Res, $Val extends KraModel>
    implements $KraModelCopyWith<$Res> {
  _$KraModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KraModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docName = freezed,
    Object? name = null,
    Object? weightage = null,
    Object? idx = freezed,
  }) {
    return _then(
      _value.copyWith(
            docName: freezed == docName
                ? _value.docName
                : docName // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            weightage: null == weightage
                ? _value.weightage
                : weightage // ignore: cast_nullable_to_non_nullable
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
abstract class _$$KraModelImplCopyWith<$Res>
    implements $KraModelCopyWith<$Res> {
  factory _$$KraModelImplCopyWith(
    _$KraModelImpl value,
    $Res Function(_$KraModelImpl) then,
  ) = __$$KraModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'name', includeIfNull: false) String? docName,
    @JsonKey(name: 'kra') String name,
    double weightage,
    int? idx,
  });
}

/// @nodoc
class __$$KraModelImplCopyWithImpl<$Res>
    extends _$KraModelCopyWithImpl<$Res, _$KraModelImpl>
    implements _$$KraModelImplCopyWith<$Res> {
  __$$KraModelImplCopyWithImpl(
    _$KraModelImpl _value,
    $Res Function(_$KraModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of KraModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docName = freezed,
    Object? name = null,
    Object? weightage = null,
    Object? idx = freezed,
  }) {
    return _then(
      _$KraModelImpl(
        docName: freezed == docName
            ? _value.docName
            : docName // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        weightage: null == weightage
            ? _value.weightage
            : weightage // ignore: cast_nullable_to_non_nullable
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
class _$KraModelImpl extends _KraModel {
  const _$KraModelImpl({
    @JsonKey(name: 'name', includeIfNull: false) this.docName,
    @JsonKey(name: 'kra') required this.name,
    this.weightage = 0.0,
    this.idx,
  }) : super._();

  factory _$KraModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$KraModelImplFromJson(json);

  @override
  @JsonKey(name: 'name', includeIfNull: false)
  final String? docName;
  @override
  @JsonKey(name: 'kra')
  final String name;
  @override
  @JsonKey()
  final double weightage;
  @override
  final int? idx;

  @override
  String toString() {
    return 'KraModel(docName: $docName, name: $name, weightage: $weightage, idx: $idx)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KraModelImpl &&
            (identical(other.docName, docName) || other.docName == docName) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.weightage, weightage) ||
                other.weightage == weightage) &&
            (identical(other.idx, idx) || other.idx == idx));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, docName, name, weightage, idx);

  /// Create a copy of KraModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KraModelImplCopyWith<_$KraModelImpl> get copyWith =>
      __$$KraModelImplCopyWithImpl<_$KraModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KraModelImplToJson(this);
  }
}

abstract class _KraModel extends KraModel {
  const factory _KraModel({
    @JsonKey(name: 'name', includeIfNull: false) final String? docName,
    @JsonKey(name: 'kra') required final String name,
    final double weightage,
    final int? idx,
  }) = _$KraModelImpl;
  const _KraModel._() : super._();

  factory _KraModel.fromJson(Map<String, dynamic> json) =
      _$KraModelImpl.fromJson;

  @override
  @JsonKey(name: 'name', includeIfNull: false)
  String? get docName;
  @override
  @JsonKey(name: 'kra')
  String get name;
  @override
  double get weightage;
  @override
  int? get idx;

  /// Create a copy of KraModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KraModelImplCopyWith<_$KraModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
