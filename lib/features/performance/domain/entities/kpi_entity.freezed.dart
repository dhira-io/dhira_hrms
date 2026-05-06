// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kpi_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$KpiEntity {
  String? get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get kra => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get weightage => throw _privateConstructorUsedError;
  double get target => throw _privateConstructorUsedError;

  /// Create a copy of KpiEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KpiEntityCopyWith<KpiEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KpiEntityCopyWith<$Res> {
  factory $KpiEntityCopyWith(KpiEntity value, $Res Function(KpiEntity) then) =
      _$KpiEntityCopyWithImpl<$Res, KpiEntity>;
  @useResult
  $Res call({
    String? id,
    String title,
    String kra,
    String description,
    double weightage,
    double target,
  });
}

/// @nodoc
class _$KpiEntityCopyWithImpl<$Res, $Val extends KpiEntity>
    implements $KpiEntityCopyWith<$Res> {
  _$KpiEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KpiEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? kra = null,
    Object? description = null,
    Object? weightage = null,
    Object? target = null,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$KpiEntityImplCopyWith<$Res>
    implements $KpiEntityCopyWith<$Res> {
  factory _$$KpiEntityImplCopyWith(
    _$KpiEntityImpl value,
    $Res Function(_$KpiEntityImpl) then,
  ) = __$$KpiEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String title,
    String kra,
    String description,
    double weightage,
    double target,
  });
}

/// @nodoc
class __$$KpiEntityImplCopyWithImpl<$Res>
    extends _$KpiEntityCopyWithImpl<$Res, _$KpiEntityImpl>
    implements _$$KpiEntityImplCopyWith<$Res> {
  __$$KpiEntityImplCopyWithImpl(
    _$KpiEntityImpl _value,
    $Res Function(_$KpiEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of KpiEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? kra = null,
    Object? description = null,
    Object? weightage = null,
    Object? target = null,
  }) {
    return _then(
      _$KpiEntityImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
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
      ),
    );
  }
}

/// @nodoc

class _$KpiEntityImpl implements _KpiEntity {
  const _$KpiEntityImpl({
    this.id,
    required this.title,
    this.kra = '',
    this.description = '',
    this.weightage = 0.0,
    this.target = 0.0,
  });

  @override
  final String? id;
  @override
  final String title;
  @override
  @JsonKey()
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
  String toString() {
    return 'KpiEntity(id: $id, title: $title, kra: $kra, description: $description, weightage: $weightage, target: $target)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KpiEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.kra, kra) || other.kra == kra) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.weightage, weightage) ||
                other.weightage == weightage) &&
            (identical(other.target, target) || other.target == target));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, kra, description, weightage, target);

  /// Create a copy of KpiEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KpiEntityImplCopyWith<_$KpiEntityImpl> get copyWith =>
      __$$KpiEntityImplCopyWithImpl<_$KpiEntityImpl>(this, _$identity);
}

abstract class _KpiEntity implements KpiEntity {
  const factory _KpiEntity({
    final String? id,
    required final String title,
    final String kra,
    final String description,
    final double weightage,
    final double target,
  }) = _$KpiEntityImpl;

  @override
  String? get id;
  @override
  String get title;
  @override
  String get kra;
  @override
  String get description;
  @override
  double get weightage;
  @override
  double get target;

  /// Create a copy of KpiEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KpiEntityImplCopyWith<_$KpiEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
