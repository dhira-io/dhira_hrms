// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'self_assessment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SelfAssessmentModel _$SelfAssessmentModelFromJson(Map<String, dynamic> json) {
  return _SelfAssessmentModel.fromJson(json);
}

/// @nodoc
mixin _$SelfAssessmentModel {
  String get name => throw _privateConstructorUsedError;
  String get employee => throw _privateConstructorUsedError;
  @JsonKey(name: 'employee_name')
  String get employeeName => throw _privateConstructorUsedError;
  String get cycle => throw _privateConstructorUsedError;
  String get goal => throw _privateConstructorUsedError;
  @JsonKey(name: 'submission_date')
  DateTime? get submissionDate => throw _privateConstructorUsedError;
  DateTime get modified => throw _privateConstructorUsedError;
  @JsonKey(name: 'goal_ratings', readValue: _readGoalsList)
  List<GoalReviewModel> get goalReviews => throw _privateConstructorUsedError;
  List<TimelineStageModel> get timeline => throw _privateConstructorUsedError;
  @JsonKey(name: 'competency_ratings', readValue: _readCompetenciesList)
  List<CompetencyReviewModel> get competencyReviews =>
      throw _privateConstructorUsedError;
  List<FileAttachmentModel> get attachments =>
      throw _privateConstructorUsedError;

  /// Serializes this SelfAssessmentModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SelfAssessmentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SelfAssessmentModelCopyWith<SelfAssessmentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelfAssessmentModelCopyWith<$Res> {
  factory $SelfAssessmentModelCopyWith(
    SelfAssessmentModel value,
    $Res Function(SelfAssessmentModel) then,
  ) = _$SelfAssessmentModelCopyWithImpl<$Res, SelfAssessmentModel>;
  @useResult
  $Res call({
    String name,
    String employee,
    @JsonKey(name: 'employee_name') String employeeName,
    String cycle,
    String goal,
    @JsonKey(name: 'submission_date') DateTime? submissionDate,
    DateTime modified,
    @JsonKey(name: 'goal_ratings', readValue: _readGoalsList)
    List<GoalReviewModel> goalReviews,
    List<TimelineStageModel> timeline,
    @JsonKey(name: 'competency_ratings', readValue: _readCompetenciesList)
    List<CompetencyReviewModel> competencyReviews,
    List<FileAttachmentModel> attachments,
  });
}

/// @nodoc
class _$SelfAssessmentModelCopyWithImpl<$Res, $Val extends SelfAssessmentModel>
    implements $SelfAssessmentModelCopyWith<$Res> {
  _$SelfAssessmentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SelfAssessmentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? employee = null,
    Object? employeeName = null,
    Object? cycle = null,
    Object? goal = null,
    Object? submissionDate = freezed,
    Object? modified = null,
    Object? goalReviews = null,
    Object? timeline = null,
    Object? competencyReviews = null,
    Object? attachments = null,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            employee: null == employee
                ? _value.employee
                : employee // ignore: cast_nullable_to_non_nullable
                      as String,
            employeeName: null == employeeName
                ? _value.employeeName
                : employeeName // ignore: cast_nullable_to_non_nullable
                      as String,
            cycle: null == cycle
                ? _value.cycle
                : cycle // ignore: cast_nullable_to_non_nullable
                      as String,
            goal: null == goal
                ? _value.goal
                : goal // ignore: cast_nullable_to_non_nullable
                      as String,
            submissionDate: freezed == submissionDate
                ? _value.submissionDate
                : submissionDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            modified: null == modified
                ? _value.modified
                : modified // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            goalReviews: null == goalReviews
                ? _value.goalReviews
                : goalReviews // ignore: cast_nullable_to_non_nullable
                      as List<GoalReviewModel>,
            timeline: null == timeline
                ? _value.timeline
                : timeline // ignore: cast_nullable_to_non_nullable
                      as List<TimelineStageModel>,
            competencyReviews: null == competencyReviews
                ? _value.competencyReviews
                : competencyReviews // ignore: cast_nullable_to_non_nullable
                      as List<CompetencyReviewModel>,
            attachments: null == attachments
                ? _value.attachments
                : attachments // ignore: cast_nullable_to_non_nullable
                      as List<FileAttachmentModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SelfAssessmentModelImplCopyWith<$Res>
    implements $SelfAssessmentModelCopyWith<$Res> {
  factory _$$SelfAssessmentModelImplCopyWith(
    _$SelfAssessmentModelImpl value,
    $Res Function(_$SelfAssessmentModelImpl) then,
  ) = __$$SelfAssessmentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String employee,
    @JsonKey(name: 'employee_name') String employeeName,
    String cycle,
    String goal,
    @JsonKey(name: 'submission_date') DateTime? submissionDate,
    DateTime modified,
    @JsonKey(name: 'goal_ratings', readValue: _readGoalsList)
    List<GoalReviewModel> goalReviews,
    List<TimelineStageModel> timeline,
    @JsonKey(name: 'competency_ratings', readValue: _readCompetenciesList)
    List<CompetencyReviewModel> competencyReviews,
    List<FileAttachmentModel> attachments,
  });
}

/// @nodoc
class __$$SelfAssessmentModelImplCopyWithImpl<$Res>
    extends _$SelfAssessmentModelCopyWithImpl<$Res, _$SelfAssessmentModelImpl>
    implements _$$SelfAssessmentModelImplCopyWith<$Res> {
  __$$SelfAssessmentModelImplCopyWithImpl(
    _$SelfAssessmentModelImpl _value,
    $Res Function(_$SelfAssessmentModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SelfAssessmentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? employee = null,
    Object? employeeName = null,
    Object? cycle = null,
    Object? goal = null,
    Object? submissionDate = freezed,
    Object? modified = null,
    Object? goalReviews = null,
    Object? timeline = null,
    Object? competencyReviews = null,
    Object? attachments = null,
  }) {
    return _then(
      _$SelfAssessmentModelImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        employee: null == employee
            ? _value.employee
            : employee // ignore: cast_nullable_to_non_nullable
                  as String,
        employeeName: null == employeeName
            ? _value.employeeName
            : employeeName // ignore: cast_nullable_to_non_nullable
                  as String,
        cycle: null == cycle
            ? _value.cycle
            : cycle // ignore: cast_nullable_to_non_nullable
                  as String,
        goal: null == goal
            ? _value.goal
            : goal // ignore: cast_nullable_to_non_nullable
                  as String,
        submissionDate: freezed == submissionDate
            ? _value.submissionDate
            : submissionDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        modified: null == modified
            ? _value.modified
            : modified // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        goalReviews: null == goalReviews
            ? _value._goalReviews
            : goalReviews // ignore: cast_nullable_to_non_nullable
                  as List<GoalReviewModel>,
        timeline: null == timeline
            ? _value._timeline
            : timeline // ignore: cast_nullable_to_non_nullable
                  as List<TimelineStageModel>,
        competencyReviews: null == competencyReviews
            ? _value._competencyReviews
            : competencyReviews // ignore: cast_nullable_to_non_nullable
                  as List<CompetencyReviewModel>,
        attachments: null == attachments
            ? _value._attachments
            : attachments // ignore: cast_nullable_to_non_nullable
                  as List<FileAttachmentModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SelfAssessmentModelImpl extends _SelfAssessmentModel {
  const _$SelfAssessmentModelImpl({
    required this.name,
    required this.employee,
    @JsonKey(name: 'employee_name') this.employeeName = '',
    required this.cycle,
    this.goal = '',
    @JsonKey(name: 'submission_date') this.submissionDate,
    required this.modified,
    @JsonKey(name: 'goal_ratings', readValue: _readGoalsList)
    final List<GoalReviewModel> goalReviews = const [],
    final List<TimelineStageModel> timeline = const [],
    @JsonKey(name: 'competency_ratings', readValue: _readCompetenciesList)
    final List<CompetencyReviewModel> competencyReviews = const [],
    final List<FileAttachmentModel> attachments = const [],
  }) : _goalReviews = goalReviews,
       _timeline = timeline,
       _competencyReviews = competencyReviews,
       _attachments = attachments,
       super._();

  factory _$SelfAssessmentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SelfAssessmentModelImplFromJson(json);

  @override
  final String name;
  @override
  final String employee;
  @override
  @JsonKey(name: 'employee_name')
  final String employeeName;
  @override
  final String cycle;
  @override
  @JsonKey()
  final String goal;
  @override
  @JsonKey(name: 'submission_date')
  final DateTime? submissionDate;
  @override
  final DateTime modified;
  final List<GoalReviewModel> _goalReviews;
  @override
  @JsonKey(name: 'goal_ratings', readValue: _readGoalsList)
  List<GoalReviewModel> get goalReviews {
    if (_goalReviews is EqualUnmodifiableListView) return _goalReviews;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_goalReviews);
  }

  final List<TimelineStageModel> _timeline;
  @override
  @JsonKey()
  List<TimelineStageModel> get timeline {
    if (_timeline is EqualUnmodifiableListView) return _timeline;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timeline);
  }

  final List<CompetencyReviewModel> _competencyReviews;
  @override
  @JsonKey(name: 'competency_ratings', readValue: _readCompetenciesList)
  List<CompetencyReviewModel> get competencyReviews {
    if (_competencyReviews is EqualUnmodifiableListView)
      return _competencyReviews;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_competencyReviews);
  }

  final List<FileAttachmentModel> _attachments;
  @override
  @JsonKey()
  List<FileAttachmentModel> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

  @override
  String toString() {
    return 'SelfAssessmentModel(name: $name, employee: $employee, employeeName: $employeeName, cycle: $cycle, goal: $goal, submissionDate: $submissionDate, modified: $modified, goalReviews: $goalReviews, timeline: $timeline, competencyReviews: $competencyReviews, attachments: $attachments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelfAssessmentModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.employee, employee) ||
                other.employee == employee) &&
            (identical(other.employeeName, employeeName) ||
                other.employeeName == employeeName) &&
            (identical(other.cycle, cycle) || other.cycle == cycle) &&
            (identical(other.goal, goal) || other.goal == goal) &&
            (identical(other.submissionDate, submissionDate) ||
                other.submissionDate == submissionDate) &&
            (identical(other.modified, modified) ||
                other.modified == modified) &&
            const DeepCollectionEquality().equals(
              other._goalReviews,
              _goalReviews,
            ) &&
            const DeepCollectionEquality().equals(other._timeline, _timeline) &&
            const DeepCollectionEquality().equals(
              other._competencyReviews,
              _competencyReviews,
            ) &&
            const DeepCollectionEquality().equals(
              other._attachments,
              _attachments,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    employee,
    employeeName,
    cycle,
    goal,
    submissionDate,
    modified,
    const DeepCollectionEquality().hash(_goalReviews),
    const DeepCollectionEquality().hash(_timeline),
    const DeepCollectionEquality().hash(_competencyReviews),
    const DeepCollectionEquality().hash(_attachments),
  );

  /// Create a copy of SelfAssessmentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelfAssessmentModelImplCopyWith<_$SelfAssessmentModelImpl> get copyWith =>
      __$$SelfAssessmentModelImplCopyWithImpl<_$SelfAssessmentModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SelfAssessmentModelImplToJson(this);
  }
}

abstract class _SelfAssessmentModel extends SelfAssessmentModel {
  const factory _SelfAssessmentModel({
    required final String name,
    required final String employee,
    @JsonKey(name: 'employee_name') final String employeeName,
    required final String cycle,
    final String goal,
    @JsonKey(name: 'submission_date') final DateTime? submissionDate,
    required final DateTime modified,
    @JsonKey(name: 'goal_ratings', readValue: _readGoalsList)
    final List<GoalReviewModel> goalReviews,
    final List<TimelineStageModel> timeline,
    @JsonKey(name: 'competency_ratings', readValue: _readCompetenciesList)
    final List<CompetencyReviewModel> competencyReviews,
    final List<FileAttachmentModel> attachments,
  }) = _$SelfAssessmentModelImpl;
  const _SelfAssessmentModel._() : super._();

  factory _SelfAssessmentModel.fromJson(Map<String, dynamic> json) =
      _$SelfAssessmentModelImpl.fromJson;

  @override
  String get name;
  @override
  String get employee;
  @override
  @JsonKey(name: 'employee_name')
  String get employeeName;
  @override
  String get cycle;
  @override
  String get goal;
  @override
  @JsonKey(name: 'submission_date')
  DateTime? get submissionDate;
  @override
  DateTime get modified;
  @override
  @JsonKey(name: 'goal_ratings', readValue: _readGoalsList)
  List<GoalReviewModel> get goalReviews;
  @override
  List<TimelineStageModel> get timeline;
  @override
  @JsonKey(name: 'competency_ratings', readValue: _readCompetenciesList)
  List<CompetencyReviewModel> get competencyReviews;
  @override
  List<FileAttachmentModel> get attachments;

  /// Create a copy of SelfAssessmentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelfAssessmentModelImplCopyWith<_$SelfAssessmentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FileAttachmentModel _$FileAttachmentModelFromJson(Map<String, dynamic> json) {
  return _FileAttachmentModel.fromJson(json);
}

/// @nodoc
mixin _$FileAttachmentModel {
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'file_name')
  String get fileName => throw _privateConstructorUsedError;
  @JsonKey(name: 'file_url')
  String get fileUrl => throw _privateConstructorUsedError;

  /// Serializes this FileAttachmentModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FileAttachmentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FileAttachmentModelCopyWith<FileAttachmentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FileAttachmentModelCopyWith<$Res> {
  factory $FileAttachmentModelCopyWith(
    FileAttachmentModel value,
    $Res Function(FileAttachmentModel) then,
  ) = _$FileAttachmentModelCopyWithImpl<$Res, FileAttachmentModel>;
  @useResult
  $Res call({
    String name,
    @JsonKey(name: 'file_name') String fileName,
    @JsonKey(name: 'file_url') String fileUrl,
  });
}

/// @nodoc
class _$FileAttachmentModelCopyWithImpl<$Res, $Val extends FileAttachmentModel>
    implements $FileAttachmentModelCopyWith<$Res> {
  _$FileAttachmentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FileAttachmentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? fileName = null,
    Object? fileUrl = null,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            fileName: null == fileName
                ? _value.fileName
                : fileName // ignore: cast_nullable_to_non_nullable
                      as String,
            fileUrl: null == fileUrl
                ? _value.fileUrl
                : fileUrl // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FileAttachmentModelImplCopyWith<$Res>
    implements $FileAttachmentModelCopyWith<$Res> {
  factory _$$FileAttachmentModelImplCopyWith(
    _$FileAttachmentModelImpl value,
    $Res Function(_$FileAttachmentModelImpl) then,
  ) = __$$FileAttachmentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    @JsonKey(name: 'file_name') String fileName,
    @JsonKey(name: 'file_url') String fileUrl,
  });
}

/// @nodoc
class __$$FileAttachmentModelImplCopyWithImpl<$Res>
    extends _$FileAttachmentModelCopyWithImpl<$Res, _$FileAttachmentModelImpl>
    implements _$$FileAttachmentModelImplCopyWith<$Res> {
  __$$FileAttachmentModelImplCopyWithImpl(
    _$FileAttachmentModelImpl _value,
    $Res Function(_$FileAttachmentModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FileAttachmentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? fileName = null,
    Object? fileUrl = null,
  }) {
    return _then(
      _$FileAttachmentModelImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        fileName: null == fileName
            ? _value.fileName
            : fileName // ignore: cast_nullable_to_non_nullable
                  as String,
        fileUrl: null == fileUrl
            ? _value.fileUrl
            : fileUrl // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FileAttachmentModelImpl extends _FileAttachmentModel {
  const _$FileAttachmentModelImpl({
    required this.name,
    @JsonKey(name: 'file_name') required this.fileName,
    @JsonKey(name: 'file_url') required this.fileUrl,
  }) : super._();

  factory _$FileAttachmentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FileAttachmentModelImplFromJson(json);

  @override
  final String name;
  @override
  @JsonKey(name: 'file_name')
  final String fileName;
  @override
  @JsonKey(name: 'file_url')
  final String fileUrl;

  @override
  String toString() {
    return 'FileAttachmentModel(name: $name, fileName: $fileName, fileUrl: $fileUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FileAttachmentModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, fileName, fileUrl);

  /// Create a copy of FileAttachmentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FileAttachmentModelImplCopyWith<_$FileAttachmentModelImpl> get copyWith =>
      __$$FileAttachmentModelImplCopyWithImpl<_$FileAttachmentModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FileAttachmentModelImplToJson(this);
  }
}

abstract class _FileAttachmentModel extends FileAttachmentModel {
  const factory _FileAttachmentModel({
    required final String name,
    @JsonKey(name: 'file_name') required final String fileName,
    @JsonKey(name: 'file_url') required final String fileUrl,
  }) = _$FileAttachmentModelImpl;
  const _FileAttachmentModel._() : super._();

  factory _FileAttachmentModel.fromJson(Map<String, dynamic> json) =
      _$FileAttachmentModelImpl.fromJson;

  @override
  String get name;
  @override
  @JsonKey(name: 'file_name')
  String get fileName;
  @override
  @JsonKey(name: 'file_url')
  String get fileUrl;

  /// Create a copy of FileAttachmentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FileAttachmentModelImplCopyWith<_$FileAttachmentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GoalReviewModel _$GoalReviewModelFromJson(Map<String, dynamic> json) {
  return _GoalReviewModel.fromJson(json);
}

/// @nodoc
mixin _$GoalReviewModel {
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'goal', readValue: _readGoalName)
  String get goal => throw _privateConstructorUsedError;
  @JsonKey(name: 'kras')
  String get kras => throw _privateConstructorUsedError;
  double get weightage => throw _privateConstructorUsedError;
  double get target => throw _privateConstructorUsedError;
  double get progress => throw _privateConstructorUsedError;
  @JsonKey(name: 'self_rating')
  String get selfRating => throw _privateConstructorUsedError;
  @JsonKey(name: 'self_comment')
  String get selfComment => throw _privateConstructorUsedError;
  @JsonKey(name: 'manager_rating')
  String get managerRating => throw _privateConstructorUsedError;
  @JsonKey(name: 'manager_percentage')
  double get managerPercentage => throw _privateConstructorUsedError;
  @JsonKey(name: 'manager_comment')
  String get managerComment => throw _privateConstructorUsedError;
  @JsonKey(name: 'employee_comment')
  String get employeeComment => throw _privateConstructorUsedError;
  double get achieved => throw _privateConstructorUsedError;
  @JsonKey(name: 'weighted_score')
  double get weightedScore => throw _privateConstructorUsedError;
  DateTime get modified => throw _privateConstructorUsedError;

  /// Serializes this GoalReviewModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GoalReviewModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GoalReviewModelCopyWith<GoalReviewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoalReviewModelCopyWith<$Res> {
  factory $GoalReviewModelCopyWith(
    GoalReviewModel value,
    $Res Function(GoalReviewModel) then,
  ) = _$GoalReviewModelCopyWithImpl<$Res, GoalReviewModel>;
  @useResult
  $Res call({
    String name,
    @JsonKey(name: 'goal', readValue: _readGoalName) String goal,
    @JsonKey(name: 'kras') String kras,
    double weightage,
    double target,
    double progress,
    @JsonKey(name: 'self_rating') String selfRating,
    @JsonKey(name: 'self_comment') String selfComment,
    @JsonKey(name: 'manager_rating') String managerRating,
    @JsonKey(name: 'manager_percentage') double managerPercentage,
    @JsonKey(name: 'manager_comment') String managerComment,
    @JsonKey(name: 'employee_comment') String employeeComment,
    double achieved,
    @JsonKey(name: 'weighted_score') double weightedScore,
    DateTime modified,
  });
}

/// @nodoc
class _$GoalReviewModelCopyWithImpl<$Res, $Val extends GoalReviewModel>
    implements $GoalReviewModelCopyWith<$Res> {
  _$GoalReviewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GoalReviewModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? goal = null,
    Object? kras = null,
    Object? weightage = null,
    Object? target = null,
    Object? progress = null,
    Object? selfRating = null,
    Object? selfComment = null,
    Object? managerRating = null,
    Object? managerPercentage = null,
    Object? managerComment = null,
    Object? employeeComment = null,
    Object? achieved = null,
    Object? weightedScore = null,
    Object? modified = null,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            goal: null == goal
                ? _value.goal
                : goal // ignore: cast_nullable_to_non_nullable
                      as String,
            kras: null == kras
                ? _value.kras
                : kras // ignore: cast_nullable_to_non_nullable
                      as String,
            weightage: null == weightage
                ? _value.weightage
                : weightage // ignore: cast_nullable_to_non_nullable
                      as double,
            target: null == target
                ? _value.target
                : target // ignore: cast_nullable_to_non_nullable
                      as double,
            progress: null == progress
                ? _value.progress
                : progress // ignore: cast_nullable_to_non_nullable
                      as double,
            selfRating: null == selfRating
                ? _value.selfRating
                : selfRating // ignore: cast_nullable_to_non_nullable
                      as String,
            selfComment: null == selfComment
                ? _value.selfComment
                : selfComment // ignore: cast_nullable_to_non_nullable
                      as String,
            managerRating: null == managerRating
                ? _value.managerRating
                : managerRating // ignore: cast_nullable_to_non_nullable
                      as String,
            managerPercentage: null == managerPercentage
                ? _value.managerPercentage
                : managerPercentage // ignore: cast_nullable_to_non_nullable
                      as double,
            managerComment: null == managerComment
                ? _value.managerComment
                : managerComment // ignore: cast_nullable_to_non_nullable
                      as String,
            employeeComment: null == employeeComment
                ? _value.employeeComment
                : employeeComment // ignore: cast_nullable_to_non_nullable
                      as String,
            achieved: null == achieved
                ? _value.achieved
                : achieved // ignore: cast_nullable_to_non_nullable
                      as double,
            weightedScore: null == weightedScore
                ? _value.weightedScore
                : weightedScore // ignore: cast_nullable_to_non_nullable
                      as double,
            modified: null == modified
                ? _value.modified
                : modified // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GoalReviewModelImplCopyWith<$Res>
    implements $GoalReviewModelCopyWith<$Res> {
  factory _$$GoalReviewModelImplCopyWith(
    _$GoalReviewModelImpl value,
    $Res Function(_$GoalReviewModelImpl) then,
  ) = __$$GoalReviewModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    @JsonKey(name: 'goal', readValue: _readGoalName) String goal,
    @JsonKey(name: 'kras') String kras,
    double weightage,
    double target,
    double progress,
    @JsonKey(name: 'self_rating') String selfRating,
    @JsonKey(name: 'self_comment') String selfComment,
    @JsonKey(name: 'manager_rating') String managerRating,
    @JsonKey(name: 'manager_percentage') double managerPercentage,
    @JsonKey(name: 'manager_comment') String managerComment,
    @JsonKey(name: 'employee_comment') String employeeComment,
    double achieved,
    @JsonKey(name: 'weighted_score') double weightedScore,
    DateTime modified,
  });
}

/// @nodoc
class __$$GoalReviewModelImplCopyWithImpl<$Res>
    extends _$GoalReviewModelCopyWithImpl<$Res, _$GoalReviewModelImpl>
    implements _$$GoalReviewModelImplCopyWith<$Res> {
  __$$GoalReviewModelImplCopyWithImpl(
    _$GoalReviewModelImpl _value,
    $Res Function(_$GoalReviewModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GoalReviewModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? goal = null,
    Object? kras = null,
    Object? weightage = null,
    Object? target = null,
    Object? progress = null,
    Object? selfRating = null,
    Object? selfComment = null,
    Object? managerRating = null,
    Object? managerPercentage = null,
    Object? managerComment = null,
    Object? employeeComment = null,
    Object? achieved = null,
    Object? weightedScore = null,
    Object? modified = null,
  }) {
    return _then(
      _$GoalReviewModelImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        goal: null == goal
            ? _value.goal
            : goal // ignore: cast_nullable_to_non_nullable
                  as String,
        kras: null == kras
            ? _value.kras
            : kras // ignore: cast_nullable_to_non_nullable
                  as String,
        weightage: null == weightage
            ? _value.weightage
            : weightage // ignore: cast_nullable_to_non_nullable
                  as double,
        target: null == target
            ? _value.target
            : target // ignore: cast_nullable_to_non_nullable
                  as double,
        progress: null == progress
            ? _value.progress
            : progress // ignore: cast_nullable_to_non_nullable
                  as double,
        selfRating: null == selfRating
            ? _value.selfRating
            : selfRating // ignore: cast_nullable_to_non_nullable
                  as String,
        selfComment: null == selfComment
            ? _value.selfComment
            : selfComment // ignore: cast_nullable_to_non_nullable
                  as String,
        managerRating: null == managerRating
            ? _value.managerRating
            : managerRating // ignore: cast_nullable_to_non_nullable
                  as String,
        managerPercentage: null == managerPercentage
            ? _value.managerPercentage
            : managerPercentage // ignore: cast_nullable_to_non_nullable
                  as double,
        managerComment: null == managerComment
            ? _value.managerComment
            : managerComment // ignore: cast_nullable_to_non_nullable
                  as String,
        employeeComment: null == employeeComment
            ? _value.employeeComment
            : employeeComment // ignore: cast_nullable_to_non_nullable
                  as String,
        achieved: null == achieved
            ? _value.achieved
            : achieved // ignore: cast_nullable_to_non_nullable
                  as double,
        weightedScore: null == weightedScore
            ? _value.weightedScore
            : weightedScore // ignore: cast_nullable_to_non_nullable
                  as double,
        modified: null == modified
            ? _value.modified
            : modified // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GoalReviewModelImpl extends _GoalReviewModel {
  const _$GoalReviewModelImpl({
    required this.name,
    @JsonKey(name: 'goal', readValue: _readGoalName) this.goal = '',
    @JsonKey(name: 'kras') this.kras = '',
    this.weightage = 0.0,
    this.target = 0.0,
    this.progress = 0.0,
    @JsonKey(name: 'self_rating') this.selfRating = '',
    @JsonKey(name: 'self_comment') this.selfComment = '',
    @JsonKey(name: 'manager_rating') this.managerRating = '',
    @JsonKey(name: 'manager_percentage') this.managerPercentage = 0.0,
    @JsonKey(name: 'manager_comment') this.managerComment = '',
    @JsonKey(name: 'employee_comment') this.employeeComment = '',
    this.achieved = 0.0,
    @JsonKey(name: 'weighted_score') this.weightedScore = 0.0,
    required this.modified,
  }) : super._();

  factory _$GoalReviewModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GoalReviewModelImplFromJson(json);

  @override
  final String name;
  @override
  @JsonKey(name: 'goal', readValue: _readGoalName)
  final String goal;
  @override
  @JsonKey(name: 'kras')
  final String kras;
  @override
  @JsonKey()
  final double weightage;
  @override
  @JsonKey()
  final double target;
  @override
  @JsonKey()
  final double progress;
  @override
  @JsonKey(name: 'self_rating')
  final String selfRating;
  @override
  @JsonKey(name: 'self_comment')
  final String selfComment;
  @override
  @JsonKey(name: 'manager_rating')
  final String managerRating;
  @override
  @JsonKey(name: 'manager_percentage')
  final double managerPercentage;
  @override
  @JsonKey(name: 'manager_comment')
  final String managerComment;
  @override
  @JsonKey(name: 'employee_comment')
  final String employeeComment;
  @override
  @JsonKey()
  final double achieved;
  @override
  @JsonKey(name: 'weighted_score')
  final double weightedScore;
  @override
  final DateTime modified;

  @override
  String toString() {
    return 'GoalReviewModel(name: $name, goal: $goal, kras: $kras, weightage: $weightage, target: $target, progress: $progress, selfRating: $selfRating, selfComment: $selfComment, managerRating: $managerRating, managerPercentage: $managerPercentage, managerComment: $managerComment, employeeComment: $employeeComment, achieved: $achieved, weightedScore: $weightedScore, modified: $modified)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoalReviewModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.goal, goal) || other.goal == goal) &&
            (identical(other.kras, kras) || other.kras == kras) &&
            (identical(other.weightage, weightage) ||
                other.weightage == weightage) &&
            (identical(other.target, target) || other.target == target) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.selfRating, selfRating) ||
                other.selfRating == selfRating) &&
            (identical(other.selfComment, selfComment) ||
                other.selfComment == selfComment) &&
            (identical(other.managerRating, managerRating) ||
                other.managerRating == managerRating) &&
            (identical(other.managerPercentage, managerPercentage) ||
                other.managerPercentage == managerPercentage) &&
            (identical(other.managerComment, managerComment) ||
                other.managerComment == managerComment) &&
            (identical(other.employeeComment, employeeComment) ||
                other.employeeComment == employeeComment) &&
            (identical(other.achieved, achieved) ||
                other.achieved == achieved) &&
            (identical(other.weightedScore, weightedScore) ||
                other.weightedScore == weightedScore) &&
            (identical(other.modified, modified) ||
                other.modified == modified));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    goal,
    kras,
    weightage,
    target,
    progress,
    selfRating,
    selfComment,
    managerRating,
    managerPercentage,
    managerComment,
    employeeComment,
    achieved,
    weightedScore,
    modified,
  );

  /// Create a copy of GoalReviewModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GoalReviewModelImplCopyWith<_$GoalReviewModelImpl> get copyWith =>
      __$$GoalReviewModelImplCopyWithImpl<_$GoalReviewModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GoalReviewModelImplToJson(this);
  }
}

abstract class _GoalReviewModel extends GoalReviewModel {
  const factory _GoalReviewModel({
    required final String name,
    @JsonKey(name: 'goal', readValue: _readGoalName) final String goal,
    @JsonKey(name: 'kras') final String kras,
    final double weightage,
    final double target,
    final double progress,
    @JsonKey(name: 'self_rating') final String selfRating,
    @JsonKey(name: 'self_comment') final String selfComment,
    @JsonKey(name: 'manager_rating') final String managerRating,
    @JsonKey(name: 'manager_percentage') final double managerPercentage,
    @JsonKey(name: 'manager_comment') final String managerComment,
    @JsonKey(name: 'employee_comment') final String employeeComment,
    final double achieved,
    @JsonKey(name: 'weighted_score') final double weightedScore,
    required final DateTime modified,
  }) = _$GoalReviewModelImpl;
  const _GoalReviewModel._() : super._();

  factory _GoalReviewModel.fromJson(Map<String, dynamic> json) =
      _$GoalReviewModelImpl.fromJson;

  @override
  String get name;
  @override
  @JsonKey(name: 'goal', readValue: _readGoalName)
  String get goal;
  @override
  @JsonKey(name: 'kras')
  String get kras;
  @override
  double get weightage;
  @override
  double get target;
  @override
  double get progress;
  @override
  @JsonKey(name: 'self_rating')
  String get selfRating;
  @override
  @JsonKey(name: 'self_comment')
  String get selfComment;
  @override
  @JsonKey(name: 'manager_rating')
  String get managerRating;
  @override
  @JsonKey(name: 'manager_percentage')
  double get managerPercentage;
  @override
  @JsonKey(name: 'manager_comment')
  String get managerComment;
  @override
  @JsonKey(name: 'employee_comment')
  String get employeeComment;
  @override
  double get achieved;
  @override
  @JsonKey(name: 'weighted_score')
  double get weightedScore;
  @override
  DateTime get modified;

  /// Create a copy of GoalReviewModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoalReviewModelImplCopyWith<_$GoalReviewModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TimelineStageModel _$TimelineStageModelFromJson(Map<String, dynamic> json) {
  return _TimelineStageModel.fromJson(json);
}

/// @nodoc
mixin _$TimelineStageModel {
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'stage_name')
  String get stageName => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'stauts')
  String get status => throw _privateConstructorUsedError;

  /// Serializes this TimelineStageModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TimelineStageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimelineStageModelCopyWith<TimelineStageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimelineStageModelCopyWith<$Res> {
  factory $TimelineStageModelCopyWith(
    TimelineStageModel value,
    $Res Function(TimelineStageModel) then,
  ) = _$TimelineStageModelCopyWithImpl<$Res, TimelineStageModel>;
  @useResult
  $Res call({
    String name,
    @JsonKey(name: 'stage_name') String stageName,
    DateTime date,
    @JsonKey(name: 'stauts') String status,
  });
}

/// @nodoc
class _$TimelineStageModelCopyWithImpl<$Res, $Val extends TimelineStageModel>
    implements $TimelineStageModelCopyWith<$Res> {
  _$TimelineStageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimelineStageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? stageName = null,
    Object? date = null,
    Object? status = null,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            stageName: null == stageName
                ? _value.stageName
                : stageName // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TimelineStageModelImplCopyWith<$Res>
    implements $TimelineStageModelCopyWith<$Res> {
  factory _$$TimelineStageModelImplCopyWith(
    _$TimelineStageModelImpl value,
    $Res Function(_$TimelineStageModelImpl) then,
  ) = __$$TimelineStageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    @JsonKey(name: 'stage_name') String stageName,
    DateTime date,
    @JsonKey(name: 'stauts') String status,
  });
}

/// @nodoc
class __$$TimelineStageModelImplCopyWithImpl<$Res>
    extends _$TimelineStageModelCopyWithImpl<$Res, _$TimelineStageModelImpl>
    implements _$$TimelineStageModelImplCopyWith<$Res> {
  __$$TimelineStageModelImplCopyWithImpl(
    _$TimelineStageModelImpl _value,
    $Res Function(_$TimelineStageModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TimelineStageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? stageName = null,
    Object? date = null,
    Object? status = null,
  }) {
    return _then(
      _$TimelineStageModelImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        stageName: null == stageName
            ? _value.stageName
            : stageName // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TimelineStageModelImpl extends _TimelineStageModel {
  const _$TimelineStageModelImpl({
    required this.name,
    @JsonKey(name: 'stage_name') this.stageName = '',
    required this.date,
    @JsonKey(name: 'stauts') this.status = '',
  }) : super._();

  factory _$TimelineStageModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimelineStageModelImplFromJson(json);

  @override
  final String name;
  @override
  @JsonKey(name: 'stage_name')
  final String stageName;
  @override
  final DateTime date;
  @override
  @JsonKey(name: 'stauts')
  final String status;

  @override
  String toString() {
    return 'TimelineStageModel(name: $name, stageName: $stageName, date: $date, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimelineStageModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.stageName, stageName) ||
                other.stageName == stageName) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, stageName, date, status);

  /// Create a copy of TimelineStageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimelineStageModelImplCopyWith<_$TimelineStageModelImpl> get copyWith =>
      __$$TimelineStageModelImplCopyWithImpl<_$TimelineStageModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TimelineStageModelImplToJson(this);
  }
}

abstract class _TimelineStageModel extends TimelineStageModel {
  const factory _TimelineStageModel({
    required final String name,
    @JsonKey(name: 'stage_name') final String stageName,
    required final DateTime date,
    @JsonKey(name: 'stauts') final String status,
  }) = _$TimelineStageModelImpl;
  const _TimelineStageModel._() : super._();

  factory _TimelineStageModel.fromJson(Map<String, dynamic> json) =
      _$TimelineStageModelImpl.fromJson;

  @override
  String get name;
  @override
  @JsonKey(name: 'stage_name')
  String get stageName;
  @override
  DateTime get date;
  @override
  @JsonKey(name: 'stauts')
  String get status;

  /// Create a copy of TimelineStageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimelineStageModelImplCopyWith<_$TimelineStageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CompetencyReviewModel _$CompetencyReviewModelFromJson(
  Map<String, dynamic> json,
) {
  return _CompetencyReviewModel.fromJson(json);
}

/// @nodoc
mixin _$CompetencyReviewModel {
  String get name => throw _privateConstructorUsedError;
  String get competency => throw _privateConstructorUsedError;

  /// Serializes this CompetencyReviewModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CompetencyReviewModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompetencyReviewModelCopyWith<CompetencyReviewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompetencyReviewModelCopyWith<$Res> {
  factory $CompetencyReviewModelCopyWith(
    CompetencyReviewModel value,
    $Res Function(CompetencyReviewModel) then,
  ) = _$CompetencyReviewModelCopyWithImpl<$Res, CompetencyReviewModel>;
  @useResult
  $Res call({String name, String competency});
}

/// @nodoc
class _$CompetencyReviewModelCopyWithImpl<
  $Res,
  $Val extends CompetencyReviewModel
>
    implements $CompetencyReviewModelCopyWith<$Res> {
  _$CompetencyReviewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CompetencyReviewModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? competency = null}) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            competency: null == competency
                ? _value.competency
                : competency // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CompetencyReviewModelImplCopyWith<$Res>
    implements $CompetencyReviewModelCopyWith<$Res> {
  factory _$$CompetencyReviewModelImplCopyWith(
    _$CompetencyReviewModelImpl value,
    $Res Function(_$CompetencyReviewModelImpl) then,
  ) = __$$CompetencyReviewModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String competency});
}

/// @nodoc
class __$$CompetencyReviewModelImplCopyWithImpl<$Res>
    extends
        _$CompetencyReviewModelCopyWithImpl<$Res, _$CompetencyReviewModelImpl>
    implements _$$CompetencyReviewModelImplCopyWith<$Res> {
  __$$CompetencyReviewModelImplCopyWithImpl(
    _$CompetencyReviewModelImpl _value,
    $Res Function(_$CompetencyReviewModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CompetencyReviewModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? competency = null}) {
    return _then(
      _$CompetencyReviewModelImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        competency: null == competency
            ? _value.competency
            : competency // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CompetencyReviewModelImpl extends _CompetencyReviewModel {
  const _$CompetencyReviewModelImpl({
    required this.name,
    required this.competency,
  }) : super._();

  factory _$CompetencyReviewModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompetencyReviewModelImplFromJson(json);

  @override
  final String name;
  @override
  final String competency;

  @override
  String toString() {
    return 'CompetencyReviewModel(name: $name, competency: $competency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompetencyReviewModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.competency, competency) ||
                other.competency == competency));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, competency);

  /// Create a copy of CompetencyReviewModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompetencyReviewModelImplCopyWith<_$CompetencyReviewModelImpl>
  get copyWith =>
      __$$CompetencyReviewModelImplCopyWithImpl<_$CompetencyReviewModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CompetencyReviewModelImplToJson(this);
  }
}

abstract class _CompetencyReviewModel extends CompetencyReviewModel {
  const factory _CompetencyReviewModel({
    required final String name,
    required final String competency,
  }) = _$CompetencyReviewModelImpl;
  const _CompetencyReviewModel._() : super._();

  factory _CompetencyReviewModel.fromJson(Map<String, dynamic> json) =
      _$CompetencyReviewModelImpl.fromJson;

  @override
  String get name;
  @override
  String get competency;

  /// Create a copy of CompetencyReviewModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompetencyReviewModelImplCopyWith<_$CompetencyReviewModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
