// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_project_assignment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProfileProjectAssignmentModel {

@JsonKey(name: 'project_name') String get projectName;@JsonKey(name: 'project_lead') String? get projectLead;@JsonKey(name: 'start_date') String? get startDate;@JsonKey(name: 'end_date') String? get endDate;
/// Create a copy of ProfileProjectAssignmentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileProjectAssignmentModelCopyWith<ProfileProjectAssignmentModel> get copyWith => _$ProfileProjectAssignmentModelCopyWithImpl<ProfileProjectAssignmentModel>(this as ProfileProjectAssignmentModel, _$identity);

  /// Serializes this ProfileProjectAssignmentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileProjectAssignmentModel&&(identical(other.projectName, projectName) || other.projectName == projectName)&&(identical(other.projectLead, projectLead) || other.projectLead == projectLead)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,projectName,projectLead,startDate,endDate);

@override
String toString() {
  return 'ProfileProjectAssignmentModel(projectName: $projectName, projectLead: $projectLead, startDate: $startDate, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class $ProfileProjectAssignmentModelCopyWith<$Res>  {
  factory $ProfileProjectAssignmentModelCopyWith(ProfileProjectAssignmentModel value, $Res Function(ProfileProjectAssignmentModel) _then) = _$ProfileProjectAssignmentModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'project_name') String projectName,@JsonKey(name: 'project_lead') String? projectLead,@JsonKey(name: 'start_date') String? startDate,@JsonKey(name: 'end_date') String? endDate
});




}
/// @nodoc
class _$ProfileProjectAssignmentModelCopyWithImpl<$Res>
    implements $ProfileProjectAssignmentModelCopyWith<$Res> {
  _$ProfileProjectAssignmentModelCopyWithImpl(this._self, this._then);

  final ProfileProjectAssignmentModel _self;
  final $Res Function(ProfileProjectAssignmentModel) _then;

/// Create a copy of ProfileProjectAssignmentModel
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


/// Adds pattern-matching-related methods to [ProfileProjectAssignmentModel].
extension ProfileProjectAssignmentModelPatterns on ProfileProjectAssignmentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileProjectAssignmentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileProjectAssignmentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileProjectAssignmentModel value)  $default,){
final _that = this;
switch (_that) {
case _ProfileProjectAssignmentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileProjectAssignmentModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileProjectAssignmentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'project_name')  String projectName, @JsonKey(name: 'project_lead')  String? projectLead, @JsonKey(name: 'start_date')  String? startDate, @JsonKey(name: 'end_date')  String? endDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileProjectAssignmentModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'project_name')  String projectName, @JsonKey(name: 'project_lead')  String? projectLead, @JsonKey(name: 'start_date')  String? startDate, @JsonKey(name: 'end_date')  String? endDate)  $default,) {final _that = this;
switch (_that) {
case _ProfileProjectAssignmentModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'project_name')  String projectName, @JsonKey(name: 'project_lead')  String? projectLead, @JsonKey(name: 'start_date')  String? startDate, @JsonKey(name: 'end_date')  String? endDate)?  $default,) {final _that = this;
switch (_that) {
case _ProfileProjectAssignmentModel() when $default != null:
return $default(_that.projectName,_that.projectLead,_that.startDate,_that.endDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileProjectAssignmentModel extends ProfileProjectAssignmentModel {
  const _ProfileProjectAssignmentModel({@JsonKey(name: 'project_name') required this.projectName, @JsonKey(name: 'project_lead') this.projectLead, @JsonKey(name: 'start_date') this.startDate, @JsonKey(name: 'end_date') this.endDate}): super._();
  factory _ProfileProjectAssignmentModel.fromJson(Map<String, dynamic> json) => _$ProfileProjectAssignmentModelFromJson(json);

@override@JsonKey(name: 'project_name') final  String projectName;
@override@JsonKey(name: 'project_lead') final  String? projectLead;
@override@JsonKey(name: 'start_date') final  String? startDate;
@override@JsonKey(name: 'end_date') final  String? endDate;

/// Create a copy of ProfileProjectAssignmentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileProjectAssignmentModelCopyWith<_ProfileProjectAssignmentModel> get copyWith => __$ProfileProjectAssignmentModelCopyWithImpl<_ProfileProjectAssignmentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileProjectAssignmentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileProjectAssignmentModel&&(identical(other.projectName, projectName) || other.projectName == projectName)&&(identical(other.projectLead, projectLead) || other.projectLead == projectLead)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,projectName,projectLead,startDate,endDate);

@override
String toString() {
  return 'ProfileProjectAssignmentModel(projectName: $projectName, projectLead: $projectLead, startDate: $startDate, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class _$ProfileProjectAssignmentModelCopyWith<$Res> implements $ProfileProjectAssignmentModelCopyWith<$Res> {
  factory _$ProfileProjectAssignmentModelCopyWith(_ProfileProjectAssignmentModel value, $Res Function(_ProfileProjectAssignmentModel) _then) = __$ProfileProjectAssignmentModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'project_name') String projectName,@JsonKey(name: 'project_lead') String? projectLead,@JsonKey(name: 'start_date') String? startDate,@JsonKey(name: 'end_date') String? endDate
});




}
/// @nodoc
class __$ProfileProjectAssignmentModelCopyWithImpl<$Res>
    implements _$ProfileProjectAssignmentModelCopyWith<$Res> {
  __$ProfileProjectAssignmentModelCopyWithImpl(this._self, this._then);

  final _ProfileProjectAssignmentModel _self;
  final $Res Function(_ProfileProjectAssignmentModel) _then;

/// Create a copy of ProfileProjectAssignmentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? projectName = null,Object? projectLead = freezed,Object? startDate = freezed,Object? endDate = freezed,}) {
  return _then(_ProfileProjectAssignmentModel(
projectName: null == projectName ? _self.projectName : projectName // ignore: cast_nullable_to_non_nullable
as String,projectLead: freezed == projectLead ? _self.projectLead : projectLead // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
