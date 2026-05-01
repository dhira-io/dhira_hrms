// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timesheet_overview_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TimesheetOverviewModel {

 int get filled;@JsonKey(name: 'pending_approval') int get pendingApproval;@JsonKey(name: 'correction_needed') int get correctionNeeded;@JsonKey(name: 'upcoming_to_submit') int get upcomingToSubmit; int get approved;@JsonKey(name: 'total_weeks') int get totalWeeks;@JsonKey(name: 'week_meta') Map<String, dynamic> get weekMeta;
/// Create a copy of TimesheetOverviewModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimesheetOverviewModelCopyWith<TimesheetOverviewModel> get copyWith => _$TimesheetOverviewModelCopyWithImpl<TimesheetOverviewModel>(this as TimesheetOverviewModel, _$identity);

  /// Serializes this TimesheetOverviewModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimesheetOverviewModel&&(identical(other.filled, filled) || other.filled == filled)&&(identical(other.pendingApproval, pendingApproval) || other.pendingApproval == pendingApproval)&&(identical(other.correctionNeeded, correctionNeeded) || other.correctionNeeded == correctionNeeded)&&(identical(other.upcomingToSubmit, upcomingToSubmit) || other.upcomingToSubmit == upcomingToSubmit)&&(identical(other.approved, approved) || other.approved == approved)&&(identical(other.totalWeeks, totalWeeks) || other.totalWeeks == totalWeeks)&&const DeepCollectionEquality().equals(other.weekMeta, weekMeta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,filled,pendingApproval,correctionNeeded,upcomingToSubmit,approved,totalWeeks,const DeepCollectionEquality().hash(weekMeta));

@override
String toString() {
  return 'TimesheetOverviewModel(filled: $filled, pendingApproval: $pendingApproval, correctionNeeded: $correctionNeeded, upcomingToSubmit: $upcomingToSubmit, approved: $approved, totalWeeks: $totalWeeks, weekMeta: $weekMeta)';
}


}

/// @nodoc
abstract mixin class $TimesheetOverviewModelCopyWith<$Res>  {
  factory $TimesheetOverviewModelCopyWith(TimesheetOverviewModel value, $Res Function(TimesheetOverviewModel) _then) = _$TimesheetOverviewModelCopyWithImpl;
@useResult
$Res call({
 int filled,@JsonKey(name: 'pending_approval') int pendingApproval,@JsonKey(name: 'correction_needed') int correctionNeeded,@JsonKey(name: 'upcoming_to_submit') int upcomingToSubmit, int approved,@JsonKey(name: 'total_weeks') int totalWeeks,@JsonKey(name: 'week_meta') Map<String, dynamic> weekMeta
});




}
/// @nodoc
class _$TimesheetOverviewModelCopyWithImpl<$Res>
    implements $TimesheetOverviewModelCopyWith<$Res> {
  _$TimesheetOverviewModelCopyWithImpl(this._self, this._then);

  final TimesheetOverviewModel _self;
  final $Res Function(TimesheetOverviewModel) _then;

/// Create a copy of TimesheetOverviewModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? filled = null,Object? pendingApproval = null,Object? correctionNeeded = null,Object? upcomingToSubmit = null,Object? approved = null,Object? totalWeeks = null,Object? weekMeta = null,}) {
  return _then(_self.copyWith(
filled: null == filled ? _self.filled : filled // ignore: cast_nullable_to_non_nullable
as int,pendingApproval: null == pendingApproval ? _self.pendingApproval : pendingApproval // ignore: cast_nullable_to_non_nullable
as int,correctionNeeded: null == correctionNeeded ? _self.correctionNeeded : correctionNeeded // ignore: cast_nullable_to_non_nullable
as int,upcomingToSubmit: null == upcomingToSubmit ? _self.upcomingToSubmit : upcomingToSubmit // ignore: cast_nullable_to_non_nullable
as int,approved: null == approved ? _self.approved : approved // ignore: cast_nullable_to_non_nullable
as int,totalWeeks: null == totalWeeks ? _self.totalWeeks : totalWeeks // ignore: cast_nullable_to_non_nullable
as int,weekMeta: null == weekMeta ? _self.weekMeta : weekMeta // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [TimesheetOverviewModel].
extension TimesheetOverviewModelPatterns on TimesheetOverviewModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimesheetOverviewModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimesheetOverviewModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimesheetOverviewModel value)  $default,){
final _that = this;
switch (_that) {
case _TimesheetOverviewModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimesheetOverviewModel value)?  $default,){
final _that = this;
switch (_that) {
case _TimesheetOverviewModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int filled, @JsonKey(name: 'pending_approval')  int pendingApproval, @JsonKey(name: 'correction_needed')  int correctionNeeded, @JsonKey(name: 'upcoming_to_submit')  int upcomingToSubmit,  int approved, @JsonKey(name: 'total_weeks')  int totalWeeks, @JsonKey(name: 'week_meta')  Map<String, dynamic> weekMeta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimesheetOverviewModel() when $default != null:
return $default(_that.filled,_that.pendingApproval,_that.correctionNeeded,_that.upcomingToSubmit,_that.approved,_that.totalWeeks,_that.weekMeta);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int filled, @JsonKey(name: 'pending_approval')  int pendingApproval, @JsonKey(name: 'correction_needed')  int correctionNeeded, @JsonKey(name: 'upcoming_to_submit')  int upcomingToSubmit,  int approved, @JsonKey(name: 'total_weeks')  int totalWeeks, @JsonKey(name: 'week_meta')  Map<String, dynamic> weekMeta)  $default,) {final _that = this;
switch (_that) {
case _TimesheetOverviewModel():
return $default(_that.filled,_that.pendingApproval,_that.correctionNeeded,_that.upcomingToSubmit,_that.approved,_that.totalWeeks,_that.weekMeta);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int filled, @JsonKey(name: 'pending_approval')  int pendingApproval, @JsonKey(name: 'correction_needed')  int correctionNeeded, @JsonKey(name: 'upcoming_to_submit')  int upcomingToSubmit,  int approved, @JsonKey(name: 'total_weeks')  int totalWeeks, @JsonKey(name: 'week_meta')  Map<String, dynamic> weekMeta)?  $default,) {final _that = this;
switch (_that) {
case _TimesheetOverviewModel() when $default != null:
return $default(_that.filled,_that.pendingApproval,_that.correctionNeeded,_that.upcomingToSubmit,_that.approved,_that.totalWeeks,_that.weekMeta);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TimesheetOverviewModel extends TimesheetOverviewModel {
  const _TimesheetOverviewModel({this.filled = 0, @JsonKey(name: 'pending_approval') this.pendingApproval = 0, @JsonKey(name: 'correction_needed') this.correctionNeeded = 0, @JsonKey(name: 'upcoming_to_submit') this.upcomingToSubmit = 0, this.approved = 0, @JsonKey(name: 'total_weeks') this.totalWeeks = 0, @JsonKey(name: 'week_meta') final  Map<String, dynamic> weekMeta = const {}}): _weekMeta = weekMeta,super._();
  factory _TimesheetOverviewModel.fromJson(Map<String, dynamic> json) => _$TimesheetOverviewModelFromJson(json);

@override@JsonKey() final  int filled;
@override@JsonKey(name: 'pending_approval') final  int pendingApproval;
@override@JsonKey(name: 'correction_needed') final  int correctionNeeded;
@override@JsonKey(name: 'upcoming_to_submit') final  int upcomingToSubmit;
@override@JsonKey() final  int approved;
@override@JsonKey(name: 'total_weeks') final  int totalWeeks;
 final  Map<String, dynamic> _weekMeta;
@override@JsonKey(name: 'week_meta') Map<String, dynamic> get weekMeta {
  if (_weekMeta is EqualUnmodifiableMapView) return _weekMeta;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_weekMeta);
}


/// Create a copy of TimesheetOverviewModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimesheetOverviewModelCopyWith<_TimesheetOverviewModel> get copyWith => __$TimesheetOverviewModelCopyWithImpl<_TimesheetOverviewModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TimesheetOverviewModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimesheetOverviewModel&&(identical(other.filled, filled) || other.filled == filled)&&(identical(other.pendingApproval, pendingApproval) || other.pendingApproval == pendingApproval)&&(identical(other.correctionNeeded, correctionNeeded) || other.correctionNeeded == correctionNeeded)&&(identical(other.upcomingToSubmit, upcomingToSubmit) || other.upcomingToSubmit == upcomingToSubmit)&&(identical(other.approved, approved) || other.approved == approved)&&(identical(other.totalWeeks, totalWeeks) || other.totalWeeks == totalWeeks)&&const DeepCollectionEquality().equals(other._weekMeta, _weekMeta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,filled,pendingApproval,correctionNeeded,upcomingToSubmit,approved,totalWeeks,const DeepCollectionEquality().hash(_weekMeta));

@override
String toString() {
  return 'TimesheetOverviewModel(filled: $filled, pendingApproval: $pendingApproval, correctionNeeded: $correctionNeeded, upcomingToSubmit: $upcomingToSubmit, approved: $approved, totalWeeks: $totalWeeks, weekMeta: $weekMeta)';
}


}

/// @nodoc
abstract mixin class _$TimesheetOverviewModelCopyWith<$Res> implements $TimesheetOverviewModelCopyWith<$Res> {
  factory _$TimesheetOverviewModelCopyWith(_TimesheetOverviewModel value, $Res Function(_TimesheetOverviewModel) _then) = __$TimesheetOverviewModelCopyWithImpl;
@override @useResult
$Res call({
 int filled,@JsonKey(name: 'pending_approval') int pendingApproval,@JsonKey(name: 'correction_needed') int correctionNeeded,@JsonKey(name: 'upcoming_to_submit') int upcomingToSubmit, int approved,@JsonKey(name: 'total_weeks') int totalWeeks,@JsonKey(name: 'week_meta') Map<String, dynamic> weekMeta
});




}
/// @nodoc
class __$TimesheetOverviewModelCopyWithImpl<$Res>
    implements _$TimesheetOverviewModelCopyWith<$Res> {
  __$TimesheetOverviewModelCopyWithImpl(this._self, this._then);

  final _TimesheetOverviewModel _self;
  final $Res Function(_TimesheetOverviewModel) _then;

/// Create a copy of TimesheetOverviewModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? filled = null,Object? pendingApproval = null,Object? correctionNeeded = null,Object? upcomingToSubmit = null,Object? approved = null,Object? totalWeeks = null,Object? weekMeta = null,}) {
  return _then(_TimesheetOverviewModel(
filled: null == filled ? _self.filled : filled // ignore: cast_nullable_to_non_nullable
as int,pendingApproval: null == pendingApproval ? _self.pendingApproval : pendingApproval // ignore: cast_nullable_to_non_nullable
as int,correctionNeeded: null == correctionNeeded ? _self.correctionNeeded : correctionNeeded // ignore: cast_nullable_to_non_nullable
as int,upcomingToSubmit: null == upcomingToSubmit ? _self.upcomingToSubmit : upcomingToSubmit // ignore: cast_nullable_to_non_nullable
as int,approved: null == approved ? _self.approved : approved // ignore: cast_nullable_to_non_nullable
as int,totalWeeks: null == totalWeeks ? _self.totalWeeks : totalWeeks // ignore: cast_nullable_to_non_nullable
as int,weekMeta: null == weekMeta ? _self._weekMeta : weekMeta // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
