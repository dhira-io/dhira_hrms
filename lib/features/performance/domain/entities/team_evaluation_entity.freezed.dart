// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_evaluation_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TeamEvaluationEntity {

 String get name; String get employee; String get department; String get cycle; int get docstatus; DateTime get creation; DateTime get modified; double get overallRating; double get goalScore; String get selfAssessment; String get manager;
/// Create a copy of TeamEvaluationEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamEvaluationEntityCopyWith<TeamEvaluationEntity> get copyWith => _$TeamEvaluationEntityCopyWithImpl<TeamEvaluationEntity>(this as TeamEvaluationEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamEvaluationEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.department, department) || other.department == department)&&(identical(other.cycle, cycle) || other.cycle == cycle)&&(identical(other.docstatus, docstatus) || other.docstatus == docstatus)&&(identical(other.creation, creation) || other.creation == creation)&&(identical(other.modified, modified) || other.modified == modified)&&(identical(other.overallRating, overallRating) || other.overallRating == overallRating)&&(identical(other.goalScore, goalScore) || other.goalScore == goalScore)&&(identical(other.selfAssessment, selfAssessment) || other.selfAssessment == selfAssessment)&&(identical(other.manager, manager) || other.manager == manager));
}


@override
int get hashCode => Object.hash(runtimeType,name,employee,department,cycle,docstatus,creation,modified,overallRating,goalScore,selfAssessment,manager);

@override
String toString() {
  return 'TeamEvaluationEntity(name: $name, employee: $employee, department: $department, cycle: $cycle, docstatus: $docstatus, creation: $creation, modified: $modified, overallRating: $overallRating, goalScore: $goalScore, selfAssessment: $selfAssessment, manager: $manager)';
}


}

/// @nodoc
abstract mixin class $TeamEvaluationEntityCopyWith<$Res>  {
  factory $TeamEvaluationEntityCopyWith(TeamEvaluationEntity value, $Res Function(TeamEvaluationEntity) _then) = _$TeamEvaluationEntityCopyWithImpl;
@useResult
$Res call({
 String name, String employee, String department, String cycle, int docstatus, DateTime creation, DateTime modified, double overallRating, double goalScore, String selfAssessment, String manager
});




}
/// @nodoc
class _$TeamEvaluationEntityCopyWithImpl<$Res>
    implements $TeamEvaluationEntityCopyWith<$Res> {
  _$TeamEvaluationEntityCopyWithImpl(this._self, this._then);

  final TeamEvaluationEntity _self;
  final $Res Function(TeamEvaluationEntity) _then;

/// Create a copy of TeamEvaluationEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? employee = null,Object? department = null,Object? cycle = null,Object? docstatus = null,Object? creation = null,Object? modified = null,Object? overallRating = null,Object? goalScore = null,Object? selfAssessment = null,Object? manager = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,employee: null == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as String,department: null == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String,cycle: null == cycle ? _self.cycle : cycle // ignore: cast_nullable_to_non_nullable
as String,docstatus: null == docstatus ? _self.docstatus : docstatus // ignore: cast_nullable_to_non_nullable
as int,creation: null == creation ? _self.creation : creation // ignore: cast_nullable_to_non_nullable
as DateTime,modified: null == modified ? _self.modified : modified // ignore: cast_nullable_to_non_nullable
as DateTime,overallRating: null == overallRating ? _self.overallRating : overallRating // ignore: cast_nullable_to_non_nullable
as double,goalScore: null == goalScore ? _self.goalScore : goalScore // ignore: cast_nullable_to_non_nullable
as double,selfAssessment: null == selfAssessment ? _self.selfAssessment : selfAssessment // ignore: cast_nullable_to_non_nullable
as String,manager: null == manager ? _self.manager : manager // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TeamEvaluationEntity].
extension TeamEvaluationEntityPatterns on TeamEvaluationEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeamEvaluationEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeamEvaluationEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeamEvaluationEntity value)  $default,){
final _that = this;
switch (_that) {
case _TeamEvaluationEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeamEvaluationEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TeamEvaluationEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String employee,  String department,  String cycle,  int docstatus,  DateTime creation,  DateTime modified,  double overallRating,  double goalScore,  String selfAssessment,  String manager)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeamEvaluationEntity() when $default != null:
return $default(_that.name,_that.employee,_that.department,_that.cycle,_that.docstatus,_that.creation,_that.modified,_that.overallRating,_that.goalScore,_that.selfAssessment,_that.manager);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String employee,  String department,  String cycle,  int docstatus,  DateTime creation,  DateTime modified,  double overallRating,  double goalScore,  String selfAssessment,  String manager)  $default,) {final _that = this;
switch (_that) {
case _TeamEvaluationEntity():
return $default(_that.name,_that.employee,_that.department,_that.cycle,_that.docstatus,_that.creation,_that.modified,_that.overallRating,_that.goalScore,_that.selfAssessment,_that.manager);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String employee,  String department,  String cycle,  int docstatus,  DateTime creation,  DateTime modified,  double overallRating,  double goalScore,  String selfAssessment,  String manager)?  $default,) {final _that = this;
switch (_that) {
case _TeamEvaluationEntity() when $default != null:
return $default(_that.name,_that.employee,_that.department,_that.cycle,_that.docstatus,_that.creation,_that.modified,_that.overallRating,_that.goalScore,_that.selfAssessment,_that.manager);case _:
  return null;

}
}

}

/// @nodoc


class _TeamEvaluationEntity implements TeamEvaluationEntity {
  const _TeamEvaluationEntity({required this.name, required this.employee, required this.department, required this.cycle, required this.docstatus, required this.creation, required this.modified, required this.overallRating, required this.goalScore, required this.selfAssessment, required this.manager});
  

@override final  String name;
@override final  String employee;
@override final  String department;
@override final  String cycle;
@override final  int docstatus;
@override final  DateTime creation;
@override final  DateTime modified;
@override final  double overallRating;
@override final  double goalScore;
@override final  String selfAssessment;
@override final  String manager;

/// Create a copy of TeamEvaluationEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeamEvaluationEntityCopyWith<_TeamEvaluationEntity> get copyWith => __$TeamEvaluationEntityCopyWithImpl<_TeamEvaluationEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeamEvaluationEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.department, department) || other.department == department)&&(identical(other.cycle, cycle) || other.cycle == cycle)&&(identical(other.docstatus, docstatus) || other.docstatus == docstatus)&&(identical(other.creation, creation) || other.creation == creation)&&(identical(other.modified, modified) || other.modified == modified)&&(identical(other.overallRating, overallRating) || other.overallRating == overallRating)&&(identical(other.goalScore, goalScore) || other.goalScore == goalScore)&&(identical(other.selfAssessment, selfAssessment) || other.selfAssessment == selfAssessment)&&(identical(other.manager, manager) || other.manager == manager));
}


@override
int get hashCode => Object.hash(runtimeType,name,employee,department,cycle,docstatus,creation,modified,overallRating,goalScore,selfAssessment,manager);

@override
String toString() {
  return 'TeamEvaluationEntity(name: $name, employee: $employee, department: $department, cycle: $cycle, docstatus: $docstatus, creation: $creation, modified: $modified, overallRating: $overallRating, goalScore: $goalScore, selfAssessment: $selfAssessment, manager: $manager)';
}


}

/// @nodoc
abstract mixin class _$TeamEvaluationEntityCopyWith<$Res> implements $TeamEvaluationEntityCopyWith<$Res> {
  factory _$TeamEvaluationEntityCopyWith(_TeamEvaluationEntity value, $Res Function(_TeamEvaluationEntity) _then) = __$TeamEvaluationEntityCopyWithImpl;
@override @useResult
$Res call({
 String name, String employee, String department, String cycle, int docstatus, DateTime creation, DateTime modified, double overallRating, double goalScore, String selfAssessment, String manager
});




}
/// @nodoc
class __$TeamEvaluationEntityCopyWithImpl<$Res>
    implements _$TeamEvaluationEntityCopyWith<$Res> {
  __$TeamEvaluationEntityCopyWithImpl(this._self, this._then);

  final _TeamEvaluationEntity _self;
  final $Res Function(_TeamEvaluationEntity) _then;

/// Create a copy of TeamEvaluationEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? employee = null,Object? department = null,Object? cycle = null,Object? docstatus = null,Object? creation = null,Object? modified = null,Object? overallRating = null,Object? goalScore = null,Object? selfAssessment = null,Object? manager = null,}) {
  return _then(_TeamEvaluationEntity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,employee: null == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as String,department: null == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String,cycle: null == cycle ? _self.cycle : cycle // ignore: cast_nullable_to_non_nullable
as String,docstatus: null == docstatus ? _self.docstatus : docstatus // ignore: cast_nullable_to_non_nullable
as int,creation: null == creation ? _self.creation : creation // ignore: cast_nullable_to_non_nullable
as DateTime,modified: null == modified ? _self.modified : modified // ignore: cast_nullable_to_non_nullable
as DateTime,overallRating: null == overallRating ? _self.overallRating : overallRating // ignore: cast_nullable_to_non_nullable
as double,goalScore: null == goalScore ? _self.goalScore : goalScore // ignore: cast_nullable_to_non_nullable
as double,selfAssessment: null == selfAssessment ? _self.selfAssessment : selfAssessment // ignore: cast_nullable_to_non_nullable
as String,manager: null == manager ? _self.manager : manager // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
