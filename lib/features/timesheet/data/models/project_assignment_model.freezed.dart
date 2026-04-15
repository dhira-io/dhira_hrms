// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_assignment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProjectAssignmentModel {

 String? get name; String get project; String? get date;@JsonKey(name: 'task_name') String? get taskName;@JsonKey(name: 'expected_hours') double get expectedHours;@JsonKey(name: 'spent_hours') double get spentHours; String? get description;
/// Create a copy of ProjectAssignmentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectAssignmentModelCopyWith<ProjectAssignmentModel> get copyWith => _$ProjectAssignmentModelCopyWithImpl<ProjectAssignmentModel>(this as ProjectAssignmentModel, _$identity);

  /// Serializes this ProjectAssignmentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectAssignmentModel&&(identical(other.name, name) || other.name == name)&&(identical(other.project, project) || other.project == project)&&(identical(other.date, date) || other.date == date)&&(identical(other.taskName, taskName) || other.taskName == taskName)&&(identical(other.expectedHours, expectedHours) || other.expectedHours == expectedHours)&&(identical(other.spentHours, spentHours) || other.spentHours == spentHours)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,project,date,taskName,expectedHours,spentHours,description);

@override
String toString() {
  return 'ProjectAssignmentModel(name: $name, project: $project, date: $date, taskName: $taskName, expectedHours: $expectedHours, spentHours: $spentHours, description: $description)';
}


}

/// @nodoc
abstract mixin class $ProjectAssignmentModelCopyWith<$Res>  {
  factory $ProjectAssignmentModelCopyWith(ProjectAssignmentModel value, $Res Function(ProjectAssignmentModel) _then) = _$ProjectAssignmentModelCopyWithImpl;
@useResult
$Res call({
 String? name, String project, String? date,@JsonKey(name: 'task_name') String? taskName,@JsonKey(name: 'expected_hours') double expectedHours,@JsonKey(name: 'spent_hours') double spentHours, String? description
});




}
/// @nodoc
class _$ProjectAssignmentModelCopyWithImpl<$Res>
    implements $ProjectAssignmentModelCopyWith<$Res> {
  _$ProjectAssignmentModelCopyWithImpl(this._self, this._then);

  final ProjectAssignmentModel _self;
  final $Res Function(ProjectAssignmentModel) _then;

/// Create a copy of ProjectAssignmentModel
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


/// Adds pattern-matching-related methods to [ProjectAssignmentModel].
extension ProjectAssignmentModelPatterns on ProjectAssignmentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectAssignmentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectAssignmentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectAssignmentModel value)  $default,){
final _that = this;
switch (_that) {
case _ProjectAssignmentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectAssignmentModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectAssignmentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  String project,  String? date, @JsonKey(name: 'task_name')  String? taskName, @JsonKey(name: 'expected_hours')  double expectedHours, @JsonKey(name: 'spent_hours')  double spentHours,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectAssignmentModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  String project,  String? date, @JsonKey(name: 'task_name')  String? taskName, @JsonKey(name: 'expected_hours')  double expectedHours, @JsonKey(name: 'spent_hours')  double spentHours,  String? description)  $default,) {final _that = this;
switch (_that) {
case _ProjectAssignmentModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  String project,  String? date, @JsonKey(name: 'task_name')  String? taskName, @JsonKey(name: 'expected_hours')  double expectedHours, @JsonKey(name: 'spent_hours')  double spentHours,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _ProjectAssignmentModel() when $default != null:
return $default(_that.name,_that.project,_that.date,_that.taskName,_that.expectedHours,_that.spentHours,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProjectAssignmentModel extends ProjectAssignmentModel {
  const _ProjectAssignmentModel({this.name, required this.project, this.date, @JsonKey(name: 'task_name') this.taskName, @JsonKey(name: 'expected_hours') this.expectedHours = 0.0, @JsonKey(name: 'spent_hours') this.spentHours = 0.0, this.description}): super._();
  factory _ProjectAssignmentModel.fromJson(Map<String, dynamic> json) => _$ProjectAssignmentModelFromJson(json);

@override final  String? name;
@override final  String project;
@override final  String? date;
@override@JsonKey(name: 'task_name') final  String? taskName;
@override@JsonKey(name: 'expected_hours') final  double expectedHours;
@override@JsonKey(name: 'spent_hours') final  double spentHours;
@override final  String? description;

/// Create a copy of ProjectAssignmentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectAssignmentModelCopyWith<_ProjectAssignmentModel> get copyWith => __$ProjectAssignmentModelCopyWithImpl<_ProjectAssignmentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProjectAssignmentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectAssignmentModel&&(identical(other.name, name) || other.name == name)&&(identical(other.project, project) || other.project == project)&&(identical(other.date, date) || other.date == date)&&(identical(other.taskName, taskName) || other.taskName == taskName)&&(identical(other.expectedHours, expectedHours) || other.expectedHours == expectedHours)&&(identical(other.spentHours, spentHours) || other.spentHours == spentHours)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,project,date,taskName,expectedHours,spentHours,description);

@override
String toString() {
  return 'ProjectAssignmentModel(name: $name, project: $project, date: $date, taskName: $taskName, expectedHours: $expectedHours, spentHours: $spentHours, description: $description)';
}


}

/// @nodoc
abstract mixin class _$ProjectAssignmentModelCopyWith<$Res> implements $ProjectAssignmentModelCopyWith<$Res> {
  factory _$ProjectAssignmentModelCopyWith(_ProjectAssignmentModel value, $Res Function(_ProjectAssignmentModel) _then) = __$ProjectAssignmentModelCopyWithImpl;
@override @useResult
$Res call({
 String? name, String project, String? date,@JsonKey(name: 'task_name') String? taskName,@JsonKey(name: 'expected_hours') double expectedHours,@JsonKey(name: 'spent_hours') double spentHours, String? description
});




}
/// @nodoc
class __$ProjectAssignmentModelCopyWithImpl<$Res>
    implements _$ProjectAssignmentModelCopyWith<$Res> {
  __$ProjectAssignmentModelCopyWithImpl(this._self, this._then);

  final _ProjectAssignmentModel _self;
  final $Res Function(_ProjectAssignmentModel) _then;

/// Create a copy of ProjectAssignmentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? project = null,Object? date = freezed,Object? taskName = freezed,Object? expectedHours = null,Object? spentHours = null,Object? description = freezed,}) {
  return _then(_ProjectAssignmentModel(
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
