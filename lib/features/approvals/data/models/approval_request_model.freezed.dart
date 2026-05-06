// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'approval_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApprovalRequestModel {

 String get name; String get employeeName; String? get employeeRole; String? get profileImage; String get status; Map<String, String> get displayDetails; ApprovalCategory get category; List<String> get availableActions; bool get isMainApprover; List<Map<String, dynamic>> get conflictingLeavesJson; DateTime? get fromDate; DateTime? get toDate; bool get isHalfDay; String? get halfDaySegment; String? get fileUrl;
/// Create a copy of ApprovalRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApprovalRequestModelCopyWith<ApprovalRequestModel> get copyWith => _$ApprovalRequestModelCopyWithImpl<ApprovalRequestModel>(this as ApprovalRequestModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApprovalRequestModel&&(identical(other.name, name) || other.name == name)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.employeeRole, employeeRole) || other.employeeRole == employeeRole)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.displayDetails, displayDetails)&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other.availableActions, availableActions)&&(identical(other.isMainApprover, isMainApprover) || other.isMainApprover == isMainApprover)&&const DeepCollectionEquality().equals(other.conflictingLeavesJson, conflictingLeavesJson)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.isHalfDay, isHalfDay) || other.isHalfDay == isHalfDay)&&(identical(other.halfDaySegment, halfDaySegment) || other.halfDaySegment == halfDaySegment)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl));
}


@override
int get hashCode => Object.hash(runtimeType,name,employeeName,employeeRole,profileImage,status,const DeepCollectionEquality().hash(displayDetails),category,const DeepCollectionEquality().hash(availableActions),isMainApprover,const DeepCollectionEquality().hash(conflictingLeavesJson),fromDate,toDate,isHalfDay,halfDaySegment,fileUrl);

@override
String toString() {
  return 'ApprovalRequestModel(name: $name, employeeName: $employeeName, employeeRole: $employeeRole, profileImage: $profileImage, status: $status, displayDetails: $displayDetails, category: $category, availableActions: $availableActions, isMainApprover: $isMainApprover, conflictingLeavesJson: $conflictingLeavesJson, fromDate: $fromDate, toDate: $toDate, isHalfDay: $isHalfDay, halfDaySegment: $halfDaySegment, fileUrl: $fileUrl)';
}


}

/// @nodoc
abstract mixin class $ApprovalRequestModelCopyWith<$Res>  {
  factory $ApprovalRequestModelCopyWith(ApprovalRequestModel value, $Res Function(ApprovalRequestModel) _then) = _$ApprovalRequestModelCopyWithImpl;
@useResult
$Res call({
 String name, String employeeName, String? employeeRole, String? profileImage, String status, Map<String, String> displayDetails, ApprovalCategory category, List<String> availableActions, bool isMainApprover, List<Map<String, dynamic>> conflictingLeavesJson, DateTime? fromDate, DateTime? toDate, bool isHalfDay, String? halfDaySegment, String? fileUrl
});




}
/// @nodoc
class _$ApprovalRequestModelCopyWithImpl<$Res>
    implements $ApprovalRequestModelCopyWith<$Res> {
  _$ApprovalRequestModelCopyWithImpl(this._self, this._then);

  final ApprovalRequestModel _self;
  final $Res Function(ApprovalRequestModel) _then;

/// Create a copy of ApprovalRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? employeeName = null,Object? employeeRole = freezed,Object? profileImage = freezed,Object? status = null,Object? displayDetails = null,Object? category = null,Object? availableActions = null,Object? isMainApprover = null,Object? conflictingLeavesJson = null,Object? fromDate = freezed,Object? toDate = freezed,Object? isHalfDay = null,Object? halfDaySegment = freezed,Object? fileUrl = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,employeeName: null == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String,employeeRole: freezed == employeeRole ? _self.employeeRole : employeeRole // ignore: cast_nullable_to_non_nullable
as String?,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,displayDetails: null == displayDetails ? _self.displayDetails : displayDetails // ignore: cast_nullable_to_non_nullable
as Map<String, String>,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ApprovalCategory,availableActions: null == availableActions ? _self.availableActions : availableActions // ignore: cast_nullable_to_non_nullable
as List<String>,isMainApprover: null == isMainApprover ? _self.isMainApprover : isMainApprover // ignore: cast_nullable_to_non_nullable
as bool,conflictingLeavesJson: null == conflictingLeavesJson ? _self.conflictingLeavesJson : conflictingLeavesJson // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,fromDate: freezed == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as DateTime?,toDate: freezed == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isHalfDay: null == isHalfDay ? _self.isHalfDay : isHalfDay // ignore: cast_nullable_to_non_nullable
as bool,halfDaySegment: freezed == halfDaySegment ? _self.halfDaySegment : halfDaySegment // ignore: cast_nullable_to_non_nullable
as String?,fileUrl: freezed == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ApprovalRequestModel].
extension ApprovalRequestModelPatterns on ApprovalRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApprovalRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApprovalRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApprovalRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _ApprovalRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApprovalRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _ApprovalRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String employeeName,  String? employeeRole,  String? profileImage,  String status,  Map<String, String> displayDetails,  ApprovalCategory category,  List<String> availableActions,  bool isMainApprover,  List<Map<String, dynamic>> conflictingLeavesJson,  DateTime? fromDate,  DateTime? toDate,  bool isHalfDay,  String? halfDaySegment,  String? fileUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApprovalRequestModel() when $default != null:
return $default(_that.name,_that.employeeName,_that.employeeRole,_that.profileImage,_that.status,_that.displayDetails,_that.category,_that.availableActions,_that.isMainApprover,_that.conflictingLeavesJson,_that.fromDate,_that.toDate,_that.isHalfDay,_that.halfDaySegment,_that.fileUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String employeeName,  String? employeeRole,  String? profileImage,  String status,  Map<String, String> displayDetails,  ApprovalCategory category,  List<String> availableActions,  bool isMainApprover,  List<Map<String, dynamic>> conflictingLeavesJson,  DateTime? fromDate,  DateTime? toDate,  bool isHalfDay,  String? halfDaySegment,  String? fileUrl)  $default,) {final _that = this;
switch (_that) {
case _ApprovalRequestModel():
return $default(_that.name,_that.employeeName,_that.employeeRole,_that.profileImage,_that.status,_that.displayDetails,_that.category,_that.availableActions,_that.isMainApprover,_that.conflictingLeavesJson,_that.fromDate,_that.toDate,_that.isHalfDay,_that.halfDaySegment,_that.fileUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String employeeName,  String? employeeRole,  String? profileImage,  String status,  Map<String, String> displayDetails,  ApprovalCategory category,  List<String> availableActions,  bool isMainApprover,  List<Map<String, dynamic>> conflictingLeavesJson,  DateTime? fromDate,  DateTime? toDate,  bool isHalfDay,  String? halfDaySegment,  String? fileUrl)?  $default,) {final _that = this;
switch (_that) {
case _ApprovalRequestModel() when $default != null:
return $default(_that.name,_that.employeeName,_that.employeeRole,_that.profileImage,_that.status,_that.displayDetails,_that.category,_that.availableActions,_that.isMainApprover,_that.conflictingLeavesJson,_that.fromDate,_that.toDate,_that.isHalfDay,_that.halfDaySegment,_that.fileUrl);case _:
  return null;

}
}

}

/// @nodoc


class _ApprovalRequestModel extends ApprovalRequestModel {
  const _ApprovalRequestModel({required this.name, required this.employeeName, this.employeeRole, this.profileImage, required this.status, required final  Map<String, String> displayDetails, required this.category, required final  List<String> availableActions, this.isMainApprover = false, final  List<Map<String, dynamic>> conflictingLeavesJson = const [], this.fromDate, this.toDate, this.isHalfDay = false, this.halfDaySegment, this.fileUrl}): _displayDetails = displayDetails,_availableActions = availableActions,_conflictingLeavesJson = conflictingLeavesJson,super._();
  

@override final  String name;
@override final  String employeeName;
@override final  String? employeeRole;
@override final  String? profileImage;
@override final  String status;
 final  Map<String, String> _displayDetails;
@override Map<String, String> get displayDetails {
  if (_displayDetails is EqualUnmodifiableMapView) return _displayDetails;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_displayDetails);
}

@override final  ApprovalCategory category;
 final  List<String> _availableActions;
@override List<String> get availableActions {
  if (_availableActions is EqualUnmodifiableListView) return _availableActions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableActions);
}

@override@JsonKey() final  bool isMainApprover;
 final  List<Map<String, dynamic>> _conflictingLeavesJson;
@override@JsonKey() List<Map<String, dynamic>> get conflictingLeavesJson {
  if (_conflictingLeavesJson is EqualUnmodifiableListView) return _conflictingLeavesJson;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_conflictingLeavesJson);
}

@override final  DateTime? fromDate;
@override final  DateTime? toDate;
@override@JsonKey() final  bool isHalfDay;
@override final  String? halfDaySegment;
@override final  String? fileUrl;

/// Create a copy of ApprovalRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApprovalRequestModelCopyWith<_ApprovalRequestModel> get copyWith => __$ApprovalRequestModelCopyWithImpl<_ApprovalRequestModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApprovalRequestModel&&(identical(other.name, name) || other.name == name)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.employeeRole, employeeRole) || other.employeeRole == employeeRole)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._displayDetails, _displayDetails)&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other._availableActions, _availableActions)&&(identical(other.isMainApprover, isMainApprover) || other.isMainApprover == isMainApprover)&&const DeepCollectionEquality().equals(other._conflictingLeavesJson, _conflictingLeavesJson)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.isHalfDay, isHalfDay) || other.isHalfDay == isHalfDay)&&(identical(other.halfDaySegment, halfDaySegment) || other.halfDaySegment == halfDaySegment)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl));
}


@override
int get hashCode => Object.hash(runtimeType,name,employeeName,employeeRole,profileImage,status,const DeepCollectionEquality().hash(_displayDetails),category,const DeepCollectionEquality().hash(_availableActions),isMainApprover,const DeepCollectionEquality().hash(_conflictingLeavesJson),fromDate,toDate,isHalfDay,halfDaySegment,fileUrl);

@override
String toString() {
  return 'ApprovalRequestModel(name: $name, employeeName: $employeeName, employeeRole: $employeeRole, profileImage: $profileImage, status: $status, displayDetails: $displayDetails, category: $category, availableActions: $availableActions, isMainApprover: $isMainApprover, conflictingLeavesJson: $conflictingLeavesJson, fromDate: $fromDate, toDate: $toDate, isHalfDay: $isHalfDay, halfDaySegment: $halfDaySegment, fileUrl: $fileUrl)';
}


}

/// @nodoc
abstract mixin class _$ApprovalRequestModelCopyWith<$Res> implements $ApprovalRequestModelCopyWith<$Res> {
  factory _$ApprovalRequestModelCopyWith(_ApprovalRequestModel value, $Res Function(_ApprovalRequestModel) _then) = __$ApprovalRequestModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String employeeName, String? employeeRole, String? profileImage, String status, Map<String, String> displayDetails, ApprovalCategory category, List<String> availableActions, bool isMainApprover, List<Map<String, dynamic>> conflictingLeavesJson, DateTime? fromDate, DateTime? toDate, bool isHalfDay, String? halfDaySegment, String? fileUrl
});




}
/// @nodoc
class __$ApprovalRequestModelCopyWithImpl<$Res>
    implements _$ApprovalRequestModelCopyWith<$Res> {
  __$ApprovalRequestModelCopyWithImpl(this._self, this._then);

  final _ApprovalRequestModel _self;
  final $Res Function(_ApprovalRequestModel) _then;

/// Create a copy of ApprovalRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? employeeName = null,Object? employeeRole = freezed,Object? profileImage = freezed,Object? status = null,Object? displayDetails = null,Object? category = null,Object? availableActions = null,Object? isMainApprover = null,Object? conflictingLeavesJson = null,Object? fromDate = freezed,Object? toDate = freezed,Object? isHalfDay = null,Object? halfDaySegment = freezed,Object? fileUrl = freezed,}) {
  return _then(_ApprovalRequestModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,employeeName: null == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String,employeeRole: freezed == employeeRole ? _self.employeeRole : employeeRole // ignore: cast_nullable_to_non_nullable
as String?,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,displayDetails: null == displayDetails ? _self._displayDetails : displayDetails // ignore: cast_nullable_to_non_nullable
as Map<String, String>,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ApprovalCategory,availableActions: null == availableActions ? _self._availableActions : availableActions // ignore: cast_nullable_to_non_nullable
as List<String>,isMainApprover: null == isMainApprover ? _self.isMainApprover : isMainApprover // ignore: cast_nullable_to_non_nullable
as bool,conflictingLeavesJson: null == conflictingLeavesJson ? _self._conflictingLeavesJson : conflictingLeavesJson // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,fromDate: freezed == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as DateTime?,toDate: freezed == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isHalfDay: null == isHalfDay ? _self.isHalfDay : isHalfDay // ignore: cast_nullable_to_non_nullable
as bool,halfDaySegment: freezed == halfDaySegment ? _self.halfDaySegment : halfDaySegment // ignore: cast_nullable_to_non_nullable
as String?,fileUrl: freezed == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
