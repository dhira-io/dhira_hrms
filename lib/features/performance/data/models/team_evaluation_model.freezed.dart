// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_evaluation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TeamEvaluationModel {

 String get name; String get employee; String get department; String get cycle; int get docstatus; DateTime get creation; DateTime get modified;@JsonKey(name: 'overall_rating') double get overallRating;@JsonKey(name: 'goal_score') double get goalScore;@JsonKey(name: 'self_assesment') String get selfAssessment; String get manager;
/// Create a copy of TeamEvaluationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamEvaluationModelCopyWith<TeamEvaluationModel> get copyWith => _$TeamEvaluationModelCopyWithImpl<TeamEvaluationModel>(this as TeamEvaluationModel, _$identity);

  /// Serializes this TeamEvaluationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamEvaluationModel&&(identical(other.name, name) || other.name == name)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.department, department) || other.department == department)&&(identical(other.cycle, cycle) || other.cycle == cycle)&&(identical(other.docstatus, docstatus) || other.docstatus == docstatus)&&(identical(other.creation, creation) || other.creation == creation)&&(identical(other.modified, modified) || other.modified == modified)&&(identical(other.overallRating, overallRating) || other.overallRating == overallRating)&&(identical(other.goalScore, goalScore) || other.goalScore == goalScore)&&(identical(other.selfAssessment, selfAssessment) || other.selfAssessment == selfAssessment)&&(identical(other.manager, manager) || other.manager == manager));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,employee,department,cycle,docstatus,creation,modified,overallRating,goalScore,selfAssessment,manager);

@override
String toString() {
  return 'TeamEvaluationModel(name: $name, employee: $employee, department: $department, cycle: $cycle, docstatus: $docstatus, creation: $creation, modified: $modified, overallRating: $overallRating, goalScore: $goalScore, selfAssessment: $selfAssessment, manager: $manager)';
}


}

/// @nodoc
abstract mixin class $TeamEvaluationModelCopyWith<$Res>  {
  factory $TeamEvaluationModelCopyWith(TeamEvaluationModel value, $Res Function(TeamEvaluationModel) _then) = _$TeamEvaluationModelCopyWithImpl;
@useResult
$Res call({
 String name, String employee, String department, String cycle, int docstatus, DateTime creation, DateTime modified,@JsonKey(name: 'overall_rating') double overallRating,@JsonKey(name: 'goal_score') double goalScore,@JsonKey(name: 'self_assesment') String selfAssessment, String manager
});




}
/// @nodoc
class _$TeamEvaluationModelCopyWithImpl<$Res>
    implements $TeamEvaluationModelCopyWith<$Res> {
  _$TeamEvaluationModelCopyWithImpl(this._self, this._then);

  final TeamEvaluationModel _self;
  final $Res Function(TeamEvaluationModel) _then;

/// Create a copy of TeamEvaluationModel
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


/// Adds pattern-matching-related methods to [TeamEvaluationModel].
extension TeamEvaluationModelPatterns on TeamEvaluationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeamEvaluationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeamEvaluationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeamEvaluationModel value)  $default,){
final _that = this;
switch (_that) {
case _TeamEvaluationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeamEvaluationModel value)?  $default,){
final _that = this;
switch (_that) {
case _TeamEvaluationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String employee,  String department,  String cycle,  int docstatus,  DateTime creation,  DateTime modified, @JsonKey(name: 'overall_rating')  double overallRating, @JsonKey(name: 'goal_score')  double goalScore, @JsonKey(name: 'self_assesment')  String selfAssessment,  String manager)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeamEvaluationModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String employee,  String department,  String cycle,  int docstatus,  DateTime creation,  DateTime modified, @JsonKey(name: 'overall_rating')  double overallRating, @JsonKey(name: 'goal_score')  double goalScore, @JsonKey(name: 'self_assesment')  String selfAssessment,  String manager)  $default,) {final _that = this;
switch (_that) {
case _TeamEvaluationModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String employee,  String department,  String cycle,  int docstatus,  DateTime creation,  DateTime modified, @JsonKey(name: 'overall_rating')  double overallRating, @JsonKey(name: 'goal_score')  double goalScore, @JsonKey(name: 'self_assesment')  String selfAssessment,  String manager)?  $default,) {final _that = this;
switch (_that) {
case _TeamEvaluationModel() when $default != null:
return $default(_that.name,_that.employee,_that.department,_that.cycle,_that.docstatus,_that.creation,_that.modified,_that.overallRating,_that.goalScore,_that.selfAssessment,_that.manager);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TeamEvaluationModel extends TeamEvaluationModel {
  const _TeamEvaluationModel({required this.name, required this.employee, required this.department, required this.cycle, required this.docstatus, required this.creation, required this.modified, @JsonKey(name: 'overall_rating') required this.overallRating, @JsonKey(name: 'goal_score') required this.goalScore, @JsonKey(name: 'self_assesment') required this.selfAssessment, required this.manager}): super._();
  factory _TeamEvaluationModel.fromJson(Map<String, dynamic> json) => _$TeamEvaluationModelFromJson(json);

@override final  String name;
@override final  String employee;
@override final  String department;
@override final  String cycle;
@override final  int docstatus;
@override final  DateTime creation;
@override final  DateTime modified;
@override@JsonKey(name: 'overall_rating') final  double overallRating;
@override@JsonKey(name: 'goal_score') final  double goalScore;
@override@JsonKey(name: 'self_assesment') final  String selfAssessment;
@override final  String manager;

/// Create a copy of TeamEvaluationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeamEvaluationModelCopyWith<_TeamEvaluationModel> get copyWith => __$TeamEvaluationModelCopyWithImpl<_TeamEvaluationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TeamEvaluationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeamEvaluationModel&&(identical(other.name, name) || other.name == name)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.department, department) || other.department == department)&&(identical(other.cycle, cycle) || other.cycle == cycle)&&(identical(other.docstatus, docstatus) || other.docstatus == docstatus)&&(identical(other.creation, creation) || other.creation == creation)&&(identical(other.modified, modified) || other.modified == modified)&&(identical(other.overallRating, overallRating) || other.overallRating == overallRating)&&(identical(other.goalScore, goalScore) || other.goalScore == goalScore)&&(identical(other.selfAssessment, selfAssessment) || other.selfAssessment == selfAssessment)&&(identical(other.manager, manager) || other.manager == manager));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,employee,department,cycle,docstatus,creation,modified,overallRating,goalScore,selfAssessment,manager);

@override
String toString() {
  return 'TeamEvaluationModel(name: $name, employee: $employee, department: $department, cycle: $cycle, docstatus: $docstatus, creation: $creation, modified: $modified, overallRating: $overallRating, goalScore: $goalScore, selfAssessment: $selfAssessment, manager: $manager)';
}


}

/// @nodoc
abstract mixin class _$TeamEvaluationModelCopyWith<$Res> implements $TeamEvaluationModelCopyWith<$Res> {
  factory _$TeamEvaluationModelCopyWith(_TeamEvaluationModel value, $Res Function(_TeamEvaluationModel) _then) = __$TeamEvaluationModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String employee, String department, String cycle, int docstatus, DateTime creation, DateTime modified,@JsonKey(name: 'overall_rating') double overallRating,@JsonKey(name: 'goal_score') double goalScore,@JsonKey(name: 'self_assesment') String selfAssessment, String manager
});




}
/// @nodoc
class __$TeamEvaluationModelCopyWithImpl<$Res>
    implements _$TeamEvaluationModelCopyWith<$Res> {
  __$TeamEvaluationModelCopyWithImpl(this._self, this._then);

  final _TeamEvaluationModel _self;
  final $Res Function(_TeamEvaluationModel) _then;

/// Create a copy of TeamEvaluationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? employee = null,Object? department = null,Object? cycle = null,Object? docstatus = null,Object? creation = null,Object? modified = null,Object? overallRating = null,Object? goalScore = null,Object? selfAssessment = null,Object? manager = null,}) {
  return _then(_TeamEvaluationModel(
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
