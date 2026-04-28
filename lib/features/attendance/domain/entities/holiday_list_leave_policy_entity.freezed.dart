// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'holiday_list_leave_policy_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HolidayListLeavePolicyEntity {

 bool get success; String get employee; String get employeeName; String get company; HolidayListEntity get holidayList; LeavePolicyEntity get leavePolicy;
/// Create a copy of HolidayListLeavePolicyEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HolidayListLeavePolicyEntityCopyWith<HolidayListLeavePolicyEntity> get copyWith => _$HolidayListLeavePolicyEntityCopyWithImpl<HolidayListLeavePolicyEntity>(this as HolidayListLeavePolicyEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HolidayListLeavePolicyEntity&&(identical(other.success, success) || other.success == success)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.company, company) || other.company == company)&&(identical(other.holidayList, holidayList) || other.holidayList == holidayList)&&(identical(other.leavePolicy, leavePolicy) || other.leavePolicy == leavePolicy));
}


@override
int get hashCode => Object.hash(runtimeType,success,employee,employeeName,company,holidayList,leavePolicy);

@override
String toString() {
  return 'HolidayListLeavePolicyEntity(success: $success, employee: $employee, employeeName: $employeeName, company: $company, holidayList: $holidayList, leavePolicy: $leavePolicy)';
}


}

/// @nodoc
abstract mixin class $HolidayListLeavePolicyEntityCopyWith<$Res>  {
  factory $HolidayListLeavePolicyEntityCopyWith(HolidayListLeavePolicyEntity value, $Res Function(HolidayListLeavePolicyEntity) _then) = _$HolidayListLeavePolicyEntityCopyWithImpl;
@useResult
$Res call({
 bool success, String employee, String employeeName, String company, HolidayListEntity holidayList, LeavePolicyEntity leavePolicy
});


$HolidayListEntityCopyWith<$Res> get holidayList;$LeavePolicyEntityCopyWith<$Res> get leavePolicy;

}
/// @nodoc
class _$HolidayListLeavePolicyEntityCopyWithImpl<$Res>
    implements $HolidayListLeavePolicyEntityCopyWith<$Res> {
  _$HolidayListLeavePolicyEntityCopyWithImpl(this._self, this._then);

  final HolidayListLeavePolicyEntity _self;
  final $Res Function(HolidayListLeavePolicyEntity) _then;

/// Create a copy of HolidayListLeavePolicyEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? employee = null,Object? employeeName = null,Object? company = null,Object? holidayList = null,Object? leavePolicy = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,employee: null == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as String,employeeName: null == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,holidayList: null == holidayList ? _self.holidayList : holidayList // ignore: cast_nullable_to_non_nullable
as HolidayListEntity,leavePolicy: null == leavePolicy ? _self.leavePolicy : leavePolicy // ignore: cast_nullable_to_non_nullable
as LeavePolicyEntity,
  ));
}
/// Create a copy of HolidayListLeavePolicyEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HolidayListEntityCopyWith<$Res> get holidayList {
  
  return $HolidayListEntityCopyWith<$Res>(_self.holidayList, (value) {
    return _then(_self.copyWith(holidayList: value));
  });
}/// Create a copy of HolidayListLeavePolicyEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeavePolicyEntityCopyWith<$Res> get leavePolicy {
  
  return $LeavePolicyEntityCopyWith<$Res>(_self.leavePolicy, (value) {
    return _then(_self.copyWith(leavePolicy: value));
  });
}
}


/// Adds pattern-matching-related methods to [HolidayListLeavePolicyEntity].
extension HolidayListLeavePolicyEntityPatterns on HolidayListLeavePolicyEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HolidayListLeavePolicyEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HolidayListLeavePolicyEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HolidayListLeavePolicyEntity value)  $default,){
final _that = this;
switch (_that) {
case _HolidayListLeavePolicyEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HolidayListLeavePolicyEntity value)?  $default,){
final _that = this;
switch (_that) {
case _HolidayListLeavePolicyEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String employee,  String employeeName,  String company,  HolidayListEntity holidayList,  LeavePolicyEntity leavePolicy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HolidayListLeavePolicyEntity() when $default != null:
return $default(_that.success,_that.employee,_that.employeeName,_that.company,_that.holidayList,_that.leavePolicy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String employee,  String employeeName,  String company,  HolidayListEntity holidayList,  LeavePolicyEntity leavePolicy)  $default,) {final _that = this;
switch (_that) {
case _HolidayListLeavePolicyEntity():
return $default(_that.success,_that.employee,_that.employeeName,_that.company,_that.holidayList,_that.leavePolicy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String employee,  String employeeName,  String company,  HolidayListEntity holidayList,  LeavePolicyEntity leavePolicy)?  $default,) {final _that = this;
switch (_that) {
case _HolidayListLeavePolicyEntity() when $default != null:
return $default(_that.success,_that.employee,_that.employeeName,_that.company,_that.holidayList,_that.leavePolicy);case _:
  return null;

}
}

}

/// @nodoc


class _HolidayListLeavePolicyEntity implements HolidayListLeavePolicyEntity {
  const _HolidayListLeavePolicyEntity({required this.success, required this.employee, required this.employeeName, required this.company, required this.holidayList, required this.leavePolicy});
  

@override final  bool success;
@override final  String employee;
@override final  String employeeName;
@override final  String company;
@override final  HolidayListEntity holidayList;
@override final  LeavePolicyEntity leavePolicy;

/// Create a copy of HolidayListLeavePolicyEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HolidayListLeavePolicyEntityCopyWith<_HolidayListLeavePolicyEntity> get copyWith => __$HolidayListLeavePolicyEntityCopyWithImpl<_HolidayListLeavePolicyEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HolidayListLeavePolicyEntity&&(identical(other.success, success) || other.success == success)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.company, company) || other.company == company)&&(identical(other.holidayList, holidayList) || other.holidayList == holidayList)&&(identical(other.leavePolicy, leavePolicy) || other.leavePolicy == leavePolicy));
}


@override
int get hashCode => Object.hash(runtimeType,success,employee,employeeName,company,holidayList,leavePolicy);

@override
String toString() {
  return 'HolidayListLeavePolicyEntity(success: $success, employee: $employee, employeeName: $employeeName, company: $company, holidayList: $holidayList, leavePolicy: $leavePolicy)';
}


}

/// @nodoc
abstract mixin class _$HolidayListLeavePolicyEntityCopyWith<$Res> implements $HolidayListLeavePolicyEntityCopyWith<$Res> {
  factory _$HolidayListLeavePolicyEntityCopyWith(_HolidayListLeavePolicyEntity value, $Res Function(_HolidayListLeavePolicyEntity) _then) = __$HolidayListLeavePolicyEntityCopyWithImpl;
@override @useResult
$Res call({
 bool success, String employee, String employeeName, String company, HolidayListEntity holidayList, LeavePolicyEntity leavePolicy
});


@override $HolidayListEntityCopyWith<$Res> get holidayList;@override $LeavePolicyEntityCopyWith<$Res> get leavePolicy;

}
/// @nodoc
class __$HolidayListLeavePolicyEntityCopyWithImpl<$Res>
    implements _$HolidayListLeavePolicyEntityCopyWith<$Res> {
  __$HolidayListLeavePolicyEntityCopyWithImpl(this._self, this._then);

  final _HolidayListLeavePolicyEntity _self;
  final $Res Function(_HolidayListLeavePolicyEntity) _then;

/// Create a copy of HolidayListLeavePolicyEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? employee = null,Object? employeeName = null,Object? company = null,Object? holidayList = null,Object? leavePolicy = null,}) {
  return _then(_HolidayListLeavePolicyEntity(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,employee: null == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as String,employeeName: null == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,holidayList: null == holidayList ? _self.holidayList : holidayList // ignore: cast_nullable_to_non_nullable
as HolidayListEntity,leavePolicy: null == leavePolicy ? _self.leavePolicy : leavePolicy // ignore: cast_nullable_to_non_nullable
as LeavePolicyEntity,
  ));
}

/// Create a copy of HolidayListLeavePolicyEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HolidayListEntityCopyWith<$Res> get holidayList {
  
  return $HolidayListEntityCopyWith<$Res>(_self.holidayList, (value) {
    return _then(_self.copyWith(holidayList: value));
  });
}/// Create a copy of HolidayListLeavePolicyEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeavePolicyEntityCopyWith<$Res> get leavePolicy {
  
  return $LeavePolicyEntityCopyWith<$Res>(_self.leavePolicy, (value) {
    return _then(_self.copyWith(leavePolicy: value));
  });
}
}

/// @nodoc
mixin _$HolidayListEntity {

 String get name; String get holidayListName; String get fromDate; String get toDate; int get totalHolidays; List<RestrictedHolidayEntity> get customRestrictedHolidays; List<HolidayEntity> get holidays;
/// Create a copy of HolidayListEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HolidayListEntityCopyWith<HolidayListEntity> get copyWith => _$HolidayListEntityCopyWithImpl<HolidayListEntity>(this as HolidayListEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HolidayListEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.holidayListName, holidayListName) || other.holidayListName == holidayListName)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.totalHolidays, totalHolidays) || other.totalHolidays == totalHolidays)&&const DeepCollectionEquality().equals(other.customRestrictedHolidays, customRestrictedHolidays)&&const DeepCollectionEquality().equals(other.holidays, holidays));
}


@override
int get hashCode => Object.hash(runtimeType,name,holidayListName,fromDate,toDate,totalHolidays,const DeepCollectionEquality().hash(customRestrictedHolidays),const DeepCollectionEquality().hash(holidays));

@override
String toString() {
  return 'HolidayListEntity(name: $name, holidayListName: $holidayListName, fromDate: $fromDate, toDate: $toDate, totalHolidays: $totalHolidays, customRestrictedHolidays: $customRestrictedHolidays, holidays: $holidays)';
}


}

/// @nodoc
abstract mixin class $HolidayListEntityCopyWith<$Res>  {
  factory $HolidayListEntityCopyWith(HolidayListEntity value, $Res Function(HolidayListEntity) _then) = _$HolidayListEntityCopyWithImpl;
@useResult
$Res call({
 String name, String holidayListName, String fromDate, String toDate, int totalHolidays, List<RestrictedHolidayEntity> customRestrictedHolidays, List<HolidayEntity> holidays
});




}
/// @nodoc
class _$HolidayListEntityCopyWithImpl<$Res>
    implements $HolidayListEntityCopyWith<$Res> {
  _$HolidayListEntityCopyWithImpl(this._self, this._then);

  final HolidayListEntity _self;
  final $Res Function(HolidayListEntity) _then;

/// Create a copy of HolidayListEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? holidayListName = null,Object? fromDate = null,Object? toDate = null,Object? totalHolidays = null,Object? customRestrictedHolidays = null,Object? holidays = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,holidayListName: null == holidayListName ? _self.holidayListName : holidayListName // ignore: cast_nullable_to_non_nullable
as String,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,totalHolidays: null == totalHolidays ? _self.totalHolidays : totalHolidays // ignore: cast_nullable_to_non_nullable
as int,customRestrictedHolidays: null == customRestrictedHolidays ? _self.customRestrictedHolidays : customRestrictedHolidays // ignore: cast_nullable_to_non_nullable
as List<RestrictedHolidayEntity>,holidays: null == holidays ? _self.holidays : holidays // ignore: cast_nullable_to_non_nullable
as List<HolidayEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [HolidayListEntity].
extension HolidayListEntityPatterns on HolidayListEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HolidayListEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HolidayListEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HolidayListEntity value)  $default,){
final _that = this;
switch (_that) {
case _HolidayListEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HolidayListEntity value)?  $default,){
final _that = this;
switch (_that) {
case _HolidayListEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String holidayListName,  String fromDate,  String toDate,  int totalHolidays,  List<RestrictedHolidayEntity> customRestrictedHolidays,  List<HolidayEntity> holidays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HolidayListEntity() when $default != null:
return $default(_that.name,_that.holidayListName,_that.fromDate,_that.toDate,_that.totalHolidays,_that.customRestrictedHolidays,_that.holidays);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String holidayListName,  String fromDate,  String toDate,  int totalHolidays,  List<RestrictedHolidayEntity> customRestrictedHolidays,  List<HolidayEntity> holidays)  $default,) {final _that = this;
switch (_that) {
case _HolidayListEntity():
return $default(_that.name,_that.holidayListName,_that.fromDate,_that.toDate,_that.totalHolidays,_that.customRestrictedHolidays,_that.holidays);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String holidayListName,  String fromDate,  String toDate,  int totalHolidays,  List<RestrictedHolidayEntity> customRestrictedHolidays,  List<HolidayEntity> holidays)?  $default,) {final _that = this;
switch (_that) {
case _HolidayListEntity() when $default != null:
return $default(_that.name,_that.holidayListName,_that.fromDate,_that.toDate,_that.totalHolidays,_that.customRestrictedHolidays,_that.holidays);case _:
  return null;

}
}

}

/// @nodoc


class _HolidayListEntity implements HolidayListEntity {
  const _HolidayListEntity({required this.name, required this.holidayListName, required this.fromDate, required this.toDate, required this.totalHolidays, required final  List<RestrictedHolidayEntity> customRestrictedHolidays, required final  List<HolidayEntity> holidays}): _customRestrictedHolidays = customRestrictedHolidays,_holidays = holidays;
  

@override final  String name;
@override final  String holidayListName;
@override final  String fromDate;
@override final  String toDate;
@override final  int totalHolidays;
 final  List<RestrictedHolidayEntity> _customRestrictedHolidays;
@override List<RestrictedHolidayEntity> get customRestrictedHolidays {
  if (_customRestrictedHolidays is EqualUnmodifiableListView) return _customRestrictedHolidays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_customRestrictedHolidays);
}

 final  List<HolidayEntity> _holidays;
@override List<HolidayEntity> get holidays {
  if (_holidays is EqualUnmodifiableListView) return _holidays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_holidays);
}


/// Create a copy of HolidayListEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HolidayListEntityCopyWith<_HolidayListEntity> get copyWith => __$HolidayListEntityCopyWithImpl<_HolidayListEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HolidayListEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.holidayListName, holidayListName) || other.holidayListName == holidayListName)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.totalHolidays, totalHolidays) || other.totalHolidays == totalHolidays)&&const DeepCollectionEquality().equals(other._customRestrictedHolidays, _customRestrictedHolidays)&&const DeepCollectionEquality().equals(other._holidays, _holidays));
}


@override
int get hashCode => Object.hash(runtimeType,name,holidayListName,fromDate,toDate,totalHolidays,const DeepCollectionEquality().hash(_customRestrictedHolidays),const DeepCollectionEquality().hash(_holidays));

@override
String toString() {
  return 'HolidayListEntity(name: $name, holidayListName: $holidayListName, fromDate: $fromDate, toDate: $toDate, totalHolidays: $totalHolidays, customRestrictedHolidays: $customRestrictedHolidays, holidays: $holidays)';
}


}

/// @nodoc
abstract mixin class _$HolidayListEntityCopyWith<$Res> implements $HolidayListEntityCopyWith<$Res> {
  factory _$HolidayListEntityCopyWith(_HolidayListEntity value, $Res Function(_HolidayListEntity) _then) = __$HolidayListEntityCopyWithImpl;
@override @useResult
$Res call({
 String name, String holidayListName, String fromDate, String toDate, int totalHolidays, List<RestrictedHolidayEntity> customRestrictedHolidays, List<HolidayEntity> holidays
});




}
/// @nodoc
class __$HolidayListEntityCopyWithImpl<$Res>
    implements _$HolidayListEntityCopyWith<$Res> {
  __$HolidayListEntityCopyWithImpl(this._self, this._then);

  final _HolidayListEntity _self;
  final $Res Function(_HolidayListEntity) _then;

/// Create a copy of HolidayListEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? holidayListName = null,Object? fromDate = null,Object? toDate = null,Object? totalHolidays = null,Object? customRestrictedHolidays = null,Object? holidays = null,}) {
  return _then(_HolidayListEntity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,holidayListName: null == holidayListName ? _self.holidayListName : holidayListName // ignore: cast_nullable_to_non_nullable
as String,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,totalHolidays: null == totalHolidays ? _self.totalHolidays : totalHolidays // ignore: cast_nullable_to_non_nullable
as int,customRestrictedHolidays: null == customRestrictedHolidays ? _self._customRestrictedHolidays : customRestrictedHolidays // ignore: cast_nullable_to_non_nullable
as List<RestrictedHolidayEntity>,holidays: null == holidays ? _self._holidays : holidays // ignore: cast_nullable_to_non_nullable
as List<HolidayEntity>,
  ));
}


}

/// @nodoc
mixin _$RestrictedHolidayEntity {

 String get name; String get holidayDate; String get description;
/// Create a copy of RestrictedHolidayEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RestrictedHolidayEntityCopyWith<RestrictedHolidayEntity> get copyWith => _$RestrictedHolidayEntityCopyWithImpl<RestrictedHolidayEntity>(this as RestrictedHolidayEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RestrictedHolidayEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.holidayDate, holidayDate) || other.holidayDate == holidayDate)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,name,holidayDate,description);

@override
String toString() {
  return 'RestrictedHolidayEntity(name: $name, holidayDate: $holidayDate, description: $description)';
}


}

/// @nodoc
abstract mixin class $RestrictedHolidayEntityCopyWith<$Res>  {
  factory $RestrictedHolidayEntityCopyWith(RestrictedHolidayEntity value, $Res Function(RestrictedHolidayEntity) _then) = _$RestrictedHolidayEntityCopyWithImpl;
@useResult
$Res call({
 String name, String holidayDate, String description
});




}
/// @nodoc
class _$RestrictedHolidayEntityCopyWithImpl<$Res>
    implements $RestrictedHolidayEntityCopyWith<$Res> {
  _$RestrictedHolidayEntityCopyWithImpl(this._self, this._then);

  final RestrictedHolidayEntity _self;
  final $Res Function(RestrictedHolidayEntity) _then;

/// Create a copy of RestrictedHolidayEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? holidayDate = null,Object? description = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,holidayDate: null == holidayDate ? _self.holidayDate : holidayDate // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RestrictedHolidayEntity].
extension RestrictedHolidayEntityPatterns on RestrictedHolidayEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RestrictedHolidayEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RestrictedHolidayEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RestrictedHolidayEntity value)  $default,){
final _that = this;
switch (_that) {
case _RestrictedHolidayEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RestrictedHolidayEntity value)?  $default,){
final _that = this;
switch (_that) {
case _RestrictedHolidayEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String holidayDate,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RestrictedHolidayEntity() when $default != null:
return $default(_that.name,_that.holidayDate,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String holidayDate,  String description)  $default,) {final _that = this;
switch (_that) {
case _RestrictedHolidayEntity():
return $default(_that.name,_that.holidayDate,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String holidayDate,  String description)?  $default,) {final _that = this;
switch (_that) {
case _RestrictedHolidayEntity() when $default != null:
return $default(_that.name,_that.holidayDate,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _RestrictedHolidayEntity implements RestrictedHolidayEntity {
  const _RestrictedHolidayEntity({required this.name, required this.holidayDate, required this.description});
  

@override final  String name;
@override final  String holidayDate;
@override final  String description;

/// Create a copy of RestrictedHolidayEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RestrictedHolidayEntityCopyWith<_RestrictedHolidayEntity> get copyWith => __$RestrictedHolidayEntityCopyWithImpl<_RestrictedHolidayEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RestrictedHolidayEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.holidayDate, holidayDate) || other.holidayDate == holidayDate)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,name,holidayDate,description);

@override
String toString() {
  return 'RestrictedHolidayEntity(name: $name, holidayDate: $holidayDate, description: $description)';
}


}

/// @nodoc
abstract mixin class _$RestrictedHolidayEntityCopyWith<$Res> implements $RestrictedHolidayEntityCopyWith<$Res> {
  factory _$RestrictedHolidayEntityCopyWith(_RestrictedHolidayEntity value, $Res Function(_RestrictedHolidayEntity) _then) = __$RestrictedHolidayEntityCopyWithImpl;
@override @useResult
$Res call({
 String name, String holidayDate, String description
});




}
/// @nodoc
class __$RestrictedHolidayEntityCopyWithImpl<$Res>
    implements _$RestrictedHolidayEntityCopyWith<$Res> {
  __$RestrictedHolidayEntityCopyWithImpl(this._self, this._then);

  final _RestrictedHolidayEntity _self;
  final $Res Function(_RestrictedHolidayEntity) _then;

/// Create a copy of RestrictedHolidayEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? holidayDate = null,Object? description = null,}) {
  return _then(_RestrictedHolidayEntity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,holidayDate: null == holidayDate ? _self.holidayDate : holidayDate // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$HolidayEntity {

 String get holidayDate; String get description; int get weeklyOff;
/// Create a copy of HolidayEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HolidayEntityCopyWith<HolidayEntity> get copyWith => _$HolidayEntityCopyWithImpl<HolidayEntity>(this as HolidayEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HolidayEntity&&(identical(other.holidayDate, holidayDate) || other.holidayDate == holidayDate)&&(identical(other.description, description) || other.description == description)&&(identical(other.weeklyOff, weeklyOff) || other.weeklyOff == weeklyOff));
}


@override
int get hashCode => Object.hash(runtimeType,holidayDate,description,weeklyOff);

@override
String toString() {
  return 'HolidayEntity(holidayDate: $holidayDate, description: $description, weeklyOff: $weeklyOff)';
}


}

/// @nodoc
abstract mixin class $HolidayEntityCopyWith<$Res>  {
  factory $HolidayEntityCopyWith(HolidayEntity value, $Res Function(HolidayEntity) _then) = _$HolidayEntityCopyWithImpl;
@useResult
$Res call({
 String holidayDate, String description, int weeklyOff
});




}
/// @nodoc
class _$HolidayEntityCopyWithImpl<$Res>
    implements $HolidayEntityCopyWith<$Res> {
  _$HolidayEntityCopyWithImpl(this._self, this._then);

  final HolidayEntity _self;
  final $Res Function(HolidayEntity) _then;

/// Create a copy of HolidayEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? holidayDate = null,Object? description = null,Object? weeklyOff = null,}) {
  return _then(_self.copyWith(
holidayDate: null == holidayDate ? _self.holidayDate : holidayDate // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,weeklyOff: null == weeklyOff ? _self.weeklyOff : weeklyOff // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [HolidayEntity].
extension HolidayEntityPatterns on HolidayEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HolidayEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HolidayEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HolidayEntity value)  $default,){
final _that = this;
switch (_that) {
case _HolidayEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HolidayEntity value)?  $default,){
final _that = this;
switch (_that) {
case _HolidayEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String holidayDate,  String description,  int weeklyOff)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HolidayEntity() when $default != null:
return $default(_that.holidayDate,_that.description,_that.weeklyOff);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String holidayDate,  String description,  int weeklyOff)  $default,) {final _that = this;
switch (_that) {
case _HolidayEntity():
return $default(_that.holidayDate,_that.description,_that.weeklyOff);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String holidayDate,  String description,  int weeklyOff)?  $default,) {final _that = this;
switch (_that) {
case _HolidayEntity() when $default != null:
return $default(_that.holidayDate,_that.description,_that.weeklyOff);case _:
  return null;

}
}

}

/// @nodoc


class _HolidayEntity implements HolidayEntity {
  const _HolidayEntity({required this.holidayDate, required this.description, required this.weeklyOff});
  

@override final  String holidayDate;
@override final  String description;
@override final  int weeklyOff;

/// Create a copy of HolidayEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HolidayEntityCopyWith<_HolidayEntity> get copyWith => __$HolidayEntityCopyWithImpl<_HolidayEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HolidayEntity&&(identical(other.holidayDate, holidayDate) || other.holidayDate == holidayDate)&&(identical(other.description, description) || other.description == description)&&(identical(other.weeklyOff, weeklyOff) || other.weeklyOff == weeklyOff));
}


@override
int get hashCode => Object.hash(runtimeType,holidayDate,description,weeklyOff);

@override
String toString() {
  return 'HolidayEntity(holidayDate: $holidayDate, description: $description, weeklyOff: $weeklyOff)';
}


}

/// @nodoc
abstract mixin class _$HolidayEntityCopyWith<$Res> implements $HolidayEntityCopyWith<$Res> {
  factory _$HolidayEntityCopyWith(_HolidayEntity value, $Res Function(_HolidayEntity) _then) = __$HolidayEntityCopyWithImpl;
@override @useResult
$Res call({
 String holidayDate, String description, int weeklyOff
});




}
/// @nodoc
class __$HolidayEntityCopyWithImpl<$Res>
    implements _$HolidayEntityCopyWith<$Res> {
  __$HolidayEntityCopyWithImpl(this._self, this._then);

  final _HolidayEntity _self;
  final $Res Function(_HolidayEntity) _then;

/// Create a copy of HolidayEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? holidayDate = null,Object? description = null,Object? weeklyOff = null,}) {
  return _then(_HolidayEntity(
holidayDate: null == holidayDate ? _self.holidayDate : holidayDate // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,weeklyOff: null == weeklyOff ? _self.weeklyOff : weeklyOff // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$LeavePolicyEntity {

 String get filePath; String get fileUrl;
/// Create a copy of LeavePolicyEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeavePolicyEntityCopyWith<LeavePolicyEntity> get copyWith => _$LeavePolicyEntityCopyWithImpl<LeavePolicyEntity>(this as LeavePolicyEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeavePolicyEntity&&(identical(other.filePath, filePath) || other.filePath == filePath)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl));
}


@override
int get hashCode => Object.hash(runtimeType,filePath,fileUrl);

@override
String toString() {
  return 'LeavePolicyEntity(filePath: $filePath, fileUrl: $fileUrl)';
}


}

/// @nodoc
abstract mixin class $LeavePolicyEntityCopyWith<$Res>  {
  factory $LeavePolicyEntityCopyWith(LeavePolicyEntity value, $Res Function(LeavePolicyEntity) _then) = _$LeavePolicyEntityCopyWithImpl;
@useResult
$Res call({
 String filePath, String fileUrl
});




}
/// @nodoc
class _$LeavePolicyEntityCopyWithImpl<$Res>
    implements $LeavePolicyEntityCopyWith<$Res> {
  _$LeavePolicyEntityCopyWithImpl(this._self, this._then);

  final LeavePolicyEntity _self;
  final $Res Function(LeavePolicyEntity) _then;

/// Create a copy of LeavePolicyEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? filePath = null,Object? fileUrl = null,}) {
  return _then(_self.copyWith(
filePath: null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,fileUrl: null == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LeavePolicyEntity].
extension LeavePolicyEntityPatterns on LeavePolicyEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeavePolicyEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeavePolicyEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeavePolicyEntity value)  $default,){
final _that = this;
switch (_that) {
case _LeavePolicyEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeavePolicyEntity value)?  $default,){
final _that = this;
switch (_that) {
case _LeavePolicyEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String filePath,  String fileUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeavePolicyEntity() when $default != null:
return $default(_that.filePath,_that.fileUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String filePath,  String fileUrl)  $default,) {final _that = this;
switch (_that) {
case _LeavePolicyEntity():
return $default(_that.filePath,_that.fileUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String filePath,  String fileUrl)?  $default,) {final _that = this;
switch (_that) {
case _LeavePolicyEntity() when $default != null:
return $default(_that.filePath,_that.fileUrl);case _:
  return null;

}
}

}

/// @nodoc


class _LeavePolicyEntity implements LeavePolicyEntity {
  const _LeavePolicyEntity({required this.filePath, required this.fileUrl});
  

@override final  String filePath;
@override final  String fileUrl;

/// Create a copy of LeavePolicyEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeavePolicyEntityCopyWith<_LeavePolicyEntity> get copyWith => __$LeavePolicyEntityCopyWithImpl<_LeavePolicyEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeavePolicyEntity&&(identical(other.filePath, filePath) || other.filePath == filePath)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl));
}


@override
int get hashCode => Object.hash(runtimeType,filePath,fileUrl);

@override
String toString() {
  return 'LeavePolicyEntity(filePath: $filePath, fileUrl: $fileUrl)';
}


}

/// @nodoc
abstract mixin class _$LeavePolicyEntityCopyWith<$Res> implements $LeavePolicyEntityCopyWith<$Res> {
  factory _$LeavePolicyEntityCopyWith(_LeavePolicyEntity value, $Res Function(_LeavePolicyEntity) _then) = __$LeavePolicyEntityCopyWithImpl;
@override @useResult
$Res call({
 String filePath, String fileUrl
});




}
/// @nodoc
class __$LeavePolicyEntityCopyWithImpl<$Res>
    implements _$LeavePolicyEntityCopyWith<$Res> {
  __$LeavePolicyEntityCopyWithImpl(this._self, this._then);

  final _LeavePolicyEntity _self;
  final $Res Function(_LeavePolicyEntity) _then;

/// Create a copy of LeavePolicyEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? filePath = null,Object? fileUrl = null,}) {
  return _then(_LeavePolicyEntity(
filePath: null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,fileUrl: null == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
