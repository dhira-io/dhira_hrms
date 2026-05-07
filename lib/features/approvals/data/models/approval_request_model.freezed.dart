// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'approval_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ApprovalRequestModel {
  String get name => throw _privateConstructorUsedError;
  String get employeeName => throw _privateConstructorUsedError;
  String? get employeeRole => throw _privateConstructorUsedError;
  String? get profileImage => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  Map<String, String> get displayDetails => throw _privateConstructorUsedError;
  ApprovalCategory get category => throw _privateConstructorUsedError;
  List<String> get availableActions => throw _privateConstructorUsedError;
  bool get isMainApprover => throw _privateConstructorUsedError;
  List<Map<String, dynamic>> get conflictingLeavesJson =>
      throw _privateConstructorUsedError;
  DateTime? get fromDate => throw _privateConstructorUsedError;
  DateTime? get toDate => throw _privateConstructorUsedError;
  bool get isHalfDay => throw _privateConstructorUsedError;
  String? get halfDaySegment => throw _privateConstructorUsedError;
  String? get fileUrl => throw _privateConstructorUsedError;

  /// Create a copy of ApprovalRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApprovalRequestModelCopyWith<ApprovalRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApprovalRequestModelCopyWith<$Res> {
  factory $ApprovalRequestModelCopyWith(
    ApprovalRequestModel value,
    $Res Function(ApprovalRequestModel) then,
  ) = _$ApprovalRequestModelCopyWithImpl<$Res, ApprovalRequestModel>;
  @useResult
  $Res call({
    String name,
    String employeeName,
    String? employeeRole,
    String? profileImage,
    String status,
    Map<String, String> displayDetails,
    ApprovalCategory category,
    List<String> availableActions,
    bool isMainApprover,
    List<Map<String, dynamic>> conflictingLeavesJson,
    DateTime? fromDate,
    DateTime? toDate,
    bool isHalfDay,
    String? halfDaySegment,
    String? fileUrl,
  });
}

/// @nodoc
class _$ApprovalRequestModelCopyWithImpl<
  $Res,
  $Val extends ApprovalRequestModel
>
    implements $ApprovalRequestModelCopyWith<$Res> {
  _$ApprovalRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApprovalRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? employeeName = null,
    Object? employeeRole = freezed,
    Object? profileImage = freezed,
    Object? status = null,
    Object? displayDetails = null,
    Object? category = null,
    Object? availableActions = null,
    Object? isMainApprover = null,
    Object? conflictingLeavesJson = null,
    Object? fromDate = freezed,
    Object? toDate = freezed,
    Object? isHalfDay = null,
    Object? halfDaySegment = freezed,
    Object? fileUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            employeeName: null == employeeName
                ? _value.employeeName
                : employeeName // ignore: cast_nullable_to_non_nullable
                      as String,
            employeeRole: freezed == employeeRole
                ? _value.employeeRole
                : employeeRole // ignore: cast_nullable_to_non_nullable
                      as String?,
            profileImage: freezed == profileImage
                ? _value.profileImage
                : profileImage // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            displayDetails: null == displayDetails
                ? _value.displayDetails
                : displayDetails // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as ApprovalCategory,
            availableActions: null == availableActions
                ? _value.availableActions
                : availableActions // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isMainApprover: null == isMainApprover
                ? _value.isMainApprover
                : isMainApprover // ignore: cast_nullable_to_non_nullable
                      as bool,
            conflictingLeavesJson: null == conflictingLeavesJson
                ? _value.conflictingLeavesJson
                : conflictingLeavesJson // ignore: cast_nullable_to_non_nullable
                      as List<Map<String, dynamic>>,
            fromDate: freezed == fromDate
                ? _value.fromDate
                : fromDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            toDate: freezed == toDate
                ? _value.toDate
                : toDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isHalfDay: null == isHalfDay
                ? _value.isHalfDay
                : isHalfDay // ignore: cast_nullable_to_non_nullable
                      as bool,
            halfDaySegment: freezed == halfDaySegment
                ? _value.halfDaySegment
                : halfDaySegment // ignore: cast_nullable_to_non_nullable
                      as String?,
            fileUrl: freezed == fileUrl
                ? _value.fileUrl
                : fileUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ApprovalRequestModelImplCopyWith<$Res>
    implements $ApprovalRequestModelCopyWith<$Res> {
  factory _$$ApprovalRequestModelImplCopyWith(
    _$ApprovalRequestModelImpl value,
    $Res Function(_$ApprovalRequestModelImpl) then,
  ) = __$$ApprovalRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String employeeName,
    String? employeeRole,
    String? profileImage,
    String status,
    Map<String, String> displayDetails,
    ApprovalCategory category,
    List<String> availableActions,
    bool isMainApprover,
    List<Map<String, dynamic>> conflictingLeavesJson,
    DateTime? fromDate,
    DateTime? toDate,
    bool isHalfDay,
    String? halfDaySegment,
    String? fileUrl,
  });
}

/// @nodoc
class __$$ApprovalRequestModelImplCopyWithImpl<$Res>
    extends _$ApprovalRequestModelCopyWithImpl<$Res, _$ApprovalRequestModelImpl>
    implements _$$ApprovalRequestModelImplCopyWith<$Res> {
  __$$ApprovalRequestModelImplCopyWithImpl(
    _$ApprovalRequestModelImpl _value,
    $Res Function(_$ApprovalRequestModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApprovalRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? employeeName = null,
    Object? employeeRole = freezed,
    Object? profileImage = freezed,
    Object? status = null,
    Object? displayDetails = null,
    Object? category = null,
    Object? availableActions = null,
    Object? isMainApprover = null,
    Object? conflictingLeavesJson = null,
    Object? fromDate = freezed,
    Object? toDate = freezed,
    Object? isHalfDay = null,
    Object? halfDaySegment = freezed,
    Object? fileUrl = freezed,
  }) {
    return _then(
      _$ApprovalRequestModelImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        employeeName: null == employeeName
            ? _value.employeeName
            : employeeName // ignore: cast_nullable_to_non_nullable
                  as String,
        employeeRole: freezed == employeeRole
            ? _value.employeeRole
            : employeeRole // ignore: cast_nullable_to_non_nullable
                  as String?,
        profileImage: freezed == profileImage
            ? _value.profileImage
            : profileImage // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        displayDetails: null == displayDetails
            ? _value._displayDetails
            : displayDetails // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as ApprovalCategory,
        availableActions: null == availableActions
            ? _value._availableActions
            : availableActions // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isMainApprover: null == isMainApprover
            ? _value.isMainApprover
            : isMainApprover // ignore: cast_nullable_to_non_nullable
                  as bool,
        conflictingLeavesJson: null == conflictingLeavesJson
            ? _value._conflictingLeavesJson
            : conflictingLeavesJson // ignore: cast_nullable_to_non_nullable
                  as List<Map<String, dynamic>>,
        fromDate: freezed == fromDate
            ? _value.fromDate
            : fromDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        toDate: freezed == toDate
            ? _value.toDate
            : toDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isHalfDay: null == isHalfDay
            ? _value.isHalfDay
            : isHalfDay // ignore: cast_nullable_to_non_nullable
                  as bool,
        halfDaySegment: freezed == halfDaySegment
            ? _value.halfDaySegment
            : halfDaySegment // ignore: cast_nullable_to_non_nullable
                  as String?,
        fileUrl: freezed == fileUrl
            ? _value.fileUrl
            : fileUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ApprovalRequestModelImpl extends _ApprovalRequestModel {
  const _$ApprovalRequestModelImpl({
    required this.name,
    required this.employeeName,
    this.employeeRole,
    this.profileImage,
    required this.status,
    required final Map<String, String> displayDetails,
    required this.category,
    required final List<String> availableActions,
    this.isMainApprover = false,
    final List<Map<String, dynamic>> conflictingLeavesJson = const [],
    this.fromDate,
    this.toDate,
    this.isHalfDay = false,
    this.halfDaySegment,
    this.fileUrl,
  }) : _displayDetails = displayDetails,
       _availableActions = availableActions,
       _conflictingLeavesJson = conflictingLeavesJson,
       super._();

  @override
  final String name;
  @override
  final String employeeName;
  @override
  final String? employeeRole;
  @override
  final String? profileImage;
  @override
  final String status;
  final Map<String, String> _displayDetails;
  @override
  Map<String, String> get displayDetails {
    if (_displayDetails is EqualUnmodifiableMapView) return _displayDetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_displayDetails);
  }

  @override
  final ApprovalCategory category;
  final List<String> _availableActions;
  @override
  List<String> get availableActions {
    if (_availableActions is EqualUnmodifiableListView)
      return _availableActions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableActions);
  }

  @override
  @JsonKey()
  final bool isMainApprover;
  final List<Map<String, dynamic>> _conflictingLeavesJson;
  @override
  @JsonKey()
  List<Map<String, dynamic>> get conflictingLeavesJson {
    if (_conflictingLeavesJson is EqualUnmodifiableListView)
      return _conflictingLeavesJson;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conflictingLeavesJson);
  }

  @override
  final DateTime? fromDate;
  @override
  final DateTime? toDate;
  @override
  @JsonKey()
  final bool isHalfDay;
  @override
  final String? halfDaySegment;
  @override
  final String? fileUrl;

  @override
  String toString() {
    return 'ApprovalRequestModel(name: $name, employeeName: $employeeName, employeeRole: $employeeRole, profileImage: $profileImage, status: $status, displayDetails: $displayDetails, category: $category, availableActions: $availableActions, isMainApprover: $isMainApprover, conflictingLeavesJson: $conflictingLeavesJson, fromDate: $fromDate, toDate: $toDate, isHalfDay: $isHalfDay, halfDaySegment: $halfDaySegment, fileUrl: $fileUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApprovalRequestModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.employeeName, employeeName) ||
                other.employeeName == employeeName) &&
            (identical(other.employeeRole, employeeRole) ||
                other.employeeRole == employeeRole) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(
              other._displayDetails,
              _displayDetails,
            ) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality().equals(
              other._availableActions,
              _availableActions,
            ) &&
            (identical(other.isMainApprover, isMainApprover) ||
                other.isMainApprover == isMainApprover) &&
            const DeepCollectionEquality().equals(
              other._conflictingLeavesJson,
              _conflictingLeavesJson,
            ) &&
            (identical(other.fromDate, fromDate) ||
                other.fromDate == fromDate) &&
            (identical(other.toDate, toDate) || other.toDate == toDate) &&
            (identical(other.isHalfDay, isHalfDay) ||
                other.isHalfDay == isHalfDay) &&
            (identical(other.halfDaySegment, halfDaySegment) ||
                other.halfDaySegment == halfDaySegment) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    employeeName,
    employeeRole,
    profileImage,
    status,
    const DeepCollectionEquality().hash(_displayDetails),
    category,
    const DeepCollectionEquality().hash(_availableActions),
    isMainApprover,
    const DeepCollectionEquality().hash(_conflictingLeavesJson),
    fromDate,
    toDate,
    isHalfDay,
    halfDaySegment,
    fileUrl,
  );

  /// Create a copy of ApprovalRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApprovalRequestModelImplCopyWith<_$ApprovalRequestModelImpl>
  get copyWith =>
      __$$ApprovalRequestModelImplCopyWithImpl<_$ApprovalRequestModelImpl>(
        this,
        _$identity,
      );
}

abstract class _ApprovalRequestModel extends ApprovalRequestModel {
  const factory _ApprovalRequestModel({
    required final String name,
    required final String employeeName,
    final String? employeeRole,
    final String? profileImage,
    required final String status,
    required final Map<String, String> displayDetails,
    required final ApprovalCategory category,
    required final List<String> availableActions,
    final bool isMainApprover,
    final List<Map<String, dynamic>> conflictingLeavesJson,
    final DateTime? fromDate,
    final DateTime? toDate,
    final bool isHalfDay,
    final String? halfDaySegment,
    final String? fileUrl,
  }) = _$ApprovalRequestModelImpl;
  const _ApprovalRequestModel._() : super._();

  @override
  String get name;
  @override
  String get employeeName;
  @override
  String? get employeeRole;
  @override
  String? get profileImage;
  @override
  String get status;
  @override
  Map<String, String> get displayDetails;
  @override
  ApprovalCategory get category;
  @override
  List<String> get availableActions;
  @override
  bool get isMainApprover;
  @override
  List<Map<String, dynamic>> get conflictingLeavesJson;
  @override
  DateTime? get fromDate;
  @override
  DateTime? get toDate;
  @override
  bool get isHalfDay;
  @override
  String? get halfDaySegment;
  @override
  String? get fileUrl;

  /// Create a copy of ApprovalRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApprovalRequestModelImplCopyWith<_$ApprovalRequestModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
