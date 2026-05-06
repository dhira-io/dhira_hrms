// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'self_assessment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SelfAssessmentModel {

 String get name; String get employee;@JsonKey(name: 'employee_name') String get employeeName; String get cycle; String get goal;@JsonKey(name: 'submission_date') DateTime? get submissionDate; DateTime get modified;@JsonKey(name: 'goal_ratings', readValue: _readGoalsList) List<GoalReviewModel> get goalReviews; List<TimelineStageModel> get timeline;@JsonKey(name: 'competency_ratings', readValue: _readCompetenciesList) List<CompetencyReviewModel> get competencyReviews; List<FileAttachmentModel> get attachments;
/// Create a copy of SelfAssessmentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelfAssessmentModelCopyWith<SelfAssessmentModel> get copyWith => _$SelfAssessmentModelCopyWithImpl<SelfAssessmentModel>(this as SelfAssessmentModel, _$identity);

  /// Serializes this SelfAssessmentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelfAssessmentModel&&(identical(other.name, name) || other.name == name)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.cycle, cycle) || other.cycle == cycle)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.submissionDate, submissionDate) || other.submissionDate == submissionDate)&&(identical(other.modified, modified) || other.modified == modified)&&const DeepCollectionEquality().equals(other.goalReviews, goalReviews)&&const DeepCollectionEquality().equals(other.timeline, timeline)&&const DeepCollectionEquality().equals(other.competencyReviews, competencyReviews)&&const DeepCollectionEquality().equals(other.attachments, attachments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,employee,employeeName,cycle,goal,submissionDate,modified,const DeepCollectionEquality().hash(goalReviews),const DeepCollectionEquality().hash(timeline),const DeepCollectionEquality().hash(competencyReviews),const DeepCollectionEquality().hash(attachments));

@override
String toString() {
  return 'SelfAssessmentModel(name: $name, employee: $employee, employeeName: $employeeName, cycle: $cycle, goal: $goal, submissionDate: $submissionDate, modified: $modified, goalReviews: $goalReviews, timeline: $timeline, competencyReviews: $competencyReviews, attachments: $attachments)';
}


}

/// @nodoc
abstract mixin class $SelfAssessmentModelCopyWith<$Res>  {
  factory $SelfAssessmentModelCopyWith(SelfAssessmentModel value, $Res Function(SelfAssessmentModel) _then) = _$SelfAssessmentModelCopyWithImpl;
@useResult
$Res call({
 String name, String employee,@JsonKey(name: 'employee_name') String employeeName, String cycle, String goal,@JsonKey(name: 'submission_date') DateTime? submissionDate, DateTime modified,@JsonKey(name: 'goal_ratings', readValue: _readGoalsList) List<GoalReviewModel> goalReviews, List<TimelineStageModel> timeline,@JsonKey(name: 'competency_ratings', readValue: _readCompetenciesList) List<CompetencyReviewModel> competencyReviews, List<FileAttachmentModel> attachments
});




}
/// @nodoc
class _$SelfAssessmentModelCopyWithImpl<$Res>
    implements $SelfAssessmentModelCopyWith<$Res> {
  _$SelfAssessmentModelCopyWithImpl(this._self, this._then);

  final SelfAssessmentModel _self;
  final $Res Function(SelfAssessmentModel) _then;

/// Create a copy of SelfAssessmentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? employee = null,Object? employeeName = null,Object? cycle = null,Object? goal = null,Object? submissionDate = freezed,Object? modified = null,Object? goalReviews = null,Object? timeline = null,Object? competencyReviews = null,Object? attachments = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,employee: null == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as String,employeeName: null == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String,cycle: null == cycle ? _self.cycle : cycle // ignore: cast_nullable_to_non_nullable
as String,goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as String,submissionDate: freezed == submissionDate ? _self.submissionDate : submissionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,modified: null == modified ? _self.modified : modified // ignore: cast_nullable_to_non_nullable
as DateTime,goalReviews: null == goalReviews ? _self.goalReviews : goalReviews // ignore: cast_nullable_to_non_nullable
as List<GoalReviewModel>,timeline: null == timeline ? _self.timeline : timeline // ignore: cast_nullable_to_non_nullable
as List<TimelineStageModel>,competencyReviews: null == competencyReviews ? _self.competencyReviews : competencyReviews // ignore: cast_nullable_to_non_nullable
as List<CompetencyReviewModel>,attachments: null == attachments ? _self.attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<FileAttachmentModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [SelfAssessmentModel].
extension SelfAssessmentModelPatterns on SelfAssessmentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SelfAssessmentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SelfAssessmentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SelfAssessmentModel value)  $default,){
final _that = this;
switch (_that) {
case _SelfAssessmentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SelfAssessmentModel value)?  $default,){
final _that = this;
switch (_that) {
case _SelfAssessmentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String employee, @JsonKey(name: 'employee_name')  String employeeName,  String cycle,  String goal, @JsonKey(name: 'submission_date')  DateTime? submissionDate,  DateTime modified, @JsonKey(name: 'goal_ratings', readValue: _readGoalsList)  List<GoalReviewModel> goalReviews,  List<TimelineStageModel> timeline, @JsonKey(name: 'competency_ratings', readValue: _readCompetenciesList)  List<CompetencyReviewModel> competencyReviews,  List<FileAttachmentModel> attachments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SelfAssessmentModel() when $default != null:
return $default(_that.name,_that.employee,_that.employeeName,_that.cycle,_that.goal,_that.submissionDate,_that.modified,_that.goalReviews,_that.timeline,_that.competencyReviews,_that.attachments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String employee, @JsonKey(name: 'employee_name')  String employeeName,  String cycle,  String goal, @JsonKey(name: 'submission_date')  DateTime? submissionDate,  DateTime modified, @JsonKey(name: 'goal_ratings', readValue: _readGoalsList)  List<GoalReviewModel> goalReviews,  List<TimelineStageModel> timeline, @JsonKey(name: 'competency_ratings', readValue: _readCompetenciesList)  List<CompetencyReviewModel> competencyReviews,  List<FileAttachmentModel> attachments)  $default,) {final _that = this;
switch (_that) {
case _SelfAssessmentModel():
return $default(_that.name,_that.employee,_that.employeeName,_that.cycle,_that.goal,_that.submissionDate,_that.modified,_that.goalReviews,_that.timeline,_that.competencyReviews,_that.attachments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String employee, @JsonKey(name: 'employee_name')  String employeeName,  String cycle,  String goal, @JsonKey(name: 'submission_date')  DateTime? submissionDate,  DateTime modified, @JsonKey(name: 'goal_ratings', readValue: _readGoalsList)  List<GoalReviewModel> goalReviews,  List<TimelineStageModel> timeline, @JsonKey(name: 'competency_ratings', readValue: _readCompetenciesList)  List<CompetencyReviewModel> competencyReviews,  List<FileAttachmentModel> attachments)?  $default,) {final _that = this;
switch (_that) {
case _SelfAssessmentModel() when $default != null:
return $default(_that.name,_that.employee,_that.employeeName,_that.cycle,_that.goal,_that.submissionDate,_that.modified,_that.goalReviews,_that.timeline,_that.competencyReviews,_that.attachments);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SelfAssessmentModel extends SelfAssessmentModel {
  const _SelfAssessmentModel({required this.name, required this.employee, @JsonKey(name: 'employee_name') this.employeeName = '', required this.cycle, this.goal = '', @JsonKey(name: 'submission_date') this.submissionDate, required this.modified, @JsonKey(name: 'goal_ratings', readValue: _readGoalsList) final  List<GoalReviewModel> goalReviews = const [], final  List<TimelineStageModel> timeline = const [], @JsonKey(name: 'competency_ratings', readValue: _readCompetenciesList) final  List<CompetencyReviewModel> competencyReviews = const [], final  List<FileAttachmentModel> attachments = const []}): _goalReviews = goalReviews,_timeline = timeline,_competencyReviews = competencyReviews,_attachments = attachments,super._();
  factory _SelfAssessmentModel.fromJson(Map<String, dynamic> json) => _$SelfAssessmentModelFromJson(json);

@override final  String name;
@override final  String employee;
@override@JsonKey(name: 'employee_name') final  String employeeName;
@override final  String cycle;
@override@JsonKey() final  String goal;
@override@JsonKey(name: 'submission_date') final  DateTime? submissionDate;
@override final  DateTime modified;
 final  List<GoalReviewModel> _goalReviews;
@override@JsonKey(name: 'goal_ratings', readValue: _readGoalsList) List<GoalReviewModel> get goalReviews {
  if (_goalReviews is EqualUnmodifiableListView) return _goalReviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_goalReviews);
}

 final  List<TimelineStageModel> _timeline;
@override@JsonKey() List<TimelineStageModel> get timeline {
  if (_timeline is EqualUnmodifiableListView) return _timeline;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_timeline);
}

 final  List<CompetencyReviewModel> _competencyReviews;
@override@JsonKey(name: 'competency_ratings', readValue: _readCompetenciesList) List<CompetencyReviewModel> get competencyReviews {
  if (_competencyReviews is EqualUnmodifiableListView) return _competencyReviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_competencyReviews);
}

 final  List<FileAttachmentModel> _attachments;
@override@JsonKey() List<FileAttachmentModel> get attachments {
  if (_attachments is EqualUnmodifiableListView) return _attachments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attachments);
}


/// Create a copy of SelfAssessmentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelfAssessmentModelCopyWith<_SelfAssessmentModel> get copyWith => __$SelfAssessmentModelCopyWithImpl<_SelfAssessmentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SelfAssessmentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelfAssessmentModel&&(identical(other.name, name) || other.name == name)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.cycle, cycle) || other.cycle == cycle)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.submissionDate, submissionDate) || other.submissionDate == submissionDate)&&(identical(other.modified, modified) || other.modified == modified)&&const DeepCollectionEquality().equals(other._goalReviews, _goalReviews)&&const DeepCollectionEquality().equals(other._timeline, _timeline)&&const DeepCollectionEquality().equals(other._competencyReviews, _competencyReviews)&&const DeepCollectionEquality().equals(other._attachments, _attachments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,employee,employeeName,cycle,goal,submissionDate,modified,const DeepCollectionEquality().hash(_goalReviews),const DeepCollectionEquality().hash(_timeline),const DeepCollectionEquality().hash(_competencyReviews),const DeepCollectionEquality().hash(_attachments));

@override
String toString() {
  return 'SelfAssessmentModel(name: $name, employee: $employee, employeeName: $employeeName, cycle: $cycle, goal: $goal, submissionDate: $submissionDate, modified: $modified, goalReviews: $goalReviews, timeline: $timeline, competencyReviews: $competencyReviews, attachments: $attachments)';
}


}

/// @nodoc
abstract mixin class _$SelfAssessmentModelCopyWith<$Res> implements $SelfAssessmentModelCopyWith<$Res> {
  factory _$SelfAssessmentModelCopyWith(_SelfAssessmentModel value, $Res Function(_SelfAssessmentModel) _then) = __$SelfAssessmentModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String employee,@JsonKey(name: 'employee_name') String employeeName, String cycle, String goal,@JsonKey(name: 'submission_date') DateTime? submissionDate, DateTime modified,@JsonKey(name: 'goal_ratings', readValue: _readGoalsList) List<GoalReviewModel> goalReviews, List<TimelineStageModel> timeline,@JsonKey(name: 'competency_ratings', readValue: _readCompetenciesList) List<CompetencyReviewModel> competencyReviews, List<FileAttachmentModel> attachments
});




}
/// @nodoc
class __$SelfAssessmentModelCopyWithImpl<$Res>
    implements _$SelfAssessmentModelCopyWith<$Res> {
  __$SelfAssessmentModelCopyWithImpl(this._self, this._then);

  final _SelfAssessmentModel _self;
  final $Res Function(_SelfAssessmentModel) _then;

/// Create a copy of SelfAssessmentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? employee = null,Object? employeeName = null,Object? cycle = null,Object? goal = null,Object? submissionDate = freezed,Object? modified = null,Object? goalReviews = null,Object? timeline = null,Object? competencyReviews = null,Object? attachments = null,}) {
  return _then(_SelfAssessmentModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,employee: null == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as String,employeeName: null == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String,cycle: null == cycle ? _self.cycle : cycle // ignore: cast_nullable_to_non_nullable
as String,goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as String,submissionDate: freezed == submissionDate ? _self.submissionDate : submissionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,modified: null == modified ? _self.modified : modified // ignore: cast_nullable_to_non_nullable
as DateTime,goalReviews: null == goalReviews ? _self._goalReviews : goalReviews // ignore: cast_nullable_to_non_nullable
as List<GoalReviewModel>,timeline: null == timeline ? _self._timeline : timeline // ignore: cast_nullable_to_non_nullable
as List<TimelineStageModel>,competencyReviews: null == competencyReviews ? _self._competencyReviews : competencyReviews // ignore: cast_nullable_to_non_nullable
as List<CompetencyReviewModel>,attachments: null == attachments ? _self._attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<FileAttachmentModel>,
  ));
}


}


/// @nodoc
mixin _$FileAttachmentModel {

 String get name;@JsonKey(name: 'file_name') String get fileName;@JsonKey(name: 'file_url') String get fileUrl;
/// Create a copy of FileAttachmentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FileAttachmentModelCopyWith<FileAttachmentModel> get copyWith => _$FileAttachmentModelCopyWithImpl<FileAttachmentModel>(this as FileAttachmentModel, _$identity);

  /// Serializes this FileAttachmentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FileAttachmentModel&&(identical(other.name, name) || other.name == name)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,fileName,fileUrl);

@override
String toString() {
  return 'FileAttachmentModel(name: $name, fileName: $fileName, fileUrl: $fileUrl)';
}


}

/// @nodoc
abstract mixin class $FileAttachmentModelCopyWith<$Res>  {
  factory $FileAttachmentModelCopyWith(FileAttachmentModel value, $Res Function(FileAttachmentModel) _then) = _$FileAttachmentModelCopyWithImpl;
@useResult
$Res call({
 String name,@JsonKey(name: 'file_name') String fileName,@JsonKey(name: 'file_url') String fileUrl
});




}
/// @nodoc
class _$FileAttachmentModelCopyWithImpl<$Res>
    implements $FileAttachmentModelCopyWith<$Res> {
  _$FileAttachmentModelCopyWithImpl(this._self, this._then);

  final FileAttachmentModel _self;
  final $Res Function(FileAttachmentModel) _then;

/// Create a copy of FileAttachmentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? fileName = null,Object? fileUrl = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,fileUrl: null == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FileAttachmentModel].
extension FileAttachmentModelPatterns on FileAttachmentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FileAttachmentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FileAttachmentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FileAttachmentModel value)  $default,){
final _that = this;
switch (_that) {
case _FileAttachmentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FileAttachmentModel value)?  $default,){
final _that = this;
switch (_that) {
case _FileAttachmentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'file_name')  String fileName, @JsonKey(name: 'file_url')  String fileUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FileAttachmentModel() when $default != null:
return $default(_that.name,_that.fileName,_that.fileUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'file_name')  String fileName, @JsonKey(name: 'file_url')  String fileUrl)  $default,) {final _that = this;
switch (_that) {
case _FileAttachmentModel():
return $default(_that.name,_that.fileName,_that.fileUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name, @JsonKey(name: 'file_name')  String fileName, @JsonKey(name: 'file_url')  String fileUrl)?  $default,) {final _that = this;
switch (_that) {
case _FileAttachmentModel() when $default != null:
return $default(_that.name,_that.fileName,_that.fileUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FileAttachmentModel extends FileAttachmentModel {
  const _FileAttachmentModel({required this.name, @JsonKey(name: 'file_name') required this.fileName, @JsonKey(name: 'file_url') required this.fileUrl}): super._();
  factory _FileAttachmentModel.fromJson(Map<String, dynamic> json) => _$FileAttachmentModelFromJson(json);

@override final  String name;
@override@JsonKey(name: 'file_name') final  String fileName;
@override@JsonKey(name: 'file_url') final  String fileUrl;

/// Create a copy of FileAttachmentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FileAttachmentModelCopyWith<_FileAttachmentModel> get copyWith => __$FileAttachmentModelCopyWithImpl<_FileAttachmentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FileAttachmentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FileAttachmentModel&&(identical(other.name, name) || other.name == name)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,fileName,fileUrl);

@override
String toString() {
  return 'FileAttachmentModel(name: $name, fileName: $fileName, fileUrl: $fileUrl)';
}


}

/// @nodoc
abstract mixin class _$FileAttachmentModelCopyWith<$Res> implements $FileAttachmentModelCopyWith<$Res> {
  factory _$FileAttachmentModelCopyWith(_FileAttachmentModel value, $Res Function(_FileAttachmentModel) _then) = __$FileAttachmentModelCopyWithImpl;
@override @useResult
$Res call({
 String name,@JsonKey(name: 'file_name') String fileName,@JsonKey(name: 'file_url') String fileUrl
});




}
/// @nodoc
class __$FileAttachmentModelCopyWithImpl<$Res>
    implements _$FileAttachmentModelCopyWith<$Res> {
  __$FileAttachmentModelCopyWithImpl(this._self, this._then);

  final _FileAttachmentModel _self;
  final $Res Function(_FileAttachmentModel) _then;

/// Create a copy of FileAttachmentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? fileName = null,Object? fileUrl = null,}) {
  return _then(_FileAttachmentModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,fileUrl: null == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$GoalReviewModel {

 String get name;@JsonKey(name: 'goal', readValue: _readGoalName) String get goal;@JsonKey(name: 'kras') String get kras; double get weightage; double get target; double get progress;@JsonKey(name: 'self_rating') String get selfRating;@JsonKey(name: 'self_comment') String get selfComment;@JsonKey(name: 'manager_rating') String get managerRating;@JsonKey(name: 'manager_percentage') double get managerPercentage;@JsonKey(name: 'manager_comment') String get managerComment;@JsonKey(name: 'employee_comment') String get employeeComment; double get achieved;@JsonKey(name: 'weighted_score') double get weightedScore; DateTime get modified;
/// Create a copy of GoalReviewModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalReviewModelCopyWith<GoalReviewModel> get copyWith => _$GoalReviewModelCopyWithImpl<GoalReviewModel>(this as GoalReviewModel, _$identity);

  /// Serializes this GoalReviewModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalReviewModel&&(identical(other.name, name) || other.name == name)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.kras, kras) || other.kras == kras)&&(identical(other.weightage, weightage) || other.weightage == weightage)&&(identical(other.target, target) || other.target == target)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.selfRating, selfRating) || other.selfRating == selfRating)&&(identical(other.selfComment, selfComment) || other.selfComment == selfComment)&&(identical(other.managerRating, managerRating) || other.managerRating == managerRating)&&(identical(other.managerPercentage, managerPercentage) || other.managerPercentage == managerPercentage)&&(identical(other.managerComment, managerComment) || other.managerComment == managerComment)&&(identical(other.employeeComment, employeeComment) || other.employeeComment == employeeComment)&&(identical(other.achieved, achieved) || other.achieved == achieved)&&(identical(other.weightedScore, weightedScore) || other.weightedScore == weightedScore)&&(identical(other.modified, modified) || other.modified == modified));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,goal,kras,weightage,target,progress,selfRating,selfComment,managerRating,managerPercentage,managerComment,employeeComment,achieved,weightedScore,modified);

@override
String toString() {
  return 'GoalReviewModel(name: $name, goal: $goal, kras: $kras, weightage: $weightage, target: $target, progress: $progress, selfRating: $selfRating, selfComment: $selfComment, managerRating: $managerRating, managerPercentage: $managerPercentage, managerComment: $managerComment, employeeComment: $employeeComment, achieved: $achieved, weightedScore: $weightedScore, modified: $modified)';
}


}

/// @nodoc
abstract mixin class $GoalReviewModelCopyWith<$Res>  {
  factory $GoalReviewModelCopyWith(GoalReviewModel value, $Res Function(GoalReviewModel) _then) = _$GoalReviewModelCopyWithImpl;
@useResult
$Res call({
 String name,@JsonKey(name: 'goal', readValue: _readGoalName) String goal,@JsonKey(name: 'kras') String kras, double weightage, double target, double progress,@JsonKey(name: 'self_rating') String selfRating,@JsonKey(name: 'self_comment') String selfComment,@JsonKey(name: 'manager_rating') String managerRating,@JsonKey(name: 'manager_percentage') double managerPercentage,@JsonKey(name: 'manager_comment') String managerComment,@JsonKey(name: 'employee_comment') String employeeComment, double achieved,@JsonKey(name: 'weighted_score') double weightedScore, DateTime modified
});




}
/// @nodoc
class _$GoalReviewModelCopyWithImpl<$Res>
    implements $GoalReviewModelCopyWith<$Res> {
  _$GoalReviewModelCopyWithImpl(this._self, this._then);

  final GoalReviewModel _self;
  final $Res Function(GoalReviewModel) _then;

/// Create a copy of GoalReviewModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? goal = null,Object? kras = null,Object? weightage = null,Object? target = null,Object? progress = null,Object? selfRating = null,Object? selfComment = null,Object? managerRating = null,Object? managerPercentage = null,Object? managerComment = null,Object? employeeComment = null,Object? achieved = null,Object? weightedScore = null,Object? modified = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as String,kras: null == kras ? _self.kras : kras // ignore: cast_nullable_to_non_nullable
as String,weightage: null == weightage ? _self.weightage : weightage // ignore: cast_nullable_to_non_nullable
as double,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as double,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,selfRating: null == selfRating ? _self.selfRating : selfRating // ignore: cast_nullable_to_non_nullable
as String,selfComment: null == selfComment ? _self.selfComment : selfComment // ignore: cast_nullable_to_non_nullable
as String,managerRating: null == managerRating ? _self.managerRating : managerRating // ignore: cast_nullable_to_non_nullable
as String,managerPercentage: null == managerPercentage ? _self.managerPercentage : managerPercentage // ignore: cast_nullable_to_non_nullable
as double,managerComment: null == managerComment ? _self.managerComment : managerComment // ignore: cast_nullable_to_non_nullable
as String,employeeComment: null == employeeComment ? _self.employeeComment : employeeComment // ignore: cast_nullable_to_non_nullable
as String,achieved: null == achieved ? _self.achieved : achieved // ignore: cast_nullable_to_non_nullable
as double,weightedScore: null == weightedScore ? _self.weightedScore : weightedScore // ignore: cast_nullable_to_non_nullable
as double,modified: null == modified ? _self.modified : modified // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [GoalReviewModel].
extension GoalReviewModelPatterns on GoalReviewModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoalReviewModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoalReviewModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoalReviewModel value)  $default,){
final _that = this;
switch (_that) {
case _GoalReviewModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoalReviewModel value)?  $default,){
final _that = this;
switch (_that) {
case _GoalReviewModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'goal', readValue: _readGoalName)  String goal, @JsonKey(name: 'kras')  String kras,  double weightage,  double target,  double progress, @JsonKey(name: 'self_rating')  String selfRating, @JsonKey(name: 'self_comment')  String selfComment, @JsonKey(name: 'manager_rating')  String managerRating, @JsonKey(name: 'manager_percentage')  double managerPercentage, @JsonKey(name: 'manager_comment')  String managerComment, @JsonKey(name: 'employee_comment')  String employeeComment,  double achieved, @JsonKey(name: 'weighted_score')  double weightedScore,  DateTime modified)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoalReviewModel() when $default != null:
return $default(_that.name,_that.goal,_that.kras,_that.weightage,_that.target,_that.progress,_that.selfRating,_that.selfComment,_that.managerRating,_that.managerPercentage,_that.managerComment,_that.employeeComment,_that.achieved,_that.weightedScore,_that.modified);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'goal', readValue: _readGoalName)  String goal, @JsonKey(name: 'kras')  String kras,  double weightage,  double target,  double progress, @JsonKey(name: 'self_rating')  String selfRating, @JsonKey(name: 'self_comment')  String selfComment, @JsonKey(name: 'manager_rating')  String managerRating, @JsonKey(name: 'manager_percentage')  double managerPercentage, @JsonKey(name: 'manager_comment')  String managerComment, @JsonKey(name: 'employee_comment')  String employeeComment,  double achieved, @JsonKey(name: 'weighted_score')  double weightedScore,  DateTime modified)  $default,) {final _that = this;
switch (_that) {
case _GoalReviewModel():
return $default(_that.name,_that.goal,_that.kras,_that.weightage,_that.target,_that.progress,_that.selfRating,_that.selfComment,_that.managerRating,_that.managerPercentage,_that.managerComment,_that.employeeComment,_that.achieved,_that.weightedScore,_that.modified);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name, @JsonKey(name: 'goal', readValue: _readGoalName)  String goal, @JsonKey(name: 'kras')  String kras,  double weightage,  double target,  double progress, @JsonKey(name: 'self_rating')  String selfRating, @JsonKey(name: 'self_comment')  String selfComment, @JsonKey(name: 'manager_rating')  String managerRating, @JsonKey(name: 'manager_percentage')  double managerPercentage, @JsonKey(name: 'manager_comment')  String managerComment, @JsonKey(name: 'employee_comment')  String employeeComment,  double achieved, @JsonKey(name: 'weighted_score')  double weightedScore,  DateTime modified)?  $default,) {final _that = this;
switch (_that) {
case _GoalReviewModel() when $default != null:
return $default(_that.name,_that.goal,_that.kras,_that.weightage,_that.target,_that.progress,_that.selfRating,_that.selfComment,_that.managerRating,_that.managerPercentage,_that.managerComment,_that.employeeComment,_that.achieved,_that.weightedScore,_that.modified);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GoalReviewModel extends GoalReviewModel {
  const _GoalReviewModel({required this.name, @JsonKey(name: 'goal', readValue: _readGoalName) this.goal = '', @JsonKey(name: 'kras') this.kras = '', this.weightage = 0.0, this.target = 0.0, this.progress = 0.0, @JsonKey(name: 'self_rating') this.selfRating = '', @JsonKey(name: 'self_comment') this.selfComment = '', @JsonKey(name: 'manager_rating') this.managerRating = '', @JsonKey(name: 'manager_percentage') this.managerPercentage = 0.0, @JsonKey(name: 'manager_comment') this.managerComment = '', @JsonKey(name: 'employee_comment') this.employeeComment = '', this.achieved = 0.0, @JsonKey(name: 'weighted_score') this.weightedScore = 0.0, required this.modified}): super._();
  factory _GoalReviewModel.fromJson(Map<String, dynamic> json) => _$GoalReviewModelFromJson(json);

@override final  String name;
@override@JsonKey(name: 'goal', readValue: _readGoalName) final  String goal;
@override@JsonKey(name: 'kras') final  String kras;
@override@JsonKey() final  double weightage;
@override@JsonKey() final  double target;
@override@JsonKey() final  double progress;
@override@JsonKey(name: 'self_rating') final  String selfRating;
@override@JsonKey(name: 'self_comment') final  String selfComment;
@override@JsonKey(name: 'manager_rating') final  String managerRating;
@override@JsonKey(name: 'manager_percentage') final  double managerPercentage;
@override@JsonKey(name: 'manager_comment') final  String managerComment;
@override@JsonKey(name: 'employee_comment') final  String employeeComment;
@override@JsonKey() final  double achieved;
@override@JsonKey(name: 'weighted_score') final  double weightedScore;
@override final  DateTime modified;

/// Create a copy of GoalReviewModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoalReviewModelCopyWith<_GoalReviewModel> get copyWith => __$GoalReviewModelCopyWithImpl<_GoalReviewModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GoalReviewModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoalReviewModel&&(identical(other.name, name) || other.name == name)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.kras, kras) || other.kras == kras)&&(identical(other.weightage, weightage) || other.weightage == weightage)&&(identical(other.target, target) || other.target == target)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.selfRating, selfRating) || other.selfRating == selfRating)&&(identical(other.selfComment, selfComment) || other.selfComment == selfComment)&&(identical(other.managerRating, managerRating) || other.managerRating == managerRating)&&(identical(other.managerPercentage, managerPercentage) || other.managerPercentage == managerPercentage)&&(identical(other.managerComment, managerComment) || other.managerComment == managerComment)&&(identical(other.employeeComment, employeeComment) || other.employeeComment == employeeComment)&&(identical(other.achieved, achieved) || other.achieved == achieved)&&(identical(other.weightedScore, weightedScore) || other.weightedScore == weightedScore)&&(identical(other.modified, modified) || other.modified == modified));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,goal,kras,weightage,target,progress,selfRating,selfComment,managerRating,managerPercentage,managerComment,employeeComment,achieved,weightedScore,modified);

@override
String toString() {
  return 'GoalReviewModel(name: $name, goal: $goal, kras: $kras, weightage: $weightage, target: $target, progress: $progress, selfRating: $selfRating, selfComment: $selfComment, managerRating: $managerRating, managerPercentage: $managerPercentage, managerComment: $managerComment, employeeComment: $employeeComment, achieved: $achieved, weightedScore: $weightedScore, modified: $modified)';
}


}

/// @nodoc
abstract mixin class _$GoalReviewModelCopyWith<$Res> implements $GoalReviewModelCopyWith<$Res> {
  factory _$GoalReviewModelCopyWith(_GoalReviewModel value, $Res Function(_GoalReviewModel) _then) = __$GoalReviewModelCopyWithImpl;
@override @useResult
$Res call({
 String name,@JsonKey(name: 'goal', readValue: _readGoalName) String goal,@JsonKey(name: 'kras') String kras, double weightage, double target, double progress,@JsonKey(name: 'self_rating') String selfRating,@JsonKey(name: 'self_comment') String selfComment,@JsonKey(name: 'manager_rating') String managerRating,@JsonKey(name: 'manager_percentage') double managerPercentage,@JsonKey(name: 'manager_comment') String managerComment,@JsonKey(name: 'employee_comment') String employeeComment, double achieved,@JsonKey(name: 'weighted_score') double weightedScore, DateTime modified
});




}
/// @nodoc
class __$GoalReviewModelCopyWithImpl<$Res>
    implements _$GoalReviewModelCopyWith<$Res> {
  __$GoalReviewModelCopyWithImpl(this._self, this._then);

  final _GoalReviewModel _self;
  final $Res Function(_GoalReviewModel) _then;

/// Create a copy of GoalReviewModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? goal = null,Object? kras = null,Object? weightage = null,Object? target = null,Object? progress = null,Object? selfRating = null,Object? selfComment = null,Object? managerRating = null,Object? managerPercentage = null,Object? managerComment = null,Object? employeeComment = null,Object? achieved = null,Object? weightedScore = null,Object? modified = null,}) {
  return _then(_GoalReviewModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as String,kras: null == kras ? _self.kras : kras // ignore: cast_nullable_to_non_nullable
as String,weightage: null == weightage ? _self.weightage : weightage // ignore: cast_nullable_to_non_nullable
as double,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as double,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,selfRating: null == selfRating ? _self.selfRating : selfRating // ignore: cast_nullable_to_non_nullable
as String,selfComment: null == selfComment ? _self.selfComment : selfComment // ignore: cast_nullable_to_non_nullable
as String,managerRating: null == managerRating ? _self.managerRating : managerRating // ignore: cast_nullable_to_non_nullable
as String,managerPercentage: null == managerPercentage ? _self.managerPercentage : managerPercentage // ignore: cast_nullable_to_non_nullable
as double,managerComment: null == managerComment ? _self.managerComment : managerComment // ignore: cast_nullable_to_non_nullable
as String,employeeComment: null == employeeComment ? _self.employeeComment : employeeComment // ignore: cast_nullable_to_non_nullable
as String,achieved: null == achieved ? _self.achieved : achieved // ignore: cast_nullable_to_non_nullable
as double,weightedScore: null == weightedScore ? _self.weightedScore : weightedScore // ignore: cast_nullable_to_non_nullable
as double,modified: null == modified ? _self.modified : modified // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$TimelineStageModel {

 String get name;@JsonKey(name: 'stage_name') String get stageName; DateTime get date;@JsonKey(name: 'stauts') String get status;
/// Create a copy of TimelineStageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimelineStageModelCopyWith<TimelineStageModel> get copyWith => _$TimelineStageModelCopyWithImpl<TimelineStageModel>(this as TimelineStageModel, _$identity);

  /// Serializes this TimelineStageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimelineStageModel&&(identical(other.name, name) || other.name == name)&&(identical(other.stageName, stageName) || other.stageName == stageName)&&(identical(other.date, date) || other.date == date)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,stageName,date,status);

@override
String toString() {
  return 'TimelineStageModel(name: $name, stageName: $stageName, date: $date, status: $status)';
}


}

/// @nodoc
abstract mixin class $TimelineStageModelCopyWith<$Res>  {
  factory $TimelineStageModelCopyWith(TimelineStageModel value, $Res Function(TimelineStageModel) _then) = _$TimelineStageModelCopyWithImpl;
@useResult
$Res call({
 String name,@JsonKey(name: 'stage_name') String stageName, DateTime date,@JsonKey(name: 'stauts') String status
});




}
/// @nodoc
class _$TimelineStageModelCopyWithImpl<$Res>
    implements $TimelineStageModelCopyWith<$Res> {
  _$TimelineStageModelCopyWithImpl(this._self, this._then);

  final TimelineStageModel _self;
  final $Res Function(TimelineStageModel) _then;

/// Create a copy of TimelineStageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? stageName = null,Object? date = null,Object? status = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,stageName: null == stageName ? _self.stageName : stageName // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TimelineStageModel].
extension TimelineStageModelPatterns on TimelineStageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimelineStageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimelineStageModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimelineStageModel value)  $default,){
final _that = this;
switch (_that) {
case _TimelineStageModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimelineStageModel value)?  $default,){
final _that = this;
switch (_that) {
case _TimelineStageModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'stage_name')  String stageName,  DateTime date, @JsonKey(name: 'stauts')  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimelineStageModel() when $default != null:
return $default(_that.name,_that.stageName,_that.date,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'stage_name')  String stageName,  DateTime date, @JsonKey(name: 'stauts')  String status)  $default,) {final _that = this;
switch (_that) {
case _TimelineStageModel():
return $default(_that.name,_that.stageName,_that.date,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name, @JsonKey(name: 'stage_name')  String stageName,  DateTime date, @JsonKey(name: 'stauts')  String status)?  $default,) {final _that = this;
switch (_that) {
case _TimelineStageModel() when $default != null:
return $default(_that.name,_that.stageName,_that.date,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TimelineStageModel extends TimelineStageModel {
  const _TimelineStageModel({required this.name, @JsonKey(name: 'stage_name') this.stageName = '', required this.date, @JsonKey(name: 'stauts') this.status = ''}): super._();
  factory _TimelineStageModel.fromJson(Map<String, dynamic> json) => _$TimelineStageModelFromJson(json);

@override final  String name;
@override@JsonKey(name: 'stage_name') final  String stageName;
@override final  DateTime date;
@override@JsonKey(name: 'stauts') final  String status;

/// Create a copy of TimelineStageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimelineStageModelCopyWith<_TimelineStageModel> get copyWith => __$TimelineStageModelCopyWithImpl<_TimelineStageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TimelineStageModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimelineStageModel&&(identical(other.name, name) || other.name == name)&&(identical(other.stageName, stageName) || other.stageName == stageName)&&(identical(other.date, date) || other.date == date)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,stageName,date,status);

@override
String toString() {
  return 'TimelineStageModel(name: $name, stageName: $stageName, date: $date, status: $status)';
}


}

/// @nodoc
abstract mixin class _$TimelineStageModelCopyWith<$Res> implements $TimelineStageModelCopyWith<$Res> {
  factory _$TimelineStageModelCopyWith(_TimelineStageModel value, $Res Function(_TimelineStageModel) _then) = __$TimelineStageModelCopyWithImpl;
@override @useResult
$Res call({
 String name,@JsonKey(name: 'stage_name') String stageName, DateTime date,@JsonKey(name: 'stauts') String status
});




}
/// @nodoc
class __$TimelineStageModelCopyWithImpl<$Res>
    implements _$TimelineStageModelCopyWith<$Res> {
  __$TimelineStageModelCopyWithImpl(this._self, this._then);

  final _TimelineStageModel _self;
  final $Res Function(_TimelineStageModel) _then;

/// Create a copy of TimelineStageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? stageName = null,Object? date = null,Object? status = null,}) {
  return _then(_TimelineStageModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,stageName: null == stageName ? _self.stageName : stageName // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CompetencyReviewModel {

 String get name; String get competency;
/// Create a copy of CompetencyReviewModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompetencyReviewModelCopyWith<CompetencyReviewModel> get copyWith => _$CompetencyReviewModelCopyWithImpl<CompetencyReviewModel>(this as CompetencyReviewModel, _$identity);

  /// Serializes this CompetencyReviewModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompetencyReviewModel&&(identical(other.name, name) || other.name == name)&&(identical(other.competency, competency) || other.competency == competency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,competency);

@override
String toString() {
  return 'CompetencyReviewModel(name: $name, competency: $competency)';
}


}

/// @nodoc
abstract mixin class $CompetencyReviewModelCopyWith<$Res>  {
  factory $CompetencyReviewModelCopyWith(CompetencyReviewModel value, $Res Function(CompetencyReviewModel) _then) = _$CompetencyReviewModelCopyWithImpl;
@useResult
$Res call({
 String name, String competency
});




}
/// @nodoc
class _$CompetencyReviewModelCopyWithImpl<$Res>
    implements $CompetencyReviewModelCopyWith<$Res> {
  _$CompetencyReviewModelCopyWithImpl(this._self, this._then);

  final CompetencyReviewModel _self;
  final $Res Function(CompetencyReviewModel) _then;

/// Create a copy of CompetencyReviewModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? competency = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,competency: null == competency ? _self.competency : competency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CompetencyReviewModel].
extension CompetencyReviewModelPatterns on CompetencyReviewModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompetencyReviewModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompetencyReviewModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompetencyReviewModel value)  $default,){
final _that = this;
switch (_that) {
case _CompetencyReviewModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompetencyReviewModel value)?  $default,){
final _that = this;
switch (_that) {
case _CompetencyReviewModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String competency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompetencyReviewModel() when $default != null:
return $default(_that.name,_that.competency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String competency)  $default,) {final _that = this;
switch (_that) {
case _CompetencyReviewModel():
return $default(_that.name,_that.competency);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String competency)?  $default,) {final _that = this;
switch (_that) {
case _CompetencyReviewModel() when $default != null:
return $default(_that.name,_that.competency);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompetencyReviewModel extends CompetencyReviewModel {
  const _CompetencyReviewModel({required this.name, required this.competency}): super._();
  factory _CompetencyReviewModel.fromJson(Map<String, dynamic> json) => _$CompetencyReviewModelFromJson(json);

@override final  String name;
@override final  String competency;

/// Create a copy of CompetencyReviewModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompetencyReviewModelCopyWith<_CompetencyReviewModel> get copyWith => __$CompetencyReviewModelCopyWithImpl<_CompetencyReviewModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompetencyReviewModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompetencyReviewModel&&(identical(other.name, name) || other.name == name)&&(identical(other.competency, competency) || other.competency == competency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,competency);

@override
String toString() {
  return 'CompetencyReviewModel(name: $name, competency: $competency)';
}


}

/// @nodoc
abstract mixin class _$CompetencyReviewModelCopyWith<$Res> implements $CompetencyReviewModelCopyWith<$Res> {
  factory _$CompetencyReviewModelCopyWith(_CompetencyReviewModel value, $Res Function(_CompetencyReviewModel) _then) = __$CompetencyReviewModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String competency
});




}
/// @nodoc
class __$CompetencyReviewModelCopyWithImpl<$Res>
    implements _$CompetencyReviewModelCopyWith<$Res> {
  __$CompetencyReviewModelCopyWithImpl(this._self, this._then);

  final _CompetencyReviewModel _self;
  final $Res Function(_CompetencyReviewModel) _then;

/// Create a copy of CompetencyReviewModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? competency = null,}) {
  return _then(_CompetencyReviewModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,competency: null == competency ? _self.competency : competency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
