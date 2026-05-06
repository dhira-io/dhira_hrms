// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timesheet_overview_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TimesheetOverviewModel _$TimesheetOverviewModelFromJson(
  Map<String, dynamic> json,
) {
  return _TimesheetOverviewModel.fromJson(json);
}

/// @nodoc
mixin _$TimesheetOverviewModel {
  int get filled => throw _privateConstructorUsedError;
  @JsonKey(name: 'pending_approval')
  int get pendingApproval => throw _privateConstructorUsedError;
  @JsonKey(name: 'correction_needed')
  int get correctionNeeded => throw _privateConstructorUsedError;
  @JsonKey(name: 'upcoming_to_submit')
  int get upcomingToSubmit => throw _privateConstructorUsedError;
  int get approved => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_weeks')
  int get totalWeeks => throw _privateConstructorUsedError;
  @JsonKey(name: 'week_meta')
  Map<String, dynamic> get weekMeta => throw _privateConstructorUsedError;

  /// Serializes this TimesheetOverviewModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TimesheetOverviewModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimesheetOverviewModelCopyWith<TimesheetOverviewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimesheetOverviewModelCopyWith<$Res> {
  factory $TimesheetOverviewModelCopyWith(
    TimesheetOverviewModel value,
    $Res Function(TimesheetOverviewModel) then,
  ) = _$TimesheetOverviewModelCopyWithImpl<$Res, TimesheetOverviewModel>;
  @useResult
  $Res call({
    int filled,
    @JsonKey(name: 'pending_approval') int pendingApproval,
    @JsonKey(name: 'correction_needed') int correctionNeeded,
    @JsonKey(name: 'upcoming_to_submit') int upcomingToSubmit,
    int approved,
    @JsonKey(name: 'total_weeks') int totalWeeks,
    @JsonKey(name: 'week_meta') Map<String, dynamic> weekMeta,
  });
}

/// @nodoc
class _$TimesheetOverviewModelCopyWithImpl<
  $Res,
  $Val extends TimesheetOverviewModel
>
    implements $TimesheetOverviewModelCopyWith<$Res> {
  _$TimesheetOverviewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimesheetOverviewModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filled = null,
    Object? pendingApproval = null,
    Object? correctionNeeded = null,
    Object? upcomingToSubmit = null,
    Object? approved = null,
    Object? totalWeeks = null,
    Object? weekMeta = null,
  }) {
    return _then(
      _value.copyWith(
            filled: null == filled
                ? _value.filled
                : filled // ignore: cast_nullable_to_non_nullable
                      as int,
            pendingApproval: null == pendingApproval
                ? _value.pendingApproval
                : pendingApproval // ignore: cast_nullable_to_non_nullable
                      as int,
            correctionNeeded: null == correctionNeeded
                ? _value.correctionNeeded
                : correctionNeeded // ignore: cast_nullable_to_non_nullable
                      as int,
            upcomingToSubmit: null == upcomingToSubmit
                ? _value.upcomingToSubmit
                : upcomingToSubmit // ignore: cast_nullable_to_non_nullable
                      as int,
            approved: null == approved
                ? _value.approved
                : approved // ignore: cast_nullable_to_non_nullable
                      as int,
            totalWeeks: null == totalWeeks
                ? _value.totalWeeks
                : totalWeeks // ignore: cast_nullable_to_non_nullable
                      as int,
            weekMeta: null == weekMeta
                ? _value.weekMeta
                : weekMeta // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TimesheetOverviewModelImplCopyWith<$Res>
    implements $TimesheetOverviewModelCopyWith<$Res> {
  factory _$$TimesheetOverviewModelImplCopyWith(
    _$TimesheetOverviewModelImpl value,
    $Res Function(_$TimesheetOverviewModelImpl) then,
  ) = __$$TimesheetOverviewModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int filled,
    @JsonKey(name: 'pending_approval') int pendingApproval,
    @JsonKey(name: 'correction_needed') int correctionNeeded,
    @JsonKey(name: 'upcoming_to_submit') int upcomingToSubmit,
    int approved,
    @JsonKey(name: 'total_weeks') int totalWeeks,
    @JsonKey(name: 'week_meta') Map<String, dynamic> weekMeta,
  });
}

/// @nodoc
class __$$TimesheetOverviewModelImplCopyWithImpl<$Res>
    extends
        _$TimesheetOverviewModelCopyWithImpl<$Res, _$TimesheetOverviewModelImpl>
    implements _$$TimesheetOverviewModelImplCopyWith<$Res> {
  __$$TimesheetOverviewModelImplCopyWithImpl(
    _$TimesheetOverviewModelImpl _value,
    $Res Function(_$TimesheetOverviewModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TimesheetOverviewModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filled = null,
    Object? pendingApproval = null,
    Object? correctionNeeded = null,
    Object? upcomingToSubmit = null,
    Object? approved = null,
    Object? totalWeeks = null,
    Object? weekMeta = null,
  }) {
    return _then(
      _$TimesheetOverviewModelImpl(
        filled: null == filled
            ? _value.filled
            : filled // ignore: cast_nullable_to_non_nullable
                  as int,
        pendingApproval: null == pendingApproval
            ? _value.pendingApproval
            : pendingApproval // ignore: cast_nullable_to_non_nullable
                  as int,
        correctionNeeded: null == correctionNeeded
            ? _value.correctionNeeded
            : correctionNeeded // ignore: cast_nullable_to_non_nullable
                  as int,
        upcomingToSubmit: null == upcomingToSubmit
            ? _value.upcomingToSubmit
            : upcomingToSubmit // ignore: cast_nullable_to_non_nullable
                  as int,
        approved: null == approved
            ? _value.approved
            : approved // ignore: cast_nullable_to_non_nullable
                  as int,
        totalWeeks: null == totalWeeks
            ? _value.totalWeeks
            : totalWeeks // ignore: cast_nullable_to_non_nullable
                  as int,
        weekMeta: null == weekMeta
            ? _value._weekMeta
            : weekMeta // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TimesheetOverviewModelImpl extends _TimesheetOverviewModel {
  const _$TimesheetOverviewModelImpl({
    this.filled = 0,
    @JsonKey(name: 'pending_approval') this.pendingApproval = 0,
    @JsonKey(name: 'correction_needed') this.correctionNeeded = 0,
    @JsonKey(name: 'upcoming_to_submit') this.upcomingToSubmit = 0,
    this.approved = 0,
    @JsonKey(name: 'total_weeks') this.totalWeeks = 0,
    @JsonKey(name: 'week_meta') final Map<String, dynamic> weekMeta = const {},
  }) : _weekMeta = weekMeta,
       super._();

  factory _$TimesheetOverviewModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimesheetOverviewModelImplFromJson(json);

  @override
  @JsonKey()
  final int filled;
  @override
  @JsonKey(name: 'pending_approval')
  final int pendingApproval;
  @override
  @JsonKey(name: 'correction_needed')
  final int correctionNeeded;
  @override
  @JsonKey(name: 'upcoming_to_submit')
  final int upcomingToSubmit;
  @override
  @JsonKey()
  final int approved;
  @override
  @JsonKey(name: 'total_weeks')
  final int totalWeeks;
  final Map<String, dynamic> _weekMeta;
  @override
  @JsonKey(name: 'week_meta')
  Map<String, dynamic> get weekMeta {
    if (_weekMeta is EqualUnmodifiableMapView) return _weekMeta;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_weekMeta);
  }

  @override
  String toString() {
    return 'TimesheetOverviewModel(filled: $filled, pendingApproval: $pendingApproval, correctionNeeded: $correctionNeeded, upcomingToSubmit: $upcomingToSubmit, approved: $approved, totalWeeks: $totalWeeks, weekMeta: $weekMeta)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimesheetOverviewModelImpl &&
            (identical(other.filled, filled) || other.filled == filled) &&
            (identical(other.pendingApproval, pendingApproval) ||
                other.pendingApproval == pendingApproval) &&
            (identical(other.correctionNeeded, correctionNeeded) ||
                other.correctionNeeded == correctionNeeded) &&
            (identical(other.upcomingToSubmit, upcomingToSubmit) ||
                other.upcomingToSubmit == upcomingToSubmit) &&
            (identical(other.approved, approved) ||
                other.approved == approved) &&
            (identical(other.totalWeeks, totalWeeks) ||
                other.totalWeeks == totalWeeks) &&
            const DeepCollectionEquality().equals(other._weekMeta, _weekMeta));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    filled,
    pendingApproval,
    correctionNeeded,
    upcomingToSubmit,
    approved,
    totalWeeks,
    const DeepCollectionEquality().hash(_weekMeta),
  );

  /// Create a copy of TimesheetOverviewModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimesheetOverviewModelImplCopyWith<_$TimesheetOverviewModelImpl>
  get copyWith =>
      __$$TimesheetOverviewModelImplCopyWithImpl<_$TimesheetOverviewModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TimesheetOverviewModelImplToJson(this);
  }
}

abstract class _TimesheetOverviewModel extends TimesheetOverviewModel {
  const factory _TimesheetOverviewModel({
    final int filled,
    @JsonKey(name: 'pending_approval') final int pendingApproval,
    @JsonKey(name: 'correction_needed') final int correctionNeeded,
    @JsonKey(name: 'upcoming_to_submit') final int upcomingToSubmit,
    final int approved,
    @JsonKey(name: 'total_weeks') final int totalWeeks,
    @JsonKey(name: 'week_meta') final Map<String, dynamic> weekMeta,
  }) = _$TimesheetOverviewModelImpl;
  const _TimesheetOverviewModel._() : super._();

  factory _TimesheetOverviewModel.fromJson(Map<String, dynamic> json) =
      _$TimesheetOverviewModelImpl.fromJson;

  @override
  int get filled;
  @override
  @JsonKey(name: 'pending_approval')
  int get pendingApproval;
  @override
  @JsonKey(name: 'correction_needed')
  int get correctionNeeded;
  @override
  @JsonKey(name: 'upcoming_to_submit')
  int get upcomingToSubmit;
  @override
  int get approved;
  @override
  @JsonKey(name: 'total_weeks')
  int get totalWeeks;
  @override
  @JsonKey(name: 'week_meta')
  Map<String, dynamic> get weekMeta;

  /// Create a copy of TimesheetOverviewModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimesheetOverviewModelImplCopyWith<_$TimesheetOverviewModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
