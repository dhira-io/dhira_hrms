// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_project_assignment_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileProjectAssignmentEntity {

 String get projectName; String? get projectLead; String? get startDate; String? get endDate;
/// Create a copy of ProfileProjectAssignmentEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileProjectAssignmentEntityCopyWith<ProfileProjectAssignmentEntity> get copyWith => _$ProfileProjectAssignmentEntityCopyWithImpl<ProfileProjectAssignmentEntity>(this as ProfileProjectAssignmentEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileProjectAssignmentEntity&&(identical(other.projectName, projectName) || other.projectName == projectName)&&(identical(other.projectLead, projectLead) || other.projectLead == projectLead)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}


@override
int get hashCode => Object.hash(runtimeType,projectName,projectLead,startDate,endDate);

@override
String toString() {
  return 'ProfileProjectAssignmentEntity(projectName: $projectName, projectLead: $projectLead, startDate: $startDate, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class $ProfileProjectAssignmentEntityCopyWith<$Res>  {
  factory $ProfileProjectAssignmentEntityCopyWith(ProfileProjectAssignmentEntity value, $Res Function(ProfileProjectAssignmentEntity) _then) = _$ProfileProjectAssignmentEntityCopyWithImpl;
@useResult
$Res call({
 String projectName, String? projectLead, String? startDate, String? endDate
});




}
/// @nodoc
class _$ProfileProjectAssignmentEntityCopyWithImpl<$Res>
    implements $ProfileProjectAssignmentEntityCopyWith<$Res> {
  _$ProfileProjectAssignmentEntityCopyWithImpl(this._self, this._then);

  final ProfileProjectAssignmentEntity _self;
  final $Res Function(ProfileProjectAssignmentEntity) _then;

/// Create a copy of ProfileProjectAssignmentEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? projectName = null,Object? projectLead = freezed,Object? startDate = freezed,Object? endDate = freezed,}) {
  return _then(_self.copyWith(
projectName: null == projectName ? _self.projectName : projectName // ignore: cast_nullable_to_non_nullable
as String,projectLead: freezed == projectLead ? _self.projectLead : projectLead // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileProjectAssignmentEntity].
extension ProfileProjectAssignmentEntityPatterns on ProfileProjectAssignmentEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileProjectAssignmentEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileProjectAssignmentEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileProjectAssignmentEntity value)  $default,){
final _that = this;
switch (_that) {
case _ProfileProjectAssignmentEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileProjectAssignmentEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileProjectAssignmentEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String projectName,  String? projectLead,  String? startDate,  String? endDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileProjectAssignmentEntity() when $default != null:
return $default(_that.projectName,_that.projectLead,_that.startDate,_that.endDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String projectName,  String? projectLead,  String? startDate,  String? endDate)  $default,) {final _that = this;
switch (_that) {
case _ProfileProjectAssignmentEntity():
return $default(_that.projectName,_that.projectLead,_that.startDate,_that.endDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String projectName,  String? projectLead,  String? startDate,  String? endDate)?  $default,) {final _that = this;
switch (_that) {
case _ProfileProjectAssignmentEntity() when $default != null:
return $default(_that.projectName,_that.projectLead,_that.startDate,_that.endDate);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileProjectAssignmentEntity extends ProfileProjectAssignmentEntity {
  const _ProfileProjectAssignmentEntity({required this.projectName, this.projectLead, this.startDate, this.endDate}): super._();
  

@override final  String projectName;
@override final  String? projectLead;
@override final  String? startDate;
@override final  String? endDate;

/// Create a copy of ProfileProjectAssignmentEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileProjectAssignmentEntityCopyWith<_ProfileProjectAssignmentEntity> get copyWith => __$ProfileProjectAssignmentEntityCopyWithImpl<_ProfileProjectAssignmentEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileProjectAssignmentEntity&&(identical(other.projectName, projectName) || other.projectName == projectName)&&(identical(other.projectLead, projectLead) || other.projectLead == projectLead)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}


@override
int get hashCode => Object.hash(runtimeType,projectName,projectLead,startDate,endDate);

@override
String toString() {
  return 'ProfileProjectAssignmentEntity(projectName: $projectName, projectLead: $projectLead, startDate: $startDate, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class _$ProfileProjectAssignmentEntityCopyWith<$Res> implements $ProfileProjectAssignmentEntityCopyWith<$Res> {
  factory _$ProfileProjectAssignmentEntityCopyWith(_ProfileProjectAssignmentEntity value, $Res Function(_ProfileProjectAssignmentEntity) _then) = __$ProfileProjectAssignmentEntityCopyWithImpl;
@override @useResult
$Res call({
 String projectName, String? projectLead, String? startDate, String? endDate
});




}
/// @nodoc
class __$ProfileProjectAssignmentEntityCopyWithImpl<$Res>
    implements _$ProfileProjectAssignmentEntityCopyWith<$Res> {
  __$ProfileProjectAssignmentEntityCopyWithImpl(this._self, this._then);

  final _ProfileProjectAssignmentEntity _self;
  final $Res Function(_ProfileProjectAssignmentEntity) _then;

/// Create a copy of ProfileProjectAssignmentEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? projectName = null,Object? projectLead = freezed,Object? startDate = freezed,Object? endDate = freezed,}) {
  return _then(_ProfileProjectAssignmentEntity(
projectName: null == projectName ? _self.projectName : projectName // ignore: cast_nullable_to_non_nullable
as String,projectLead: freezed == projectLead ? _self.projectLead : projectLead // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
