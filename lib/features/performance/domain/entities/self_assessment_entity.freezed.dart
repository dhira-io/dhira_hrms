// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'self_assessment_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SelfAssessmentEntity {

 String get name; String get employee; String get employeeName; String get cycle; String get goal; DateTime get submissionDate; DateTime get modified; List<GoalReviewEntity> get goalReviews; List<TimelineStageEntity> get timeline; List<CompetencyReviewEntity> get competencyReviews; List<FileAttachmentEntity> get attachments;
/// Create a copy of SelfAssessmentEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelfAssessmentEntityCopyWith<SelfAssessmentEntity> get copyWith => _$SelfAssessmentEntityCopyWithImpl<SelfAssessmentEntity>(this as SelfAssessmentEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelfAssessmentEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.cycle, cycle) || other.cycle == cycle)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.submissionDate, submissionDate) || other.submissionDate == submissionDate)&&(identical(other.modified, modified) || other.modified == modified)&&const DeepCollectionEquality().equals(other.goalReviews, goalReviews)&&const DeepCollectionEquality().equals(other.timeline, timeline)&&const DeepCollectionEquality().equals(other.competencyReviews, competencyReviews)&&const DeepCollectionEquality().equals(other.attachments, attachments));
}


@override
int get hashCode => Object.hash(runtimeType,name,employee,employeeName,cycle,goal,submissionDate,modified,const DeepCollectionEquality().hash(goalReviews),const DeepCollectionEquality().hash(timeline),const DeepCollectionEquality().hash(competencyReviews),const DeepCollectionEquality().hash(attachments));

@override
String toString() {
  return 'SelfAssessmentEntity(name: $name, employee: $employee, employeeName: $employeeName, cycle: $cycle, goal: $goal, submissionDate: $submissionDate, modified: $modified, goalReviews: $goalReviews, timeline: $timeline, competencyReviews: $competencyReviews, attachments: $attachments)';
}


}

/// @nodoc
abstract mixin class $SelfAssessmentEntityCopyWith<$Res>  {
  factory $SelfAssessmentEntityCopyWith(SelfAssessmentEntity value, $Res Function(SelfAssessmentEntity) _then) = _$SelfAssessmentEntityCopyWithImpl;
@useResult
$Res call({
 String name, String employee, String employeeName, String cycle, String goal, DateTime submissionDate, DateTime modified, List<GoalReviewEntity> goalReviews, List<TimelineStageEntity> timeline, List<CompetencyReviewEntity> competencyReviews, List<FileAttachmentEntity> attachments
});




}
/// @nodoc
class _$SelfAssessmentEntityCopyWithImpl<$Res>
    implements $SelfAssessmentEntityCopyWith<$Res> {
  _$SelfAssessmentEntityCopyWithImpl(this._self, this._then);

  final SelfAssessmentEntity _self;
  final $Res Function(SelfAssessmentEntity) _then;

/// Create a copy of SelfAssessmentEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? employee = null,Object? employeeName = null,Object? cycle = null,Object? goal = null,Object? submissionDate = null,Object? modified = null,Object? goalReviews = null,Object? timeline = null,Object? competencyReviews = null,Object? attachments = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,employee: null == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as String,employeeName: null == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String,cycle: null == cycle ? _self.cycle : cycle // ignore: cast_nullable_to_non_nullable
as String,goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as String,submissionDate: null == submissionDate ? _self.submissionDate : submissionDate // ignore: cast_nullable_to_non_nullable
as DateTime,modified: null == modified ? _self.modified : modified // ignore: cast_nullable_to_non_nullable
as DateTime,goalReviews: null == goalReviews ? _self.goalReviews : goalReviews // ignore: cast_nullable_to_non_nullable
as List<GoalReviewEntity>,timeline: null == timeline ? _self.timeline : timeline // ignore: cast_nullable_to_non_nullable
as List<TimelineStageEntity>,competencyReviews: null == competencyReviews ? _self.competencyReviews : competencyReviews // ignore: cast_nullable_to_non_nullable
as List<CompetencyReviewEntity>,attachments: null == attachments ? _self.attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<FileAttachmentEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [SelfAssessmentEntity].
extension SelfAssessmentEntityPatterns on SelfAssessmentEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SelfAssessmentEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SelfAssessmentEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SelfAssessmentEntity value)  $default,){
final _that = this;
switch (_that) {
case _SelfAssessmentEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SelfAssessmentEntity value)?  $default,){
final _that = this;
switch (_that) {
case _SelfAssessmentEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String employee,  String employeeName,  String cycle,  String goal,  DateTime submissionDate,  DateTime modified,  List<GoalReviewEntity> goalReviews,  List<TimelineStageEntity> timeline,  List<CompetencyReviewEntity> competencyReviews,  List<FileAttachmentEntity> attachments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SelfAssessmentEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String employee,  String employeeName,  String cycle,  String goal,  DateTime submissionDate,  DateTime modified,  List<GoalReviewEntity> goalReviews,  List<TimelineStageEntity> timeline,  List<CompetencyReviewEntity> competencyReviews,  List<FileAttachmentEntity> attachments)  $default,) {final _that = this;
switch (_that) {
case _SelfAssessmentEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String employee,  String employeeName,  String cycle,  String goal,  DateTime submissionDate,  DateTime modified,  List<GoalReviewEntity> goalReviews,  List<TimelineStageEntity> timeline,  List<CompetencyReviewEntity> competencyReviews,  List<FileAttachmentEntity> attachments)?  $default,) {final _that = this;
switch (_that) {
case _SelfAssessmentEntity() when $default != null:
return $default(_that.name,_that.employee,_that.employeeName,_that.cycle,_that.goal,_that.submissionDate,_that.modified,_that.goalReviews,_that.timeline,_that.competencyReviews,_that.attachments);case _:
  return null;

}
}

}

/// @nodoc


class _SelfAssessmentEntity implements SelfAssessmentEntity {
  const _SelfAssessmentEntity({required this.name, required this.employee, required this.employeeName, required this.cycle, required this.goal, required this.submissionDate, required this.modified, required final  List<GoalReviewEntity> goalReviews, required final  List<TimelineStageEntity> timeline, required final  List<CompetencyReviewEntity> competencyReviews, final  List<FileAttachmentEntity> attachments = const []}): _goalReviews = goalReviews,_timeline = timeline,_competencyReviews = competencyReviews,_attachments = attachments;
  

@override final  String name;
@override final  String employee;
@override final  String employeeName;
@override final  String cycle;
@override final  String goal;
@override final  DateTime submissionDate;
@override final  DateTime modified;
 final  List<GoalReviewEntity> _goalReviews;
@override List<GoalReviewEntity> get goalReviews {
  if (_goalReviews is EqualUnmodifiableListView) return _goalReviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_goalReviews);
}

 final  List<TimelineStageEntity> _timeline;
@override List<TimelineStageEntity> get timeline {
  if (_timeline is EqualUnmodifiableListView) return _timeline;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_timeline);
}

 final  List<CompetencyReviewEntity> _competencyReviews;
@override List<CompetencyReviewEntity> get competencyReviews {
  if (_competencyReviews is EqualUnmodifiableListView) return _competencyReviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_competencyReviews);
}

 final  List<FileAttachmentEntity> _attachments;
@override@JsonKey() List<FileAttachmentEntity> get attachments {
  if (_attachments is EqualUnmodifiableListView) return _attachments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attachments);
}


/// Create a copy of SelfAssessmentEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelfAssessmentEntityCopyWith<_SelfAssessmentEntity> get copyWith => __$SelfAssessmentEntityCopyWithImpl<_SelfAssessmentEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelfAssessmentEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.cycle, cycle) || other.cycle == cycle)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.submissionDate, submissionDate) || other.submissionDate == submissionDate)&&(identical(other.modified, modified) || other.modified == modified)&&const DeepCollectionEquality().equals(other._goalReviews, _goalReviews)&&const DeepCollectionEquality().equals(other._timeline, _timeline)&&const DeepCollectionEquality().equals(other._competencyReviews, _competencyReviews)&&const DeepCollectionEquality().equals(other._attachments, _attachments));
}


@override
int get hashCode => Object.hash(runtimeType,name,employee,employeeName,cycle,goal,submissionDate,modified,const DeepCollectionEquality().hash(_goalReviews),const DeepCollectionEquality().hash(_timeline),const DeepCollectionEquality().hash(_competencyReviews),const DeepCollectionEquality().hash(_attachments));

@override
String toString() {
  return 'SelfAssessmentEntity(name: $name, employee: $employee, employeeName: $employeeName, cycle: $cycle, goal: $goal, submissionDate: $submissionDate, modified: $modified, goalReviews: $goalReviews, timeline: $timeline, competencyReviews: $competencyReviews, attachments: $attachments)';
}


}

/// @nodoc
abstract mixin class _$SelfAssessmentEntityCopyWith<$Res> implements $SelfAssessmentEntityCopyWith<$Res> {
  factory _$SelfAssessmentEntityCopyWith(_SelfAssessmentEntity value, $Res Function(_SelfAssessmentEntity) _then) = __$SelfAssessmentEntityCopyWithImpl;
@override @useResult
$Res call({
 String name, String employee, String employeeName, String cycle, String goal, DateTime submissionDate, DateTime modified, List<GoalReviewEntity> goalReviews, List<TimelineStageEntity> timeline, List<CompetencyReviewEntity> competencyReviews, List<FileAttachmentEntity> attachments
});




}
/// @nodoc
class __$SelfAssessmentEntityCopyWithImpl<$Res>
    implements _$SelfAssessmentEntityCopyWith<$Res> {
  __$SelfAssessmentEntityCopyWithImpl(this._self, this._then);

  final _SelfAssessmentEntity _self;
  final $Res Function(_SelfAssessmentEntity) _then;

/// Create a copy of SelfAssessmentEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? employee = null,Object? employeeName = null,Object? cycle = null,Object? goal = null,Object? submissionDate = null,Object? modified = null,Object? goalReviews = null,Object? timeline = null,Object? competencyReviews = null,Object? attachments = null,}) {
  return _then(_SelfAssessmentEntity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,employee: null == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as String,employeeName: null == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String,cycle: null == cycle ? _self.cycle : cycle // ignore: cast_nullable_to_non_nullable
as String,goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as String,submissionDate: null == submissionDate ? _self.submissionDate : submissionDate // ignore: cast_nullable_to_non_nullable
as DateTime,modified: null == modified ? _self.modified : modified // ignore: cast_nullable_to_non_nullable
as DateTime,goalReviews: null == goalReviews ? _self._goalReviews : goalReviews // ignore: cast_nullable_to_non_nullable
as List<GoalReviewEntity>,timeline: null == timeline ? _self._timeline : timeline // ignore: cast_nullable_to_non_nullable
as List<TimelineStageEntity>,competencyReviews: null == competencyReviews ? _self._competencyReviews : competencyReviews // ignore: cast_nullable_to_non_nullable
as List<CompetencyReviewEntity>,attachments: null == attachments ? _self._attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<FileAttachmentEntity>,
  ));
}


}

/// @nodoc
mixin _$FileAttachmentEntity {

 String get name; String get fileName; String get fileUrl;
/// Create a copy of FileAttachmentEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FileAttachmentEntityCopyWith<FileAttachmentEntity> get copyWith => _$FileAttachmentEntityCopyWithImpl<FileAttachmentEntity>(this as FileAttachmentEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FileAttachmentEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl));
}


@override
int get hashCode => Object.hash(runtimeType,name,fileName,fileUrl);

@override
String toString() {
  return 'FileAttachmentEntity(name: $name, fileName: $fileName, fileUrl: $fileUrl)';
}


}

/// @nodoc
abstract mixin class $FileAttachmentEntityCopyWith<$Res>  {
  factory $FileAttachmentEntityCopyWith(FileAttachmentEntity value, $Res Function(FileAttachmentEntity) _then) = _$FileAttachmentEntityCopyWithImpl;
@useResult
$Res call({
 String name, String fileName, String fileUrl
});




}
/// @nodoc
class _$FileAttachmentEntityCopyWithImpl<$Res>
    implements $FileAttachmentEntityCopyWith<$Res> {
  _$FileAttachmentEntityCopyWithImpl(this._self, this._then);

  final FileAttachmentEntity _self;
  final $Res Function(FileAttachmentEntity) _then;

/// Create a copy of FileAttachmentEntity
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


/// Adds pattern-matching-related methods to [FileAttachmentEntity].
extension FileAttachmentEntityPatterns on FileAttachmentEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FileAttachmentEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FileAttachmentEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FileAttachmentEntity value)  $default,){
final _that = this;
switch (_that) {
case _FileAttachmentEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FileAttachmentEntity value)?  $default,){
final _that = this;
switch (_that) {
case _FileAttachmentEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String fileName,  String fileUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FileAttachmentEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String fileName,  String fileUrl)  $default,) {final _that = this;
switch (_that) {
case _FileAttachmentEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String fileName,  String fileUrl)?  $default,) {final _that = this;
switch (_that) {
case _FileAttachmentEntity() when $default != null:
return $default(_that.name,_that.fileName,_that.fileUrl);case _:
  return null;

}
}

}

/// @nodoc


class _FileAttachmentEntity implements FileAttachmentEntity {
  const _FileAttachmentEntity({required this.name, required this.fileName, required this.fileUrl});
  

@override final  String name;
@override final  String fileName;
@override final  String fileUrl;

/// Create a copy of FileAttachmentEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FileAttachmentEntityCopyWith<_FileAttachmentEntity> get copyWith => __$FileAttachmentEntityCopyWithImpl<_FileAttachmentEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FileAttachmentEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl));
}


@override
int get hashCode => Object.hash(runtimeType,name,fileName,fileUrl);

@override
String toString() {
  return 'FileAttachmentEntity(name: $name, fileName: $fileName, fileUrl: $fileUrl)';
}


}

/// @nodoc
abstract mixin class _$FileAttachmentEntityCopyWith<$Res> implements $FileAttachmentEntityCopyWith<$Res> {
  factory _$FileAttachmentEntityCopyWith(_FileAttachmentEntity value, $Res Function(_FileAttachmentEntity) _then) = __$FileAttachmentEntityCopyWithImpl;
@override @useResult
$Res call({
 String name, String fileName, String fileUrl
});




}
/// @nodoc
class __$FileAttachmentEntityCopyWithImpl<$Res>
    implements _$FileAttachmentEntityCopyWith<$Res> {
  __$FileAttachmentEntityCopyWithImpl(this._self, this._then);

  final _FileAttachmentEntity _self;
  final $Res Function(_FileAttachmentEntity) _then;

/// Create a copy of FileAttachmentEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? fileName = null,Object? fileUrl = null,}) {
  return _then(_FileAttachmentEntity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,fileUrl: null == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$GoalReviewEntity {

 String get name; String get goal; String get kras; double get weightage; double get target; double get progress; String get selfRating; String get selfComment; String get managerRating; double get managerPercentage; String get managerComment; String get employeeComment; double get achieved; DateTime get modified;
/// Create a copy of GoalReviewEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalReviewEntityCopyWith<GoalReviewEntity> get copyWith => _$GoalReviewEntityCopyWithImpl<GoalReviewEntity>(this as GoalReviewEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalReviewEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.kras, kras) || other.kras == kras)&&(identical(other.weightage, weightage) || other.weightage == weightage)&&(identical(other.target, target) || other.target == target)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.selfRating, selfRating) || other.selfRating == selfRating)&&(identical(other.selfComment, selfComment) || other.selfComment == selfComment)&&(identical(other.managerRating, managerRating) || other.managerRating == managerRating)&&(identical(other.managerPercentage, managerPercentage) || other.managerPercentage == managerPercentage)&&(identical(other.managerComment, managerComment) || other.managerComment == managerComment)&&(identical(other.employeeComment, employeeComment) || other.employeeComment == employeeComment)&&(identical(other.achieved, achieved) || other.achieved == achieved)&&(identical(other.modified, modified) || other.modified == modified));
}


@override
int get hashCode => Object.hash(runtimeType,name,goal,kras,weightage,target,progress,selfRating,selfComment,managerRating,managerPercentage,managerComment,employeeComment,achieved,modified);

@override
String toString() {
  return 'GoalReviewEntity(name: $name, goal: $goal, kras: $kras, weightage: $weightage, target: $target, progress: $progress, selfRating: $selfRating, selfComment: $selfComment, managerRating: $managerRating, managerPercentage: $managerPercentage, managerComment: $managerComment, employeeComment: $employeeComment, achieved: $achieved, modified: $modified)';
}


}

/// @nodoc
abstract mixin class $GoalReviewEntityCopyWith<$Res>  {
  factory $GoalReviewEntityCopyWith(GoalReviewEntity value, $Res Function(GoalReviewEntity) _then) = _$GoalReviewEntityCopyWithImpl;
@useResult
$Res call({
 String name, String goal, String kras, double weightage, double target, double progress, String selfRating, String selfComment, String managerRating, double managerPercentage, String managerComment, String employeeComment, double achieved, DateTime modified
});




}
/// @nodoc
class _$GoalReviewEntityCopyWithImpl<$Res>
    implements $GoalReviewEntityCopyWith<$Res> {
  _$GoalReviewEntityCopyWithImpl(this._self, this._then);

  final GoalReviewEntity _self;
  final $Res Function(GoalReviewEntity) _then;

/// Create a copy of GoalReviewEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? goal = null,Object? kras = null,Object? weightage = null,Object? target = null,Object? progress = null,Object? selfRating = null,Object? selfComment = null,Object? managerRating = null,Object? managerPercentage = null,Object? managerComment = null,Object? employeeComment = null,Object? achieved = null,Object? modified = null,}) {
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
as double,modified: null == modified ? _self.modified : modified // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [GoalReviewEntity].
extension GoalReviewEntityPatterns on GoalReviewEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoalReviewEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoalReviewEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoalReviewEntity value)  $default,){
final _that = this;
switch (_that) {
case _GoalReviewEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoalReviewEntity value)?  $default,){
final _that = this;
switch (_that) {
case _GoalReviewEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String goal,  String kras,  double weightage,  double target,  double progress,  String selfRating,  String selfComment,  String managerRating,  double managerPercentage,  String managerComment,  String employeeComment,  double achieved,  DateTime modified)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoalReviewEntity() when $default != null:
return $default(_that.name,_that.goal,_that.kras,_that.weightage,_that.target,_that.progress,_that.selfRating,_that.selfComment,_that.managerRating,_that.managerPercentage,_that.managerComment,_that.employeeComment,_that.achieved,_that.modified);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String goal,  String kras,  double weightage,  double target,  double progress,  String selfRating,  String selfComment,  String managerRating,  double managerPercentage,  String managerComment,  String employeeComment,  double achieved,  DateTime modified)  $default,) {final _that = this;
switch (_that) {
case _GoalReviewEntity():
return $default(_that.name,_that.goal,_that.kras,_that.weightage,_that.target,_that.progress,_that.selfRating,_that.selfComment,_that.managerRating,_that.managerPercentage,_that.managerComment,_that.employeeComment,_that.achieved,_that.modified);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String goal,  String kras,  double weightage,  double target,  double progress,  String selfRating,  String selfComment,  String managerRating,  double managerPercentage,  String managerComment,  String employeeComment,  double achieved,  DateTime modified)?  $default,) {final _that = this;
switch (_that) {
case _GoalReviewEntity() when $default != null:
return $default(_that.name,_that.goal,_that.kras,_that.weightage,_that.target,_that.progress,_that.selfRating,_that.selfComment,_that.managerRating,_that.managerPercentage,_that.managerComment,_that.employeeComment,_that.achieved,_that.modified);case _:
  return null;

}
}

}

/// @nodoc


class _GoalReviewEntity implements GoalReviewEntity {
  const _GoalReviewEntity({required this.name, required this.goal, required this.kras, required this.weightage, required this.target, required this.progress, required this.selfRating, required this.selfComment, required this.managerRating, required this.managerPercentage, required this.managerComment, required this.employeeComment, required this.achieved, required this.modified});
  

@override final  String name;
@override final  String goal;
@override final  String kras;
@override final  double weightage;
@override final  double target;
@override final  double progress;
@override final  String selfRating;
@override final  String selfComment;
@override final  String managerRating;
@override final  double managerPercentage;
@override final  String managerComment;
@override final  String employeeComment;
@override final  double achieved;
@override final  DateTime modified;

/// Create a copy of GoalReviewEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoalReviewEntityCopyWith<_GoalReviewEntity> get copyWith => __$GoalReviewEntityCopyWithImpl<_GoalReviewEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoalReviewEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.kras, kras) || other.kras == kras)&&(identical(other.weightage, weightage) || other.weightage == weightage)&&(identical(other.target, target) || other.target == target)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.selfRating, selfRating) || other.selfRating == selfRating)&&(identical(other.selfComment, selfComment) || other.selfComment == selfComment)&&(identical(other.managerRating, managerRating) || other.managerRating == managerRating)&&(identical(other.managerPercentage, managerPercentage) || other.managerPercentage == managerPercentage)&&(identical(other.managerComment, managerComment) || other.managerComment == managerComment)&&(identical(other.employeeComment, employeeComment) || other.employeeComment == employeeComment)&&(identical(other.achieved, achieved) || other.achieved == achieved)&&(identical(other.modified, modified) || other.modified == modified));
}


@override
int get hashCode => Object.hash(runtimeType,name,goal,kras,weightage,target,progress,selfRating,selfComment,managerRating,managerPercentage,managerComment,employeeComment,achieved,modified);

@override
String toString() {
  return 'GoalReviewEntity(name: $name, goal: $goal, kras: $kras, weightage: $weightage, target: $target, progress: $progress, selfRating: $selfRating, selfComment: $selfComment, managerRating: $managerRating, managerPercentage: $managerPercentage, managerComment: $managerComment, employeeComment: $employeeComment, achieved: $achieved, modified: $modified)';
}


}

/// @nodoc
abstract mixin class _$GoalReviewEntityCopyWith<$Res> implements $GoalReviewEntityCopyWith<$Res> {
  factory _$GoalReviewEntityCopyWith(_GoalReviewEntity value, $Res Function(_GoalReviewEntity) _then) = __$GoalReviewEntityCopyWithImpl;
@override @useResult
$Res call({
 String name, String goal, String kras, double weightage, double target, double progress, String selfRating, String selfComment, String managerRating, double managerPercentage, String managerComment, String employeeComment, double achieved, DateTime modified
});




}
/// @nodoc
class __$GoalReviewEntityCopyWithImpl<$Res>
    implements _$GoalReviewEntityCopyWith<$Res> {
  __$GoalReviewEntityCopyWithImpl(this._self, this._then);

  final _GoalReviewEntity _self;
  final $Res Function(_GoalReviewEntity) _then;

/// Create a copy of GoalReviewEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? goal = null,Object? kras = null,Object? weightage = null,Object? target = null,Object? progress = null,Object? selfRating = null,Object? selfComment = null,Object? managerRating = null,Object? managerPercentage = null,Object? managerComment = null,Object? employeeComment = null,Object? achieved = null,Object? modified = null,}) {
  return _then(_GoalReviewEntity(
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
as double,modified: null == modified ? _self.modified : modified // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$TimelineStageEntity {

 String get name; String get stageName; DateTime get date; String get status;
/// Create a copy of TimelineStageEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimelineStageEntityCopyWith<TimelineStageEntity> get copyWith => _$TimelineStageEntityCopyWithImpl<TimelineStageEntity>(this as TimelineStageEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimelineStageEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.stageName, stageName) || other.stageName == stageName)&&(identical(other.date, date) || other.date == date)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,name,stageName,date,status);

@override
String toString() {
  return 'TimelineStageEntity(name: $name, stageName: $stageName, date: $date, status: $status)';
}


}

/// @nodoc
abstract mixin class $TimelineStageEntityCopyWith<$Res>  {
  factory $TimelineStageEntityCopyWith(TimelineStageEntity value, $Res Function(TimelineStageEntity) _then) = _$TimelineStageEntityCopyWithImpl;
@useResult
$Res call({
 String name, String stageName, DateTime date, String status
});




}
/// @nodoc
class _$TimelineStageEntityCopyWithImpl<$Res>
    implements $TimelineStageEntityCopyWith<$Res> {
  _$TimelineStageEntityCopyWithImpl(this._self, this._then);

  final TimelineStageEntity _self;
  final $Res Function(TimelineStageEntity) _then;

/// Create a copy of TimelineStageEntity
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


/// Adds pattern-matching-related methods to [TimelineStageEntity].
extension TimelineStageEntityPatterns on TimelineStageEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimelineStageEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimelineStageEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimelineStageEntity value)  $default,){
final _that = this;
switch (_that) {
case _TimelineStageEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimelineStageEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TimelineStageEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String stageName,  DateTime date,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimelineStageEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String stageName,  DateTime date,  String status)  $default,) {final _that = this;
switch (_that) {
case _TimelineStageEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String stageName,  DateTime date,  String status)?  $default,) {final _that = this;
switch (_that) {
case _TimelineStageEntity() when $default != null:
return $default(_that.name,_that.stageName,_that.date,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _TimelineStageEntity implements TimelineStageEntity {
  const _TimelineStageEntity({required this.name, required this.stageName, required this.date, required this.status});
  

@override final  String name;
@override final  String stageName;
@override final  DateTime date;
@override final  String status;

/// Create a copy of TimelineStageEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimelineStageEntityCopyWith<_TimelineStageEntity> get copyWith => __$TimelineStageEntityCopyWithImpl<_TimelineStageEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimelineStageEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.stageName, stageName) || other.stageName == stageName)&&(identical(other.date, date) || other.date == date)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,name,stageName,date,status);

@override
String toString() {
  return 'TimelineStageEntity(name: $name, stageName: $stageName, date: $date, status: $status)';
}


}

/// @nodoc
abstract mixin class _$TimelineStageEntityCopyWith<$Res> implements $TimelineStageEntityCopyWith<$Res> {
  factory _$TimelineStageEntityCopyWith(_TimelineStageEntity value, $Res Function(_TimelineStageEntity) _then) = __$TimelineStageEntityCopyWithImpl;
@override @useResult
$Res call({
 String name, String stageName, DateTime date, String status
});




}
/// @nodoc
class __$TimelineStageEntityCopyWithImpl<$Res>
    implements _$TimelineStageEntityCopyWith<$Res> {
  __$TimelineStageEntityCopyWithImpl(this._self, this._then);

  final _TimelineStageEntity _self;
  final $Res Function(_TimelineStageEntity) _then;

/// Create a copy of TimelineStageEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? stageName = null,Object? date = null,Object? status = null,}) {
  return _then(_TimelineStageEntity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,stageName: null == stageName ? _self.stageName : stageName // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$CompetencyReviewEntity {

 String get name; String get competency;
/// Create a copy of CompetencyReviewEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompetencyReviewEntityCopyWith<CompetencyReviewEntity> get copyWith => _$CompetencyReviewEntityCopyWithImpl<CompetencyReviewEntity>(this as CompetencyReviewEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompetencyReviewEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.competency, competency) || other.competency == competency));
}


@override
int get hashCode => Object.hash(runtimeType,name,competency);

@override
String toString() {
  return 'CompetencyReviewEntity(name: $name, competency: $competency)';
}


}

/// @nodoc
abstract mixin class $CompetencyReviewEntityCopyWith<$Res>  {
  factory $CompetencyReviewEntityCopyWith(CompetencyReviewEntity value, $Res Function(CompetencyReviewEntity) _then) = _$CompetencyReviewEntityCopyWithImpl;
@useResult
$Res call({
 String name, String competency
});




}
/// @nodoc
class _$CompetencyReviewEntityCopyWithImpl<$Res>
    implements $CompetencyReviewEntityCopyWith<$Res> {
  _$CompetencyReviewEntityCopyWithImpl(this._self, this._then);

  final CompetencyReviewEntity _self;
  final $Res Function(CompetencyReviewEntity) _then;

/// Create a copy of CompetencyReviewEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? competency = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,competency: null == competency ? _self.competency : competency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CompetencyReviewEntity].
extension CompetencyReviewEntityPatterns on CompetencyReviewEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompetencyReviewEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompetencyReviewEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompetencyReviewEntity value)  $default,){
final _that = this;
switch (_that) {
case _CompetencyReviewEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompetencyReviewEntity value)?  $default,){
final _that = this;
switch (_that) {
case _CompetencyReviewEntity() when $default != null:
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
case _CompetencyReviewEntity() when $default != null:
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
case _CompetencyReviewEntity():
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
case _CompetencyReviewEntity() when $default != null:
return $default(_that.name,_that.competency);case _:
  return null;

}
}

}

/// @nodoc


class _CompetencyReviewEntity implements CompetencyReviewEntity {
  const _CompetencyReviewEntity({required this.name, required this.competency});
  

@override final  String name;
@override final  String competency;

/// Create a copy of CompetencyReviewEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompetencyReviewEntityCopyWith<_CompetencyReviewEntity> get copyWith => __$CompetencyReviewEntityCopyWithImpl<_CompetencyReviewEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompetencyReviewEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.competency, competency) || other.competency == competency));
}


@override
int get hashCode => Object.hash(runtimeType,name,competency);

@override
String toString() {
  return 'CompetencyReviewEntity(name: $name, competency: $competency)';
}


}

/// @nodoc
abstract mixin class _$CompetencyReviewEntityCopyWith<$Res> implements $CompetencyReviewEntityCopyWith<$Res> {
  factory _$CompetencyReviewEntityCopyWith(_CompetencyReviewEntity value, $Res Function(_CompetencyReviewEntity) _then) = __$CompetencyReviewEntityCopyWithImpl;
@override @useResult
$Res call({
 String name, String competency
});




}
/// @nodoc
class __$CompetencyReviewEntityCopyWithImpl<$Res>
    implements _$CompetencyReviewEntityCopyWith<$Res> {
  __$CompetencyReviewEntityCopyWithImpl(this._self, this._then);

  final _CompetencyReviewEntity _self;
  final $Res Function(_CompetencyReviewEntity) _then;

/// Create a copy of CompetencyReviewEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? competency = null,}) {
  return _then(_CompetencyReviewEntity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,competency: null == competency ? _self.competency : competency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
