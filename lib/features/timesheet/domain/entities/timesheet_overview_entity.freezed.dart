// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timesheet_overview_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
//import 'package:freezed_annotation/freezed_annotation.dart';

T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TimesheetOverviewEntity {

 int get filled; int get pendingApproval; int get correctionNeeded; int get upcomingToSubmit; int get approved; int get totalWeeks; Map<String, dynamic> get weekMeta;
/// Create a copy of TimesheetOverviewEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimesheetOverviewEntityCopyWith<TimesheetOverviewEntity> get copyWith => _$TimesheetOverviewEntityCopyWithImpl<TimesheetOverviewEntity>(this as TimesheetOverviewEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimesheetOverviewEntity&&(identical(other.filled, filled) || other.filled == filled)&&(identical(other.pendingApproval, pendingApproval) || other.pendingApproval == pendingApproval)&&(identical(other.correctionNeeded, correctionNeeded) || other.correctionNeeded == correctionNeeded)&&(identical(other.upcomingToSubmit, upcomingToSubmit) || other.upcomingToSubmit == upcomingToSubmit)&&(identical(other.approved, approved) || other.approved == approved)&&(identical(other.totalWeeks, totalWeeks) || other.totalWeeks == totalWeeks)&&const DeepCollectionEquality().equals(other.weekMeta, weekMeta));
}


@override
int get hashCode => Object.hash(runtimeType,filled,pendingApproval,correctionNeeded,upcomingToSubmit,approved,totalWeeks,const DeepCollectionEquality().hash(weekMeta));

@override
String toString() {
  return 'TimesheetOverviewEntity(filled: $filled, pendingApproval: $pendingApproval, correctionNeeded: $correctionNeeded, upcomingToSubmit: $upcomingToSubmit, approved: $approved, totalWeeks: $totalWeeks, weekMeta: $weekMeta)';
}


}

/// @nodoc
abstract mixin class $TimesheetOverviewEntityCopyWith<$Res>  {
  factory $TimesheetOverviewEntityCopyWith(TimesheetOverviewEntity value, $Res Function(TimesheetOverviewEntity) _then) = _$TimesheetOverviewEntityCopyWithImpl;
@useResult
$Res call({
 int filled, int pendingApproval, int correctionNeeded, int upcomingToSubmit, int approved, int totalWeeks, Map<String, dynamic> weekMeta
});




}
/// @nodoc
class _$TimesheetOverviewEntityCopyWithImpl<$Res>
    implements $TimesheetOverviewEntityCopyWith<$Res> {
  _$TimesheetOverviewEntityCopyWithImpl(this._self, this._then);

  final TimesheetOverviewEntity _self;
  final $Res Function(TimesheetOverviewEntity) _then;

/// Create a copy of TimesheetOverviewEntity
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


/// Adds pattern-matching-related methods to [TimesheetOverviewEntity].
extension TimesheetOverviewEntityPatterns on TimesheetOverviewEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimesheetOverviewEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimesheetOverviewEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimesheetOverviewEntity value)  $default,){
final _that = this;
switch (_that) {
case _TimesheetOverviewEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimesheetOverviewEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TimesheetOverviewEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int filled,  int pendingApproval,  int correctionNeeded,  int upcomingToSubmit,  int approved,  int totalWeeks,  Map<String, dynamic> weekMeta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimesheetOverviewEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int filled,  int pendingApproval,  int correctionNeeded,  int upcomingToSubmit,  int approved,  int totalWeeks,  Map<String, dynamic> weekMeta)  $default,) {final _that = this;
switch (_that) {
case _TimesheetOverviewEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int filled,  int pendingApproval,  int correctionNeeded,  int upcomingToSubmit,  int approved,  int totalWeeks,  Map<String, dynamic> weekMeta)?  $default,) {final _that = this;
switch (_that) {
case _TimesheetOverviewEntity() when $default != null:
return $default(_that.filled,_that.pendingApproval,_that.correctionNeeded,_that.upcomingToSubmit,_that.approved,_that.totalWeeks,_that.weekMeta);case _:
  return null;

}
}

}

/// @nodoc


class _TimesheetOverviewEntity implements TimesheetOverviewEntity {
  const _TimesheetOverviewEntity({required this.filled, required this.pendingApproval, required this.correctionNeeded, required this.upcomingToSubmit, required this.approved, required this.totalWeeks, required final  Map<String, dynamic> weekMeta}): _weekMeta = weekMeta;
  

@override final  int filled;
@override final  int pendingApproval;
@override final  int correctionNeeded;
@override final  int upcomingToSubmit;
@override final  int approved;
@override final  int totalWeeks;
 final  Map<String, dynamic> _weekMeta;
@override Map<String, dynamic> get weekMeta {
  if (_weekMeta is EqualUnmodifiableMapView) return _weekMeta;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_weekMeta);
}


/// Create a copy of TimesheetOverviewEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimesheetOverviewEntityCopyWith<_TimesheetOverviewEntity> get copyWith => __$TimesheetOverviewEntityCopyWithImpl<_TimesheetOverviewEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimesheetOverviewEntity&&(identical(other.filled, filled) || other.filled == filled)&&(identical(other.pendingApproval, pendingApproval) || other.pendingApproval == pendingApproval)&&(identical(other.correctionNeeded, correctionNeeded) || other.correctionNeeded == correctionNeeded)&&(identical(other.upcomingToSubmit, upcomingToSubmit) || other.upcomingToSubmit == upcomingToSubmit)&&(identical(other.approved, approved) || other.approved == approved)&&(identical(other.totalWeeks, totalWeeks) || other.totalWeeks == totalWeeks)&&const DeepCollectionEquality().equals(other._weekMeta, _weekMeta));
}


@override
int get hashCode => Object.hash(runtimeType,filled,pendingApproval,correctionNeeded,upcomingToSubmit,approved,totalWeeks,const DeepCollectionEquality().hash(_weekMeta));

@override
String toString() {
  return 'TimesheetOverviewEntity(filled: $filled, pendingApproval: $pendingApproval, correctionNeeded: $correctionNeeded, upcomingToSubmit: $upcomingToSubmit, approved: $approved, totalWeeks: $totalWeeks, weekMeta: $weekMeta)';
}


}

/// @nodoc
abstract mixin class _$TimesheetOverviewEntityCopyWith<$Res> implements $TimesheetOverviewEntityCopyWith<$Res> {
  factory _$TimesheetOverviewEntityCopyWith(_TimesheetOverviewEntity value, $Res Function(_TimesheetOverviewEntity) _then) = __$TimesheetOverviewEntityCopyWithImpl;
@override @useResult
$Res call({
 int filled, int pendingApproval, int correctionNeeded, int upcomingToSubmit, int approved, int totalWeeks, Map<String, dynamic> weekMeta
});




}
/// @nodoc
class __$TimesheetOverviewEntityCopyWithImpl<$Res>
    implements _$TimesheetOverviewEntityCopyWith<$Res> {
  __$TimesheetOverviewEntityCopyWithImpl(this._self, this._then);

  final _TimesheetOverviewEntity _self;
  final $Res Function(_TimesheetOverviewEntity) _then;

/// Create a copy of TimesheetOverviewEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? filled = null,Object? pendingApproval = null,Object? correctionNeeded = null,Object? upcomingToSubmit = null,Object? approved = null,Object? totalWeeks = null,Object? weekMeta = null,}) {
  return _then(_TimesheetOverviewEntity(
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
