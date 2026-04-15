// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_assignment_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProjectAssignmentEntity {

 String? get name; String get project; String? get date; String? get taskName; double get expectedHours; double get spentHours; String? get description;
/// Create a copy of ProjectAssignmentEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectAssignmentEntityCopyWith<ProjectAssignmentEntity> get copyWith => _$ProjectAssignmentEntityCopyWithImpl<ProjectAssignmentEntity>(this as ProjectAssignmentEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectAssignmentEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.project, project) || other.project == project)&&(identical(other.date, date) || other.date == date)&&(identical(other.taskName, taskName) || other.taskName == taskName)&&(identical(other.expectedHours, expectedHours) || other.expectedHours == expectedHours)&&(identical(other.spentHours, spentHours) || other.spentHours == spentHours)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,name,project,date,taskName,expectedHours,spentHours,description);

@override
String toString() {
  return 'ProjectAssignmentEntity(name: $name, project: $project, date: $date, taskName: $taskName, expectedHours: $expectedHours, spentHours: $spentHours, description: $description)';
}


}

/// @nodoc
abstract mixin class $ProjectAssignmentEntityCopyWith<$Res>  {
  factory $ProjectAssignmentEntityCopyWith(ProjectAssignmentEntity value, $Res Function(ProjectAssignmentEntity) _then) = _$ProjectAssignmentEntityCopyWithImpl;
@useResult
$Res call({
 String? name, String project, String? date, String? taskName, double expectedHours, double spentHours, String? description
});




}
/// @nodoc
class _$ProjectAssignmentEntityCopyWithImpl<$Res>
    implements $ProjectAssignmentEntityCopyWith<$Res> {
  _$ProjectAssignmentEntityCopyWithImpl(this._self, this._then);

  final ProjectAssignmentEntity _self;
  final $Res Function(ProjectAssignmentEntity) _then;

/// Create a copy of ProjectAssignmentEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? project = null,Object? date = freezed,Object? taskName = freezed,Object? expectedHours = null,Object? spentHours = null,Object? description = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,project: null == project ? _self.project : project // ignore: cast_nullable_to_non_nullable
as String,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,taskName: freezed == taskName ? _self.taskName : taskName // ignore: cast_nullable_to_non_nullable
as String?,expectedHours: null == expectedHours ? _self.expectedHours : expectedHours // ignore: cast_nullable_to_non_nullable
as double,spentHours: null == spentHours ? _self.spentHours : spentHours // ignore: cast_nullable_to_non_nullable
as double,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProjectAssignmentEntity].
extension ProjectAssignmentEntityPatterns on ProjectAssignmentEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectAssignmentEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectAssignmentEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectAssignmentEntity value)  $default,){
final _that = this;
switch (_that) {
case _ProjectAssignmentEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectAssignmentEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectAssignmentEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  String project,  String? date,  String? taskName,  double expectedHours,  double spentHours,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectAssignmentEntity() when $default != null:
return $default(_that.name,_that.project,_that.date,_that.taskName,_that.expectedHours,_that.spentHours,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  String project,  String? date,  String? taskName,  double expectedHours,  double spentHours,  String? description)  $default,) {final _that = this;
switch (_that) {
case _ProjectAssignmentEntity():
return $default(_that.name,_that.project,_that.date,_that.taskName,_that.expectedHours,_that.spentHours,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  String project,  String? date,  String? taskName,  double expectedHours,  double spentHours,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _ProjectAssignmentEntity() when $default != null:
return $default(_that.name,_that.project,_that.date,_that.taskName,_that.expectedHours,_that.spentHours,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _ProjectAssignmentEntity extends ProjectAssignmentEntity {
  const _ProjectAssignmentEntity({this.name, required this.project, this.date, this.taskName, this.expectedHours = 0.0, this.spentHours = 0.0, this.description}): super._();
  

@override final  String? name;
@override final  String project;
@override final  String? date;
@override final  String? taskName;
@override@JsonKey() final  double expectedHours;
@override@JsonKey() final  double spentHours;
@override final  String? description;

/// Create a copy of ProjectAssignmentEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectAssignmentEntityCopyWith<_ProjectAssignmentEntity> get copyWith => __$ProjectAssignmentEntityCopyWithImpl<_ProjectAssignmentEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectAssignmentEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.project, project) || other.project == project)&&(identical(other.date, date) || other.date == date)&&(identical(other.taskName, taskName) || other.taskName == taskName)&&(identical(other.expectedHours, expectedHours) || other.expectedHours == expectedHours)&&(identical(other.spentHours, spentHours) || other.spentHours == spentHours)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,name,project,date,taskName,expectedHours,spentHours,description);

@override
String toString() {
  return 'ProjectAssignmentEntity(name: $name, project: $project, date: $date, taskName: $taskName, expectedHours: $expectedHours, spentHours: $spentHours, description: $description)';
}


}

/// @nodoc
abstract mixin class _$ProjectAssignmentEntityCopyWith<$Res> implements $ProjectAssignmentEntityCopyWith<$Res> {
  factory _$ProjectAssignmentEntityCopyWith(_ProjectAssignmentEntity value, $Res Function(_ProjectAssignmentEntity) _then) = __$ProjectAssignmentEntityCopyWithImpl;
@override @useResult
$Res call({
 String? name, String project, String? date, String? taskName, double expectedHours, double spentHours, String? description
});




}
/// @nodoc
class __$ProjectAssignmentEntityCopyWithImpl<$Res>
    implements _$ProjectAssignmentEntityCopyWith<$Res> {
  __$ProjectAssignmentEntityCopyWithImpl(this._self, this._then);

  final _ProjectAssignmentEntity _self;
  final $Res Function(_ProjectAssignmentEntity) _then;

/// Create a copy of ProjectAssignmentEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? project = null,Object? date = freezed,Object? taskName = freezed,Object? expectedHours = null,Object? spentHours = null,Object? description = freezed,}) {
  return _then(_ProjectAssignmentEntity(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,project: null == project ? _self.project : project // ignore: cast_nullable_to_non_nullable
as String,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,taskName: freezed == taskName ? _self.taskName : taskName // ignore: cast_nullable_to_non_nullable
as String?,expectedHours: null == expectedHours ? _self.expectedHours : expectedHours // ignore: cast_nullable_to_non_nullable
as double,spentHours: null == spentHours ? _self.spentHours : spentHours // ignore: cast_nullable_to_non_nullable
as double,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
