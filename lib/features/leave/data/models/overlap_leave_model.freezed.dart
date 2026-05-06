// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'overlap_leave_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OverlapLeaveModel _$OverlapLeaveModelFromJson(Map<String, dynamic> json) {
  return _OverlapLeaveModel.fromJson(json);
}

/// @nodoc
mixin _$OverlapLeaveModel {
  String get id => throw _privateConstructorUsedError;
  OverlapEmployeeModel get employee => throw _privateConstructorUsedError;
  @JsonKey(name: 'shared_projects')
  List<String>? get sharedProjects => throw _privateConstructorUsedError;
  @JsonKey(name: 'leave_type')
  String get leaveType => throw _privateConstructorUsedError;
  @JsonKey(name: 'from_date')
  String get fromDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'to_date')
  String get toDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'days')
  double get days => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get posting_date => throw _privateConstructorUsedError;
  String? get modified => throw _privateConstructorUsedError;

  /// Serializes this OverlapLeaveModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OverlapLeaveModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OverlapLeaveModelCopyWith<OverlapLeaveModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OverlapLeaveModelCopyWith<$Res> {
  factory $OverlapLeaveModelCopyWith(
    OverlapLeaveModel value,
    $Res Function(OverlapLeaveModel) then,
  ) = _$OverlapLeaveModelCopyWithImpl<$Res, OverlapLeaveModel>;
  @useResult
  $Res call({
    String id,
    OverlapEmployeeModel employee,
    @JsonKey(name: 'shared_projects') List<String>? sharedProjects,
    @JsonKey(name: 'leave_type') String leaveType,
    @JsonKey(name: 'from_date') String fromDate,
    @JsonKey(name: 'to_date') String toDate,
    @JsonKey(name: 'days') double days,
    String status,
    String? description,
    String? posting_date,
    String? modified,
  });

  $OverlapEmployeeModelCopyWith<$Res> get employee;
}

/// @nodoc
class _$OverlapLeaveModelCopyWithImpl<$Res, $Val extends OverlapLeaveModel>
    implements $OverlapLeaveModelCopyWith<$Res> {
  _$OverlapLeaveModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OverlapLeaveModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employee = null,
    Object? sharedProjects = freezed,
    Object? leaveType = null,
    Object? fromDate = null,
    Object? toDate = null,
    Object? days = null,
    Object? status = null,
    Object? description = freezed,
    Object? posting_date = freezed,
    Object? modified = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            employee: null == employee
                ? _value.employee
                : employee // ignore: cast_nullable_to_non_nullable
                      as OverlapEmployeeModel,
            sharedProjects: freezed == sharedProjects
                ? _value.sharedProjects
                : sharedProjects // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            leaveType: null == leaveType
                ? _value.leaveType
                : leaveType // ignore: cast_nullable_to_non_nullable
                      as String,
            fromDate: null == fromDate
                ? _value.fromDate
                : fromDate // ignore: cast_nullable_to_non_nullable
                      as String,
            toDate: null == toDate
                ? _value.toDate
                : toDate // ignore: cast_nullable_to_non_nullable
                      as String,
            days: null == days
                ? _value.days
                : days // ignore: cast_nullable_to_non_nullable
                      as double,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            posting_date: freezed == posting_date
                ? _value.posting_date
                : posting_date // ignore: cast_nullable_to_non_nullable
                      as String?,
            modified: freezed == modified
                ? _value.modified
                : modified // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of OverlapLeaveModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OverlapEmployeeModelCopyWith<$Res> get employee {
    return $OverlapEmployeeModelCopyWith<$Res>(_value.employee, (value) {
      return _then(_value.copyWith(employee: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OverlapLeaveModelImplCopyWith<$Res>
    implements $OverlapLeaveModelCopyWith<$Res> {
  factory _$$OverlapLeaveModelImplCopyWith(
    _$OverlapLeaveModelImpl value,
    $Res Function(_$OverlapLeaveModelImpl) then,
  ) = __$$OverlapLeaveModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    OverlapEmployeeModel employee,
    @JsonKey(name: 'shared_projects') List<String>? sharedProjects,
    @JsonKey(name: 'leave_type') String leaveType,
    @JsonKey(name: 'from_date') String fromDate,
    @JsonKey(name: 'to_date') String toDate,
    @JsonKey(name: 'days') double days,
    String status,
    String? description,
    String? posting_date,
    String? modified,
  });

  @override
  $OverlapEmployeeModelCopyWith<$Res> get employee;
}

/// @nodoc
class __$$OverlapLeaveModelImplCopyWithImpl<$Res>
    extends _$OverlapLeaveModelCopyWithImpl<$Res, _$OverlapLeaveModelImpl>
    implements _$$OverlapLeaveModelImplCopyWith<$Res> {
  __$$OverlapLeaveModelImplCopyWithImpl(
    _$OverlapLeaveModelImpl _value,
    $Res Function(_$OverlapLeaveModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OverlapLeaveModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employee = null,
    Object? sharedProjects = freezed,
    Object? leaveType = null,
    Object? fromDate = null,
    Object? toDate = null,
    Object? days = null,
    Object? status = null,
    Object? description = freezed,
    Object? posting_date = freezed,
    Object? modified = freezed,
  }) {
    return _then(
      _$OverlapLeaveModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        employee: null == employee
            ? _value.employee
            : employee // ignore: cast_nullable_to_non_nullable
                  as OverlapEmployeeModel,
        sharedProjects: freezed == sharedProjects
            ? _value._sharedProjects
            : sharedProjects // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        leaveType: null == leaveType
            ? _value.leaveType
            : leaveType // ignore: cast_nullable_to_non_nullable
                  as String,
        fromDate: null == fromDate
            ? _value.fromDate
            : fromDate // ignore: cast_nullable_to_non_nullable
                  as String,
        toDate: null == toDate
            ? _value.toDate
            : toDate // ignore: cast_nullable_to_non_nullable
                  as String,
        days: null == days
            ? _value.days
            : days // ignore: cast_nullable_to_non_nullable
                  as double,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        posting_date: freezed == posting_date
            ? _value.posting_date
            : posting_date // ignore: cast_nullable_to_non_nullable
                  as String?,
        modified: freezed == modified
            ? _value.modified
            : modified // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OverlapLeaveModelImpl extends _OverlapLeaveModel {
  const _$OverlapLeaveModelImpl({
    required this.id,
    required this.employee,
    @JsonKey(name: 'shared_projects') final List<String>? sharedProjects,
    @JsonKey(name: 'leave_type') required this.leaveType,
    @JsonKey(name: 'from_date') required this.fromDate,
    @JsonKey(name: 'to_date') required this.toDate,
    @JsonKey(name: 'days') required this.days,
    required this.status,
    this.description,
    this.posting_date,
    this.modified,
  }) : _sharedProjects = sharedProjects,
       super._();

  factory _$OverlapLeaveModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OverlapLeaveModelImplFromJson(json);

  @override
  final String id;
  @override
  final OverlapEmployeeModel employee;
  final List<String>? _sharedProjects;
  @override
  @JsonKey(name: 'shared_projects')
  List<String>? get sharedProjects {
    final value = _sharedProjects;
    if (value == null) return null;
    if (_sharedProjects is EqualUnmodifiableListView) return _sharedProjects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'leave_type')
  final String leaveType;
  @override
  @JsonKey(name: 'from_date')
  final String fromDate;
  @override
  @JsonKey(name: 'to_date')
  final String toDate;
  @override
  @JsonKey(name: 'days')
  final double days;
  @override
  final String status;
  @override
  final String? description;
  @override
  final String? posting_date;
  @override
  final String? modified;

  @override
  String toString() {
    return 'OverlapLeaveModel(id: $id, employee: $employee, sharedProjects: $sharedProjects, leaveType: $leaveType, fromDate: $fromDate, toDate: $toDate, days: $days, status: $status, description: $description, posting_date: $posting_date, modified: $modified)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OverlapLeaveModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.employee, employee) ||
                other.employee == employee) &&
            const DeepCollectionEquality().equals(
              other._sharedProjects,
              _sharedProjects,
            ) &&
            (identical(other.leaveType, leaveType) ||
                other.leaveType == leaveType) &&
            (identical(other.fromDate, fromDate) ||
                other.fromDate == fromDate) &&
            (identical(other.toDate, toDate) || other.toDate == toDate) &&
            (identical(other.days, days) || other.days == days) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.posting_date, posting_date) ||
                other.posting_date == posting_date) &&
            (identical(other.modified, modified) ||
                other.modified == modified));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    employee,
    const DeepCollectionEquality().hash(_sharedProjects),
    leaveType,
    fromDate,
    toDate,
    days,
    status,
    description,
    posting_date,
    modified,
  );

  /// Create a copy of OverlapLeaveModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OverlapLeaveModelImplCopyWith<_$OverlapLeaveModelImpl> get copyWith =>
      __$$OverlapLeaveModelImplCopyWithImpl<_$OverlapLeaveModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OverlapLeaveModelImplToJson(this);
  }
}

abstract class _OverlapLeaveModel extends OverlapLeaveModel {
  const factory _OverlapLeaveModel({
    required final String id,
    required final OverlapEmployeeModel employee,
    @JsonKey(name: 'shared_projects') final List<String>? sharedProjects,
    @JsonKey(name: 'leave_type') required final String leaveType,
    @JsonKey(name: 'from_date') required final String fromDate,
    @JsonKey(name: 'to_date') required final String toDate,
    @JsonKey(name: 'days') required final double days,
    required final String status,
    final String? description,
    final String? posting_date,
    final String? modified,
  }) = _$OverlapLeaveModelImpl;
  const _OverlapLeaveModel._() : super._();

  factory _OverlapLeaveModel.fromJson(Map<String, dynamic> json) =
      _$OverlapLeaveModelImpl.fromJson;

  @override
  String get id;
  @override
  OverlapEmployeeModel get employee;
  @override
  @JsonKey(name: 'shared_projects')
  List<String>? get sharedProjects;
  @override
  @JsonKey(name: 'leave_type')
  String get leaveType;
  @override
  @JsonKey(name: 'from_date')
  String get fromDate;
  @override
  @JsonKey(name: 'to_date')
  String get toDate;
  @override
  @JsonKey(name: 'days')
  double get days;
  @override
  String get status;
  @override
  String? get description;
  @override
  String? get posting_date;
  @override
  String? get modified;

  /// Create a copy of OverlapLeaveModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OverlapLeaveModelImplCopyWith<_$OverlapLeaveModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OverlapEmployeeModel _$OverlapEmployeeModelFromJson(Map<String, dynamic> json) {
  return _OverlapEmployeeModel.fromJson(json);
}

/// @nodoc
mixin _$OverlapEmployeeModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get designation => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get department => throw _privateConstructorUsedError;

  /// Serializes this OverlapEmployeeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OverlapEmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OverlapEmployeeModelCopyWith<OverlapEmployeeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OverlapEmployeeModelCopyWith<$Res> {
  factory $OverlapEmployeeModelCopyWith(
    OverlapEmployeeModel value,
    $Res Function(OverlapEmployeeModel) then,
  ) = _$OverlapEmployeeModelCopyWithImpl<$Res, OverlapEmployeeModel>;
  @useResult
  $Res call({
    String id,
    String name,
    String designation,
    String? image,
    String? department,
  });
}

/// @nodoc
class _$OverlapEmployeeModelCopyWithImpl<
  $Res,
  $Val extends OverlapEmployeeModel
>
    implements $OverlapEmployeeModelCopyWith<$Res> {
  _$OverlapEmployeeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OverlapEmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? designation = null,
    Object? image = freezed,
    Object? department = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            designation: null == designation
                ? _value.designation
                : designation // ignore: cast_nullable_to_non_nullable
                      as String,
            image: freezed == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                      as String?,
            department: freezed == department
                ? _value.department
                : department // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OverlapEmployeeModelImplCopyWith<$Res>
    implements $OverlapEmployeeModelCopyWith<$Res> {
  factory _$$OverlapEmployeeModelImplCopyWith(
    _$OverlapEmployeeModelImpl value,
    $Res Function(_$OverlapEmployeeModelImpl) then,
  ) = __$$OverlapEmployeeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String designation,
    String? image,
    String? department,
  });
}

/// @nodoc
class __$$OverlapEmployeeModelImplCopyWithImpl<$Res>
    extends _$OverlapEmployeeModelCopyWithImpl<$Res, _$OverlapEmployeeModelImpl>
    implements _$$OverlapEmployeeModelImplCopyWith<$Res> {
  __$$OverlapEmployeeModelImplCopyWithImpl(
    _$OverlapEmployeeModelImpl _value,
    $Res Function(_$OverlapEmployeeModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OverlapEmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? designation = null,
    Object? image = freezed,
    Object? department = freezed,
  }) {
    return _then(
      _$OverlapEmployeeModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        designation: null == designation
            ? _value.designation
            : designation // ignore: cast_nullable_to_non_nullable
                  as String,
        image: freezed == image
            ? _value.image
            : image // ignore: cast_nullable_to_non_nullable
                  as String?,
        department: freezed == department
            ? _value.department
            : department // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OverlapEmployeeModelImpl implements _OverlapEmployeeModel {
  const _$OverlapEmployeeModelImpl({
    required this.id,
    required this.name,
    required this.designation,
    this.image,
    this.department,
  });

  factory _$OverlapEmployeeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OverlapEmployeeModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String designation;
  @override
  final String? image;
  @override
  final String? department;

  @override
  String toString() {
    return 'OverlapEmployeeModel(id: $id, name: $name, designation: $designation, image: $image, department: $department)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OverlapEmployeeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.designation, designation) ||
                other.designation == designation) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.department, department) ||
                other.department == department));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, designation, image, department);

  /// Create a copy of OverlapEmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OverlapEmployeeModelImplCopyWith<_$OverlapEmployeeModelImpl>
  get copyWith =>
      __$$OverlapEmployeeModelImplCopyWithImpl<_$OverlapEmployeeModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OverlapEmployeeModelImplToJson(this);
  }
}

abstract class _OverlapEmployeeModel implements OverlapEmployeeModel {
  const factory _OverlapEmployeeModel({
    required final String id,
    required final String name,
    required final String designation,
    final String? image,
    final String? department,
  }) = _$OverlapEmployeeModelImpl;

  factory _OverlapEmployeeModel.fromJson(Map<String, dynamic> json) =
      _$OverlapEmployeeModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get designation;
  @override
  String? get image;
  @override
  String? get department;

  /// Create a copy of OverlapEmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OverlapEmployeeModelImplCopyWith<_$OverlapEmployeeModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
