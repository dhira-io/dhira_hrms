// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'self_assessment_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SelfAssessmentEntity {
  String get name => throw _privateConstructorUsedError;
  String get employee => throw _privateConstructorUsedError;
  String get employeeName => throw _privateConstructorUsedError;
  String get cycle => throw _privateConstructorUsedError;
  String get goal => throw _privateConstructorUsedError;
  DateTime get submissionDate => throw _privateConstructorUsedError;
  DateTime get modified => throw _privateConstructorUsedError;
  List<GoalReviewEntity> get goalReviews => throw _privateConstructorUsedError;
  List<TimelineStageEntity> get timeline => throw _privateConstructorUsedError;
  List<CompetencyReviewEntity> get competencyReviews =>
      throw _privateConstructorUsedError;
  List<FileAttachmentEntity> get attachments =>
      throw _privateConstructorUsedError;

  /// Create a copy of SelfAssessmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SelfAssessmentEntityCopyWith<SelfAssessmentEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelfAssessmentEntityCopyWith<$Res> {
  factory $SelfAssessmentEntityCopyWith(
    SelfAssessmentEntity value,
    $Res Function(SelfAssessmentEntity) then,
  ) = _$SelfAssessmentEntityCopyWithImpl<$Res, SelfAssessmentEntity>;
  @useResult
  $Res call({
    String name,
    String employee,
    String employeeName,
    String cycle,
    String goal,
    DateTime submissionDate,
    DateTime modified,
    List<GoalReviewEntity> goalReviews,
    List<TimelineStageEntity> timeline,
    List<CompetencyReviewEntity> competencyReviews,
    List<FileAttachmentEntity> attachments,
  });
}

/// @nodoc
class _$SelfAssessmentEntityCopyWithImpl<
  $Res,
  $Val extends SelfAssessmentEntity
>
    implements $SelfAssessmentEntityCopyWith<$Res> {
  _$SelfAssessmentEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SelfAssessmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? employee = null,
    Object? employeeName = null,
    Object? cycle = null,
    Object? goal = null,
    Object? submissionDate = null,
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
            submissionDate: null == submissionDate
                ? _value.submissionDate
                : submissionDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            modified: null == modified
                ? _value.modified
                : modified // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            goalReviews: null == goalReviews
                ? _value.goalReviews
                : goalReviews // ignore: cast_nullable_to_non_nullable
                      as List<GoalReviewEntity>,
            timeline: null == timeline
                ? _value.timeline
                : timeline // ignore: cast_nullable_to_non_nullable
                      as List<TimelineStageEntity>,
            competencyReviews: null == competencyReviews
                ? _value.competencyReviews
                : competencyReviews // ignore: cast_nullable_to_non_nullable
                      as List<CompetencyReviewEntity>,
            attachments: null == attachments
                ? _value.attachments
                : attachments // ignore: cast_nullable_to_non_nullable
                      as List<FileAttachmentEntity>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SelfAssessmentEntityImplCopyWith<$Res>
    implements $SelfAssessmentEntityCopyWith<$Res> {
  factory _$$SelfAssessmentEntityImplCopyWith(
    _$SelfAssessmentEntityImpl value,
    $Res Function(_$SelfAssessmentEntityImpl) then,
  ) = __$$SelfAssessmentEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String employee,
    String employeeName,
    String cycle,
    String goal,
    DateTime submissionDate,
    DateTime modified,
    List<GoalReviewEntity> goalReviews,
    List<TimelineStageEntity> timeline,
    List<CompetencyReviewEntity> competencyReviews,
    List<FileAttachmentEntity> attachments,
  });
}

/// @nodoc
class __$$SelfAssessmentEntityImplCopyWithImpl<$Res>
    extends _$SelfAssessmentEntityCopyWithImpl<$Res, _$SelfAssessmentEntityImpl>
    implements _$$SelfAssessmentEntityImplCopyWith<$Res> {
  __$$SelfAssessmentEntityImplCopyWithImpl(
    _$SelfAssessmentEntityImpl _value,
    $Res Function(_$SelfAssessmentEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SelfAssessmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? employee = null,
    Object? employeeName = null,
    Object? cycle = null,
    Object? goal = null,
    Object? submissionDate = null,
    Object? modified = null,
    Object? goalReviews = null,
    Object? timeline = null,
    Object? competencyReviews = null,
    Object? attachments = null,
  }) {
    return _then(
      _$SelfAssessmentEntityImpl(
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
        submissionDate: null == submissionDate
            ? _value.submissionDate
            : submissionDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        modified: null == modified
            ? _value.modified
            : modified // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        goalReviews: null == goalReviews
            ? _value._goalReviews
            : goalReviews // ignore: cast_nullable_to_non_nullable
                  as List<GoalReviewEntity>,
        timeline: null == timeline
            ? _value._timeline
            : timeline // ignore: cast_nullable_to_non_nullable
                  as List<TimelineStageEntity>,
        competencyReviews: null == competencyReviews
            ? _value._competencyReviews
            : competencyReviews // ignore: cast_nullable_to_non_nullable
                  as List<CompetencyReviewEntity>,
        attachments: null == attachments
            ? _value._attachments
            : attachments // ignore: cast_nullable_to_non_nullable
                  as List<FileAttachmentEntity>,
      ),
    );
  }
}

/// @nodoc

class _$SelfAssessmentEntityImpl implements _SelfAssessmentEntity {
  const _$SelfAssessmentEntityImpl({
    required this.name,
    required this.employee,
    required this.employeeName,
    required this.cycle,
    required this.goal,
    required this.submissionDate,
    required this.modified,
    required final List<GoalReviewEntity> goalReviews,
    required final List<TimelineStageEntity> timeline,
    required final List<CompetencyReviewEntity> competencyReviews,
    final List<FileAttachmentEntity> attachments = const [],
  }) : _goalReviews = goalReviews,
       _timeline = timeline,
       _competencyReviews = competencyReviews,
       _attachments = attachments;

  @override
  final String name;
  @override
  final String employee;
  @override
  final String employeeName;
  @override
  final String cycle;
  @override
  final String goal;
  @override
  final DateTime submissionDate;
  @override
  final DateTime modified;
  final List<GoalReviewEntity> _goalReviews;
  @override
  List<GoalReviewEntity> get goalReviews {
    if (_goalReviews is EqualUnmodifiableListView) return _goalReviews;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_goalReviews);
  }

  final List<TimelineStageEntity> _timeline;
  @override
  List<TimelineStageEntity> get timeline {
    if (_timeline is EqualUnmodifiableListView) return _timeline;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timeline);
  }

  final List<CompetencyReviewEntity> _competencyReviews;
  @override
  List<CompetencyReviewEntity> get competencyReviews {
    if (_competencyReviews is EqualUnmodifiableListView)
      return _competencyReviews;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_competencyReviews);
  }

  final List<FileAttachmentEntity> _attachments;
  @override
  @JsonKey()
  List<FileAttachmentEntity> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

  @override
  String toString() {
    return 'SelfAssessmentEntity(name: $name, employee: $employee, employeeName: $employeeName, cycle: $cycle, goal: $goal, submissionDate: $submissionDate, modified: $modified, goalReviews: $goalReviews, timeline: $timeline, competencyReviews: $competencyReviews, attachments: $attachments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelfAssessmentEntityImpl &&
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

  /// Create a copy of SelfAssessmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelfAssessmentEntityImplCopyWith<_$SelfAssessmentEntityImpl>
  get copyWith =>
      __$$SelfAssessmentEntityImplCopyWithImpl<_$SelfAssessmentEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _SelfAssessmentEntity implements SelfAssessmentEntity {
  const factory _SelfAssessmentEntity({
    required final String name,
    required final String employee,
    required final String employeeName,
    required final String cycle,
    required final String goal,
    required final DateTime submissionDate,
    required final DateTime modified,
    required final List<GoalReviewEntity> goalReviews,
    required final List<TimelineStageEntity> timeline,
    required final List<CompetencyReviewEntity> competencyReviews,
    final List<FileAttachmentEntity> attachments,
  }) = _$SelfAssessmentEntityImpl;

  @override
  String get name;
  @override
  String get employee;
  @override
  String get employeeName;
  @override
  String get cycle;
  @override
  String get goal;
  @override
  DateTime get submissionDate;
  @override
  DateTime get modified;
  @override
  List<GoalReviewEntity> get goalReviews;
  @override
  List<TimelineStageEntity> get timeline;
  @override
  List<CompetencyReviewEntity> get competencyReviews;
  @override
  List<FileAttachmentEntity> get attachments;

  /// Create a copy of SelfAssessmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelfAssessmentEntityImplCopyWith<_$SelfAssessmentEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FileAttachmentEntity {
  String get name => throw _privateConstructorUsedError;
  String get fileName => throw _privateConstructorUsedError;
  String get fileUrl => throw _privateConstructorUsedError;

  /// Create a copy of FileAttachmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FileAttachmentEntityCopyWith<FileAttachmentEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FileAttachmentEntityCopyWith<$Res> {
  factory $FileAttachmentEntityCopyWith(
    FileAttachmentEntity value,
    $Res Function(FileAttachmentEntity) then,
  ) = _$FileAttachmentEntityCopyWithImpl<$Res, FileAttachmentEntity>;
  @useResult
  $Res call({String name, String fileName, String fileUrl});
}

/// @nodoc
class _$FileAttachmentEntityCopyWithImpl<
  $Res,
  $Val extends FileAttachmentEntity
>
    implements $FileAttachmentEntityCopyWith<$Res> {
  _$FileAttachmentEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FileAttachmentEntity
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
abstract class _$$FileAttachmentEntityImplCopyWith<$Res>
    implements $FileAttachmentEntityCopyWith<$Res> {
  factory _$$FileAttachmentEntityImplCopyWith(
    _$FileAttachmentEntityImpl value,
    $Res Function(_$FileAttachmentEntityImpl) then,
  ) = __$$FileAttachmentEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String fileName, String fileUrl});
}

/// @nodoc
class __$$FileAttachmentEntityImplCopyWithImpl<$Res>
    extends _$FileAttachmentEntityCopyWithImpl<$Res, _$FileAttachmentEntityImpl>
    implements _$$FileAttachmentEntityImplCopyWith<$Res> {
  __$$FileAttachmentEntityImplCopyWithImpl(
    _$FileAttachmentEntityImpl _value,
    $Res Function(_$FileAttachmentEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FileAttachmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? fileName = null,
    Object? fileUrl = null,
  }) {
    return _then(
      _$FileAttachmentEntityImpl(
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

class _$FileAttachmentEntityImpl implements _FileAttachmentEntity {
  const _$FileAttachmentEntityImpl({
    required this.name,
    required this.fileName,
    required this.fileUrl,
  });

  @override
  final String name;
  @override
  final String fileName;
  @override
  final String fileUrl;

  @override
  String toString() {
    return 'FileAttachmentEntity(name: $name, fileName: $fileName, fileUrl: $fileUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FileAttachmentEntityImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, fileName, fileUrl);

  /// Create a copy of FileAttachmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FileAttachmentEntityImplCopyWith<_$FileAttachmentEntityImpl>
  get copyWith =>
      __$$FileAttachmentEntityImplCopyWithImpl<_$FileAttachmentEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _FileAttachmentEntity implements FileAttachmentEntity {
  const factory _FileAttachmentEntity({
    required final String name,
    required final String fileName,
    required final String fileUrl,
  }) = _$FileAttachmentEntityImpl;

  @override
  String get name;
  @override
  String get fileName;
  @override
  String get fileUrl;

  /// Create a copy of FileAttachmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FileAttachmentEntityImplCopyWith<_$FileAttachmentEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GoalReviewEntity {
  String get name => throw _privateConstructorUsedError;
  String get goal => throw _privateConstructorUsedError;
  String get kras => throw _privateConstructorUsedError;
  double get weightage => throw _privateConstructorUsedError;
  double get target => throw _privateConstructorUsedError;
  double get progress => throw _privateConstructorUsedError;
  String get selfRating => throw _privateConstructorUsedError;
  String get selfComment => throw _privateConstructorUsedError;
  String get managerRating => throw _privateConstructorUsedError;
  double get managerPercentage => throw _privateConstructorUsedError;
  String get managerComment => throw _privateConstructorUsedError;
  String get employeeComment => throw _privateConstructorUsedError;
  double get achieved => throw _privateConstructorUsedError;
  double get weightedScore => throw _privateConstructorUsedError;
  DateTime get modified => throw _privateConstructorUsedError;

  /// Create a copy of GoalReviewEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GoalReviewEntityCopyWith<GoalReviewEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoalReviewEntityCopyWith<$Res> {
  factory $GoalReviewEntityCopyWith(
    GoalReviewEntity value,
    $Res Function(GoalReviewEntity) then,
  ) = _$GoalReviewEntityCopyWithImpl<$Res, GoalReviewEntity>;
  @useResult
  $Res call({
    String name,
    String goal,
    String kras,
    double weightage,
    double target,
    double progress,
    String selfRating,
    String selfComment,
    String managerRating,
    double managerPercentage,
    String managerComment,
    String employeeComment,
    double achieved,
    double weightedScore,
    DateTime modified,
  });
}

/// @nodoc
class _$GoalReviewEntityCopyWithImpl<$Res, $Val extends GoalReviewEntity>
    implements $GoalReviewEntityCopyWith<$Res> {
  _$GoalReviewEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GoalReviewEntity
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
abstract class _$$GoalReviewEntityImplCopyWith<$Res>
    implements $GoalReviewEntityCopyWith<$Res> {
  factory _$$GoalReviewEntityImplCopyWith(
    _$GoalReviewEntityImpl value,
    $Res Function(_$GoalReviewEntityImpl) then,
  ) = __$$GoalReviewEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String goal,
    String kras,
    double weightage,
    double target,
    double progress,
    String selfRating,
    String selfComment,
    String managerRating,
    double managerPercentage,
    String managerComment,
    String employeeComment,
    double achieved,
    double weightedScore,
    DateTime modified,
  });
}

/// @nodoc
class __$$GoalReviewEntityImplCopyWithImpl<$Res>
    extends _$GoalReviewEntityCopyWithImpl<$Res, _$GoalReviewEntityImpl>
    implements _$$GoalReviewEntityImplCopyWith<$Res> {
  __$$GoalReviewEntityImplCopyWithImpl(
    _$GoalReviewEntityImpl _value,
    $Res Function(_$GoalReviewEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GoalReviewEntity
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
      _$GoalReviewEntityImpl(
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

class _$GoalReviewEntityImpl implements _GoalReviewEntity {
  const _$GoalReviewEntityImpl({
    required this.name,
    required this.goal,
    required this.kras,
    required this.weightage,
    required this.target,
    required this.progress,
    required this.selfRating,
    required this.selfComment,
    required this.managerRating,
    required this.managerPercentage,
    required this.managerComment,
    required this.employeeComment,
    required this.achieved,
    required this.weightedScore,
    required this.modified,
  });

  @override
  final String name;
  @override
  final String goal;
  @override
  final String kras;
  @override
  final double weightage;
  @override
  final double target;
  @override
  final double progress;
  @override
  final String selfRating;
  @override
  final String selfComment;
  @override
  final String managerRating;
  @override
  final double managerPercentage;
  @override
  final String managerComment;
  @override
  final String employeeComment;
  @override
  final double achieved;
  @override
  final double weightedScore;
  @override
  final DateTime modified;

  @override
  String toString() {
    return 'GoalReviewEntity(name: $name, goal: $goal, kras: $kras, weightage: $weightage, target: $target, progress: $progress, selfRating: $selfRating, selfComment: $selfComment, managerRating: $managerRating, managerPercentage: $managerPercentage, managerComment: $managerComment, employeeComment: $employeeComment, achieved: $achieved, weightedScore: $weightedScore, modified: $modified)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoalReviewEntityImpl &&
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

  /// Create a copy of GoalReviewEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GoalReviewEntityImplCopyWith<_$GoalReviewEntityImpl> get copyWith =>
      __$$GoalReviewEntityImplCopyWithImpl<_$GoalReviewEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _GoalReviewEntity implements GoalReviewEntity {
  const factory _GoalReviewEntity({
    required final String name,
    required final String goal,
    required final String kras,
    required final double weightage,
    required final double target,
    required final double progress,
    required final String selfRating,
    required final String selfComment,
    required final String managerRating,
    required final double managerPercentage,
    required final String managerComment,
    required final String employeeComment,
    required final double achieved,
    required final double weightedScore,
    required final DateTime modified,
  }) = _$GoalReviewEntityImpl;

  @override
  String get name;
  @override
  String get goal;
  @override
  String get kras;
  @override
  double get weightage;
  @override
  double get target;
  @override
  double get progress;
  @override
  String get selfRating;
  @override
  String get selfComment;
  @override
  String get managerRating;
  @override
  double get managerPercentage;
  @override
  String get managerComment;
  @override
  String get employeeComment;
  @override
  double get achieved;
  @override
  double get weightedScore;
  @override
  DateTime get modified;

  /// Create a copy of GoalReviewEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoalReviewEntityImplCopyWith<_$GoalReviewEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TimelineStageEntity {
  String get name => throw _privateConstructorUsedError;
  String get stageName => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  /// Create a copy of TimelineStageEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimelineStageEntityCopyWith<TimelineStageEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimelineStageEntityCopyWith<$Res> {
  factory $TimelineStageEntityCopyWith(
    TimelineStageEntity value,
    $Res Function(TimelineStageEntity) then,
  ) = _$TimelineStageEntityCopyWithImpl<$Res, TimelineStageEntity>;
  @useResult
  $Res call({String name, String stageName, DateTime date, String status});
}

/// @nodoc
class _$TimelineStageEntityCopyWithImpl<$Res, $Val extends TimelineStageEntity>
    implements $TimelineStageEntityCopyWith<$Res> {
  _$TimelineStageEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimelineStageEntity
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
abstract class _$$TimelineStageEntityImplCopyWith<$Res>
    implements $TimelineStageEntityCopyWith<$Res> {
  factory _$$TimelineStageEntityImplCopyWith(
    _$TimelineStageEntityImpl value,
    $Res Function(_$TimelineStageEntityImpl) then,
  ) = __$$TimelineStageEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String stageName, DateTime date, String status});
}

/// @nodoc
class __$$TimelineStageEntityImplCopyWithImpl<$Res>
    extends _$TimelineStageEntityCopyWithImpl<$Res, _$TimelineStageEntityImpl>
    implements _$$TimelineStageEntityImplCopyWith<$Res> {
  __$$TimelineStageEntityImplCopyWithImpl(
    _$TimelineStageEntityImpl _value,
    $Res Function(_$TimelineStageEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TimelineStageEntity
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
      _$TimelineStageEntityImpl(
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

class _$TimelineStageEntityImpl implements _TimelineStageEntity {
  const _$TimelineStageEntityImpl({
    required this.name,
    required this.stageName,
    required this.date,
    required this.status,
  });

  @override
  final String name;
  @override
  final String stageName;
  @override
  final DateTime date;
  @override
  final String status;

  @override
  String toString() {
    return 'TimelineStageEntity(name: $name, stageName: $stageName, date: $date, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimelineStageEntityImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.stageName, stageName) ||
                other.stageName == stageName) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, stageName, date, status);

  /// Create a copy of TimelineStageEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimelineStageEntityImplCopyWith<_$TimelineStageEntityImpl> get copyWith =>
      __$$TimelineStageEntityImplCopyWithImpl<_$TimelineStageEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _TimelineStageEntity implements TimelineStageEntity {
  const factory _TimelineStageEntity({
    required final String name,
    required final String stageName,
    required final DateTime date,
    required final String status,
  }) = _$TimelineStageEntityImpl;

  @override
  String get name;
  @override
  String get stageName;
  @override
  DateTime get date;
  @override
  String get status;

  /// Create a copy of TimelineStageEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimelineStageEntityImplCopyWith<_$TimelineStageEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CompetencyReviewEntity {
  String get name => throw _privateConstructorUsedError;
  String get competency => throw _privateConstructorUsedError;

  /// Create a copy of CompetencyReviewEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompetencyReviewEntityCopyWith<CompetencyReviewEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompetencyReviewEntityCopyWith<$Res> {
  factory $CompetencyReviewEntityCopyWith(
    CompetencyReviewEntity value,
    $Res Function(CompetencyReviewEntity) then,
  ) = _$CompetencyReviewEntityCopyWithImpl<$Res, CompetencyReviewEntity>;
  @useResult
  $Res call({String name, String competency});
}

/// @nodoc
class _$CompetencyReviewEntityCopyWithImpl<
  $Res,
  $Val extends CompetencyReviewEntity
>
    implements $CompetencyReviewEntityCopyWith<$Res> {
  _$CompetencyReviewEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CompetencyReviewEntity
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
abstract class _$$CompetencyReviewEntityImplCopyWith<$Res>
    implements $CompetencyReviewEntityCopyWith<$Res> {
  factory _$$CompetencyReviewEntityImplCopyWith(
    _$CompetencyReviewEntityImpl value,
    $Res Function(_$CompetencyReviewEntityImpl) then,
  ) = __$$CompetencyReviewEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String competency});
}

/// @nodoc
class __$$CompetencyReviewEntityImplCopyWithImpl<$Res>
    extends
        _$CompetencyReviewEntityCopyWithImpl<$Res, _$CompetencyReviewEntityImpl>
    implements _$$CompetencyReviewEntityImplCopyWith<$Res> {
  __$$CompetencyReviewEntityImplCopyWithImpl(
    _$CompetencyReviewEntityImpl _value,
    $Res Function(_$CompetencyReviewEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CompetencyReviewEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? competency = null}) {
    return _then(
      _$CompetencyReviewEntityImpl(
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

class _$CompetencyReviewEntityImpl implements _CompetencyReviewEntity {
  const _$CompetencyReviewEntityImpl({
    required this.name,
    required this.competency,
  });

  @override
  final String name;
  @override
  final String competency;

  @override
  String toString() {
    return 'CompetencyReviewEntity(name: $name, competency: $competency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompetencyReviewEntityImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.competency, competency) ||
                other.competency == competency));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, competency);

  /// Create a copy of CompetencyReviewEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompetencyReviewEntityImplCopyWith<_$CompetencyReviewEntityImpl>
  get copyWith =>
      __$$CompetencyReviewEntityImplCopyWithImpl<_$CompetencyReviewEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _CompetencyReviewEntity implements CompetencyReviewEntity {
  const factory _CompetencyReviewEntity({
    required final String name,
    required final String competency,
  }) = _$CompetencyReviewEntityImpl;

  @override
  String get name;
  @override
  String get competency;

  /// Create a copy of CompetencyReviewEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompetencyReviewEntityImplCopyWith<_$CompetencyReviewEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}
