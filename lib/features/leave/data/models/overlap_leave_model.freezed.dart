// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'overlap_leave_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OverlapLeaveModel {

 String get id; OverlapEmployeeModel get employee;@JsonKey(name: 'shared_projects') List<String>? get sharedProjects;@JsonKey(name: 'leave_type') String get leaveType;@JsonKey(name: 'from_date') String get fromDate;@JsonKey(name: 'to_date') String get toDate;@JsonKey(name: 'days') double get days; String get status; String? get description; String? get posting_date; String? get modified;
/// Create a copy of OverlapLeaveModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OverlapLeaveModelCopyWith<OverlapLeaveModel> get copyWith => _$OverlapLeaveModelCopyWithImpl<OverlapLeaveModel>(this as OverlapLeaveModel, _$identity);

  /// Serializes this OverlapLeaveModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OverlapLeaveModel&&(identical(other.id, id) || other.id == id)&&(identical(other.employee, employee) || other.employee == employee)&&const DeepCollectionEquality().equals(other.sharedProjects, sharedProjects)&&(identical(other.leaveType, leaveType) || other.leaveType == leaveType)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.days, days) || other.days == days)&&(identical(other.status, status) || other.status == status)&&(identical(other.description, description) || other.description == description)&&(identical(other.posting_date, posting_date) || other.posting_date == posting_date)&&(identical(other.modified, modified) || other.modified == modified));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,employee,const DeepCollectionEquality().hash(sharedProjects),leaveType,fromDate,toDate,days,status,description,posting_date,modified);

@override
String toString() {
  return 'OverlapLeaveModel(id: $id, employee: $employee, sharedProjects: $sharedProjects, leaveType: $leaveType, fromDate: $fromDate, toDate: $toDate, days: $days, status: $status, description: $description, posting_date: $posting_date, modified: $modified)';
}


}

/// @nodoc
abstract mixin class $OverlapLeaveModelCopyWith<$Res>  {
  factory $OverlapLeaveModelCopyWith(OverlapLeaveModel value, $Res Function(OverlapLeaveModel) _then) = _$OverlapLeaveModelCopyWithImpl;
@useResult
$Res call({
 String id, OverlapEmployeeModel employee,@JsonKey(name: 'shared_projects') List<String>? sharedProjects,@JsonKey(name: 'leave_type') String leaveType,@JsonKey(name: 'from_date') String fromDate,@JsonKey(name: 'to_date') String toDate,@JsonKey(name: 'days') double days, String status, String? description, String? posting_date, String? modified
});


$OverlapEmployeeModelCopyWith<$Res> get employee;

}
/// @nodoc
class _$OverlapLeaveModelCopyWithImpl<$Res>
    implements $OverlapLeaveModelCopyWith<$Res> {
  _$OverlapLeaveModelCopyWithImpl(this._self, this._then);

  final OverlapLeaveModel _self;
  final $Res Function(OverlapLeaveModel) _then;

/// Create a copy of OverlapLeaveModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? employee = null,Object? sharedProjects = freezed,Object? leaveType = null,Object? fromDate = null,Object? toDate = null,Object? days = null,Object? status = null,Object? description = freezed,Object? posting_date = freezed,Object? modified = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,employee: null == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as OverlapEmployeeModel,sharedProjects: freezed == sharedProjects ? _self.sharedProjects : sharedProjects // ignore: cast_nullable_to_non_nullable
as List<String>?,leaveType: null == leaveType ? _self.leaveType : leaveType // ignore: cast_nullable_to_non_nullable
as String,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,posting_date: freezed == posting_date ? _self.posting_date : posting_date // ignore: cast_nullable_to_non_nullable
as String?,modified: freezed == modified ? _self.modified : modified // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of OverlapLeaveModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OverlapEmployeeModelCopyWith<$Res> get employee {
  
  return $OverlapEmployeeModelCopyWith<$Res>(_self.employee, (value) {
    return _then(_self.copyWith(employee: value));
  });
}
}


/// Adds pattern-matching-related methods to [OverlapLeaveModel].
extension OverlapLeaveModelPatterns on OverlapLeaveModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OverlapLeaveModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OverlapLeaveModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OverlapLeaveModel value)  $default,){
final _that = this;
switch (_that) {
case _OverlapLeaveModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OverlapLeaveModel value)?  $default,){
final _that = this;
switch (_that) {
case _OverlapLeaveModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  OverlapEmployeeModel employee, @JsonKey(name: 'shared_projects')  List<String>? sharedProjects, @JsonKey(name: 'leave_type')  String leaveType, @JsonKey(name: 'from_date')  String fromDate, @JsonKey(name: 'to_date')  String toDate, @JsonKey(name: 'days')  double days,  String status,  String? description,  String? posting_date,  String? modified)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OverlapLeaveModel() when $default != null:
return $default(_that.id,_that.employee,_that.sharedProjects,_that.leaveType,_that.fromDate,_that.toDate,_that.days,_that.status,_that.description,_that.posting_date,_that.modified);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  OverlapEmployeeModel employee, @JsonKey(name: 'shared_projects')  List<String>? sharedProjects, @JsonKey(name: 'leave_type')  String leaveType, @JsonKey(name: 'from_date')  String fromDate, @JsonKey(name: 'to_date')  String toDate, @JsonKey(name: 'days')  double days,  String status,  String? description,  String? posting_date,  String? modified)  $default,) {final _that = this;
switch (_that) {
case _OverlapLeaveModel():
return $default(_that.id,_that.employee,_that.sharedProjects,_that.leaveType,_that.fromDate,_that.toDate,_that.days,_that.status,_that.description,_that.posting_date,_that.modified);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  OverlapEmployeeModel employee, @JsonKey(name: 'shared_projects')  List<String>? sharedProjects, @JsonKey(name: 'leave_type')  String leaveType, @JsonKey(name: 'from_date')  String fromDate, @JsonKey(name: 'to_date')  String toDate, @JsonKey(name: 'days')  double days,  String status,  String? description,  String? posting_date,  String? modified)?  $default,) {final _that = this;
switch (_that) {
case _OverlapLeaveModel() when $default != null:
return $default(_that.id,_that.employee,_that.sharedProjects,_that.leaveType,_that.fromDate,_that.toDate,_that.days,_that.status,_that.description,_that.posting_date,_that.modified);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OverlapLeaveModel extends OverlapLeaveModel {
  const _OverlapLeaveModel({required this.id, required this.employee, @JsonKey(name: 'shared_projects') final  List<String>? sharedProjects, @JsonKey(name: 'leave_type') required this.leaveType, @JsonKey(name: 'from_date') required this.fromDate, @JsonKey(name: 'to_date') required this.toDate, @JsonKey(name: 'days') required this.days, required this.status, this.description, this.posting_date, this.modified}): _sharedProjects = sharedProjects,super._();
  factory _OverlapLeaveModel.fromJson(Map<String, dynamic> json) => _$OverlapLeaveModelFromJson(json);

@override final  String id;
@override final  OverlapEmployeeModel employee;
 final  List<String>? _sharedProjects;
@override@JsonKey(name: 'shared_projects') List<String>? get sharedProjects {
  final value = _sharedProjects;
  if (value == null) return null;
  if (_sharedProjects is EqualUnmodifiableListView) return _sharedProjects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'leave_type') final  String leaveType;
@override@JsonKey(name: 'from_date') final  String fromDate;
@override@JsonKey(name: 'to_date') final  String toDate;
@override@JsonKey(name: 'days') final  double days;
@override final  String status;
@override final  String? description;
@override final  String? posting_date;
@override final  String? modified;

/// Create a copy of OverlapLeaveModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OverlapLeaveModelCopyWith<_OverlapLeaveModel> get copyWith => __$OverlapLeaveModelCopyWithImpl<_OverlapLeaveModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OverlapLeaveModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OverlapLeaveModel&&(identical(other.id, id) || other.id == id)&&(identical(other.employee, employee) || other.employee == employee)&&const DeepCollectionEquality().equals(other._sharedProjects, _sharedProjects)&&(identical(other.leaveType, leaveType) || other.leaveType == leaveType)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.days, days) || other.days == days)&&(identical(other.status, status) || other.status == status)&&(identical(other.description, description) || other.description == description)&&(identical(other.posting_date, posting_date) || other.posting_date == posting_date)&&(identical(other.modified, modified) || other.modified == modified));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,employee,const DeepCollectionEquality().hash(_sharedProjects),leaveType,fromDate,toDate,days,status,description,posting_date,modified);

@override
String toString() {
  return 'OverlapLeaveModel(id: $id, employee: $employee, sharedProjects: $sharedProjects, leaveType: $leaveType, fromDate: $fromDate, toDate: $toDate, days: $days, status: $status, description: $description, posting_date: $posting_date, modified: $modified)';
}


}

/// @nodoc
abstract mixin class _$OverlapLeaveModelCopyWith<$Res> implements $OverlapLeaveModelCopyWith<$Res> {
  factory _$OverlapLeaveModelCopyWith(_OverlapLeaveModel value, $Res Function(_OverlapLeaveModel) _then) = __$OverlapLeaveModelCopyWithImpl;
@override @useResult
$Res call({
 String id, OverlapEmployeeModel employee,@JsonKey(name: 'shared_projects') List<String>? sharedProjects,@JsonKey(name: 'leave_type') String leaveType,@JsonKey(name: 'from_date') String fromDate,@JsonKey(name: 'to_date') String toDate,@JsonKey(name: 'days') double days, String status, String? description, String? posting_date, String? modified
});


@override $OverlapEmployeeModelCopyWith<$Res> get employee;

}
/// @nodoc
class __$OverlapLeaveModelCopyWithImpl<$Res>
    implements _$OverlapLeaveModelCopyWith<$Res> {
  __$OverlapLeaveModelCopyWithImpl(this._self, this._then);

  final _OverlapLeaveModel _self;
  final $Res Function(_OverlapLeaveModel) _then;

/// Create a copy of OverlapLeaveModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? employee = null,Object? sharedProjects = freezed,Object? leaveType = null,Object? fromDate = null,Object? toDate = null,Object? days = null,Object? status = null,Object? description = freezed,Object? posting_date = freezed,Object? modified = freezed,}) {
  return _then(_OverlapLeaveModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,employee: null == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as OverlapEmployeeModel,sharedProjects: freezed == sharedProjects ? _self._sharedProjects : sharedProjects // ignore: cast_nullable_to_non_nullable
as List<String>?,leaveType: null == leaveType ? _self.leaveType : leaveType // ignore: cast_nullable_to_non_nullable
as String,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,posting_date: freezed == posting_date ? _self.posting_date : posting_date // ignore: cast_nullable_to_non_nullable
as String?,modified: freezed == modified ? _self.modified : modified // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of OverlapLeaveModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OverlapEmployeeModelCopyWith<$Res> get employee {
  
  return $OverlapEmployeeModelCopyWith<$Res>(_self.employee, (value) {
    return _then(_self.copyWith(employee: value));
  });
}
}


/// @nodoc
mixin _$OverlapEmployeeModel {

 String get id; String get name; String get designation; String? get image; String? get department;
/// Create a copy of OverlapEmployeeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OverlapEmployeeModelCopyWith<OverlapEmployeeModel> get copyWith => _$OverlapEmployeeModelCopyWithImpl<OverlapEmployeeModel>(this as OverlapEmployeeModel, _$identity);

  /// Serializes this OverlapEmployeeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OverlapEmployeeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.image, image) || other.image == image)&&(identical(other.department, department) || other.department == department));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,designation,image,department);

@override
String toString() {
  return 'OverlapEmployeeModel(id: $id, name: $name, designation: $designation, image: $image, department: $department)';
}


}

/// @nodoc
abstract mixin class $OverlapEmployeeModelCopyWith<$Res>  {
  factory $OverlapEmployeeModelCopyWith(OverlapEmployeeModel value, $Res Function(OverlapEmployeeModel) _then) = _$OverlapEmployeeModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String designation, String? image, String? department
});




}
/// @nodoc
class _$OverlapEmployeeModelCopyWithImpl<$Res>
    implements $OverlapEmployeeModelCopyWith<$Res> {
  _$OverlapEmployeeModelCopyWithImpl(this._self, this._then);

  final OverlapEmployeeModel _self;
  final $Res Function(OverlapEmployeeModel) _then;

/// Create a copy of OverlapEmployeeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? designation = null,Object? image = freezed,Object? department = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,designation: null == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,department: freezed == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OverlapEmployeeModel].
extension OverlapEmployeeModelPatterns on OverlapEmployeeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OverlapEmployeeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OverlapEmployeeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OverlapEmployeeModel value)  $default,){
final _that = this;
switch (_that) {
case _OverlapEmployeeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OverlapEmployeeModel value)?  $default,){
final _that = this;
switch (_that) {
case _OverlapEmployeeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String designation,  String? image,  String? department)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OverlapEmployeeModel() when $default != null:
return $default(_that.id,_that.name,_that.designation,_that.image,_that.department);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String designation,  String? image,  String? department)  $default,) {final _that = this;
switch (_that) {
case _OverlapEmployeeModel():
return $default(_that.id,_that.name,_that.designation,_that.image,_that.department);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String designation,  String? image,  String? department)?  $default,) {final _that = this;
switch (_that) {
case _OverlapEmployeeModel() when $default != null:
return $default(_that.id,_that.name,_that.designation,_that.image,_that.department);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OverlapEmployeeModel implements OverlapEmployeeModel {
  const _OverlapEmployeeModel({required this.id, required this.name, required this.designation, this.image, this.department});
  factory _OverlapEmployeeModel.fromJson(Map<String, dynamic> json) => _$OverlapEmployeeModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String designation;
@override final  String? image;
@override final  String? department;

/// Create a copy of OverlapEmployeeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OverlapEmployeeModelCopyWith<_OverlapEmployeeModel> get copyWith => __$OverlapEmployeeModelCopyWithImpl<_OverlapEmployeeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OverlapEmployeeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OverlapEmployeeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.image, image) || other.image == image)&&(identical(other.department, department) || other.department == department));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,designation,image,department);

@override
String toString() {
  return 'OverlapEmployeeModel(id: $id, name: $name, designation: $designation, image: $image, department: $department)';
}


}

/// @nodoc
abstract mixin class _$OverlapEmployeeModelCopyWith<$Res> implements $OverlapEmployeeModelCopyWith<$Res> {
  factory _$OverlapEmployeeModelCopyWith(_OverlapEmployeeModel value, $Res Function(_OverlapEmployeeModel) _then) = __$OverlapEmployeeModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String designation, String? image, String? department
});




}
/// @nodoc
class __$OverlapEmployeeModelCopyWithImpl<$Res>
    implements _$OverlapEmployeeModelCopyWith<$Res> {
  __$OverlapEmployeeModelCopyWithImpl(this._self, this._then);

  final _OverlapEmployeeModel _self;
  final $Res Function(_OverlapEmployeeModel) _then;

/// Create a copy of OverlapEmployeeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? designation = null,Object? image = freezed,Object? department = freezed,}) {
  return _then(_OverlapEmployeeModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,designation: null == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,department: freezed == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
