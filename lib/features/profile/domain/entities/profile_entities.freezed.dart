// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileEntity {

 String get fullName; String get firstName; String get lastName; String get email; String? get deskTheme; String? get userImage; String? get birthDate; String? get gender; String? get designation; String? get company; String? get department; String? get reportsTo; String? get employmentType; String? get companyEmail; String? get phone; String? get bloodGroup; String? get dateOfJoining; String? get employee; String? get customPayrollId; String? get reportsToName; String? get orgDepartment; String? get division; String? get maritalStatus; String? get docType; String? get namingSeries; String? get emergencyContact; List<ProfileProjectAssignmentEntity>? get projectAssignments; String? get empId;
/// Create a copy of ProfileEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileEntityCopyWith<ProfileEntity> get copyWith => _$ProfileEntityCopyWithImpl<ProfileEntity>(this as ProfileEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEntity&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.deskTheme, deskTheme) || other.deskTheme == deskTheme)&&(identical(other.userImage, userImage) || other.userImage == userImage)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.company, company) || other.company == company)&&(identical(other.department, department) || other.department == department)&&(identical(other.reportsTo, reportsTo) || other.reportsTo == reportsTo)&&(identical(other.employmentType, employmentType) || other.employmentType == employmentType)&&(identical(other.companyEmail, companyEmail) || other.companyEmail == companyEmail)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.bloodGroup, bloodGroup) || other.bloodGroup == bloodGroup)&&(identical(other.dateOfJoining, dateOfJoining) || other.dateOfJoining == dateOfJoining)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.customPayrollId, customPayrollId) || other.customPayrollId == customPayrollId)&&(identical(other.reportsToName, reportsToName) || other.reportsToName == reportsToName)&&(identical(other.orgDepartment, orgDepartment) || other.orgDepartment == orgDepartment)&&(identical(other.division, division) || other.division == division)&&(identical(other.maritalStatus, maritalStatus) || other.maritalStatus == maritalStatus)&&(identical(other.docType, docType) || other.docType == docType)&&(identical(other.namingSeries, namingSeries) || other.namingSeries == namingSeries)&&(identical(other.emergencyContact, emergencyContact) || other.emergencyContact == emergencyContact)&&const DeepCollectionEquality().equals(other.projectAssignments, projectAssignments)&&(identical(other.empId, empId) || other.empId == empId));
}


@override
int get hashCode => Object.hashAll([runtimeType,fullName,firstName,lastName,email,deskTheme,userImage,birthDate,gender,designation,company,department,reportsTo,employmentType,companyEmail,phone,bloodGroup,dateOfJoining,employee,customPayrollId,reportsToName,orgDepartment,division,maritalStatus,docType,namingSeries,emergencyContact,const DeepCollectionEquality().hash(projectAssignments),empId]);

@override
String toString() {
  return 'ProfileEntity(fullName: $fullName, firstName: $firstName, lastName: $lastName, email: $email, deskTheme: $deskTheme, userImage: $userImage, birthDate: $birthDate, gender: $gender, designation: $designation, company: $company, department: $department, reportsTo: $reportsTo, employmentType: $employmentType, companyEmail: $companyEmail, phone: $phone, bloodGroup: $bloodGroup, dateOfJoining: $dateOfJoining, employee: $employee, customPayrollId: $customPayrollId, reportsToName: $reportsToName, orgDepartment: $orgDepartment, division: $division, maritalStatus: $maritalStatus, docType: $docType, namingSeries: $namingSeries, emergencyContact: $emergencyContact, projectAssignments: $projectAssignments, empId: $empId)';
}


}

/// @nodoc
abstract mixin class $ProfileEntityCopyWith<$Res>  {
  factory $ProfileEntityCopyWith(ProfileEntity value, $Res Function(ProfileEntity) _then) = _$ProfileEntityCopyWithImpl;
@useResult
$Res call({
 String fullName, String firstName, String lastName, String email, String? deskTheme, String? userImage, String? birthDate, String? gender, String? designation, String? company, String? department, String? reportsTo, String? employmentType, String? companyEmail, String? phone, String? bloodGroup, String? dateOfJoining, String? employee, String? customPayrollId, String? reportsToName, String? orgDepartment, String? division, String? maritalStatus, String? docType, String? namingSeries, String? emergencyContact, List<ProfileProjectAssignmentEntity>? projectAssignments, String? empId
});




}
/// @nodoc
class _$ProfileEntityCopyWithImpl<$Res>
    implements $ProfileEntityCopyWith<$Res> {
  _$ProfileEntityCopyWithImpl(this._self, this._then);

  final ProfileEntity _self;
  final $Res Function(ProfileEntity) _then;

/// Create a copy of ProfileEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = null,Object? firstName = null,Object? lastName = null,Object? email = null,Object? deskTheme = freezed,Object? userImage = freezed,Object? birthDate = freezed,Object? gender = freezed,Object? designation = freezed,Object? company = freezed,Object? department = freezed,Object? reportsTo = freezed,Object? employmentType = freezed,Object? companyEmail = freezed,Object? phone = freezed,Object? bloodGroup = freezed,Object? dateOfJoining = freezed,Object? employee = freezed,Object? customPayrollId = freezed,Object? reportsToName = freezed,Object? orgDepartment = freezed,Object? division = freezed,Object? maritalStatus = freezed,Object? docType = freezed,Object? namingSeries = freezed,Object? emergencyContact = freezed,Object? projectAssignments = freezed,Object? empId = freezed,}) {
  return _then(_self.copyWith(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,deskTheme: freezed == deskTheme ? _self.deskTheme : deskTheme // ignore: cast_nullable_to_non_nullable
as String?,userImage: freezed == userImage ? _self.userImage : userImage // ignore: cast_nullable_to_non_nullable
as String?,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,company: freezed == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String?,department: freezed == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String?,reportsTo: freezed == reportsTo ? _self.reportsTo : reportsTo // ignore: cast_nullable_to_non_nullable
as String?,employmentType: freezed == employmentType ? _self.employmentType : employmentType // ignore: cast_nullable_to_non_nullable
as String?,companyEmail: freezed == companyEmail ? _self.companyEmail : companyEmail // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,bloodGroup: freezed == bloodGroup ? _self.bloodGroup : bloodGroup // ignore: cast_nullable_to_non_nullable
as String?,dateOfJoining: freezed == dateOfJoining ? _self.dateOfJoining : dateOfJoining // ignore: cast_nullable_to_non_nullable
as String?,employee: freezed == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as String?,customPayrollId: freezed == customPayrollId ? _self.customPayrollId : customPayrollId // ignore: cast_nullable_to_non_nullable
as String?,reportsToName: freezed == reportsToName ? _self.reportsToName : reportsToName // ignore: cast_nullable_to_non_nullable
as String?,orgDepartment: freezed == orgDepartment ? _self.orgDepartment : orgDepartment // ignore: cast_nullable_to_non_nullable
as String?,division: freezed == division ? _self.division : division // ignore: cast_nullable_to_non_nullable
as String?,maritalStatus: freezed == maritalStatus ? _self.maritalStatus : maritalStatus // ignore: cast_nullable_to_non_nullable
as String?,docType: freezed == docType ? _self.docType : docType // ignore: cast_nullable_to_non_nullable
as String?,namingSeries: freezed == namingSeries ? _self.namingSeries : namingSeries // ignore: cast_nullable_to_non_nullable
as String?,emergencyContact: freezed == emergencyContact ? _self.emergencyContact : emergencyContact // ignore: cast_nullable_to_non_nullable
as String?,projectAssignments: freezed == projectAssignments ? _self.projectAssignments : projectAssignments // ignore: cast_nullable_to_non_nullable
as List<ProfileProjectAssignmentEntity>?,empId: freezed == empId ? _self.empId : empId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileEntity].
extension ProfileEntityPatterns on ProfileEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileEntity value)  $default,){
final _that = this;
switch (_that) {
case _ProfileEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fullName,  String firstName,  String lastName,  String email,  String? deskTheme,  String? userImage,  String? birthDate,  String? gender,  String? designation,  String? company,  String? department,  String? reportsTo,  String? employmentType,  String? companyEmail,  String? phone,  String? bloodGroup,  String? dateOfJoining,  String? employee,  String? customPayrollId,  String? reportsToName,  String? orgDepartment,  String? division,  String? maritalStatus,  String? docType,  String? namingSeries,  String? emergencyContact,  List<ProfileProjectAssignmentEntity>? projectAssignments,  String? empId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileEntity() when $default != null:
return $default(_that.fullName,_that.firstName,_that.lastName,_that.email,_that.deskTheme,_that.userImage,_that.birthDate,_that.gender,_that.designation,_that.company,_that.department,_that.reportsTo,_that.employmentType,_that.companyEmail,_that.phone,_that.bloodGroup,_that.dateOfJoining,_that.employee,_that.customPayrollId,_that.reportsToName,_that.orgDepartment,_that.division,_that.maritalStatus,_that.docType,_that.namingSeries,_that.emergencyContact,_that.projectAssignments,_that.empId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fullName,  String firstName,  String lastName,  String email,  String? deskTheme,  String? userImage,  String? birthDate,  String? gender,  String? designation,  String? company,  String? department,  String? reportsTo,  String? employmentType,  String? companyEmail,  String? phone,  String? bloodGroup,  String? dateOfJoining,  String? employee,  String? customPayrollId,  String? reportsToName,  String? orgDepartment,  String? division,  String? maritalStatus,  String? docType,  String? namingSeries,  String? emergencyContact,  List<ProfileProjectAssignmentEntity>? projectAssignments,  String? empId)  $default,) {final _that = this;
switch (_that) {
case _ProfileEntity():
return $default(_that.fullName,_that.firstName,_that.lastName,_that.email,_that.deskTheme,_that.userImage,_that.birthDate,_that.gender,_that.designation,_that.company,_that.department,_that.reportsTo,_that.employmentType,_that.companyEmail,_that.phone,_that.bloodGroup,_that.dateOfJoining,_that.employee,_that.customPayrollId,_that.reportsToName,_that.orgDepartment,_that.division,_that.maritalStatus,_that.docType,_that.namingSeries,_that.emergencyContact,_that.projectAssignments,_that.empId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fullName,  String firstName,  String lastName,  String email,  String? deskTheme,  String? userImage,  String? birthDate,  String? gender,  String? designation,  String? company,  String? department,  String? reportsTo,  String? employmentType,  String? companyEmail,  String? phone,  String? bloodGroup,  String? dateOfJoining,  String? employee,  String? customPayrollId,  String? reportsToName,  String? orgDepartment,  String? division,  String? maritalStatus,  String? docType,  String? namingSeries,  String? emergencyContact,  List<ProfileProjectAssignmentEntity>? projectAssignments,  String? empId)?  $default,) {final _that = this;
switch (_that) {
case _ProfileEntity() when $default != null:
return $default(_that.fullName,_that.firstName,_that.lastName,_that.email,_that.deskTheme,_that.userImage,_that.birthDate,_that.gender,_that.designation,_that.company,_that.department,_that.reportsTo,_that.employmentType,_that.companyEmail,_that.phone,_that.bloodGroup,_that.dateOfJoining,_that.employee,_that.customPayrollId,_that.reportsToName,_that.orgDepartment,_that.division,_that.maritalStatus,_that.docType,_that.namingSeries,_that.emergencyContact,_that.projectAssignments,_that.empId);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileEntity extends ProfileEntity {
  const _ProfileEntity({required this.fullName, required this.firstName, required this.lastName, required this.email, this.deskTheme, this.userImage, this.birthDate, this.gender, this.designation, this.company, this.department, this.reportsTo, this.employmentType, this.companyEmail, this.phone, this.bloodGroup, this.dateOfJoining, this.employee, this.customPayrollId, this.reportsToName, this.orgDepartment, this.division, this.maritalStatus, this.docType, this.namingSeries, this.emergencyContact, final  List<ProfileProjectAssignmentEntity>? projectAssignments, this.empId}): _projectAssignments = projectAssignments,super._();
  

@override final  String fullName;
@override final  String firstName;
@override final  String lastName;
@override final  String email;
@override final  String? deskTheme;
@override final  String? userImage;
@override final  String? birthDate;
@override final  String? gender;
@override final  String? designation;
@override final  String? company;
@override final  String? department;
@override final  String? reportsTo;
@override final  String? employmentType;
@override final  String? companyEmail;
@override final  String? phone;
@override final  String? bloodGroup;
@override final  String? dateOfJoining;
@override final  String? employee;
@override final  String? customPayrollId;
@override final  String? reportsToName;
@override final  String? orgDepartment;
@override final  String? division;
@override final  String? maritalStatus;
@override final  String? docType;
@override final  String? namingSeries;
@override final  String? emergencyContact;
 final  List<ProfileProjectAssignmentEntity>? _projectAssignments;
@override List<ProfileProjectAssignmentEntity>? get projectAssignments {
  final value = _projectAssignments;
  if (value == null) return null;
  if (_projectAssignments is EqualUnmodifiableListView) return _projectAssignments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? empId;

/// Create a copy of ProfileEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileEntityCopyWith<_ProfileEntity> get copyWith => __$ProfileEntityCopyWithImpl<_ProfileEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileEntity&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.deskTheme, deskTheme) || other.deskTheme == deskTheme)&&(identical(other.userImage, userImage) || other.userImage == userImage)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.company, company) || other.company == company)&&(identical(other.department, department) || other.department == department)&&(identical(other.reportsTo, reportsTo) || other.reportsTo == reportsTo)&&(identical(other.employmentType, employmentType) || other.employmentType == employmentType)&&(identical(other.companyEmail, companyEmail) || other.companyEmail == companyEmail)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.bloodGroup, bloodGroup) || other.bloodGroup == bloodGroup)&&(identical(other.dateOfJoining, dateOfJoining) || other.dateOfJoining == dateOfJoining)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.customPayrollId, customPayrollId) || other.customPayrollId == customPayrollId)&&(identical(other.reportsToName, reportsToName) || other.reportsToName == reportsToName)&&(identical(other.orgDepartment, orgDepartment) || other.orgDepartment == orgDepartment)&&(identical(other.division, division) || other.division == division)&&(identical(other.maritalStatus, maritalStatus) || other.maritalStatus == maritalStatus)&&(identical(other.docType, docType) || other.docType == docType)&&(identical(other.namingSeries, namingSeries) || other.namingSeries == namingSeries)&&(identical(other.emergencyContact, emergencyContact) || other.emergencyContact == emergencyContact)&&const DeepCollectionEquality().equals(other._projectAssignments, _projectAssignments)&&(identical(other.empId, empId) || other.empId == empId));
}


@override
int get hashCode => Object.hashAll([runtimeType,fullName,firstName,lastName,email,deskTheme,userImage,birthDate,gender,designation,company,department,reportsTo,employmentType,companyEmail,phone,bloodGroup,dateOfJoining,employee,customPayrollId,reportsToName,orgDepartment,division,maritalStatus,docType,namingSeries,emergencyContact,const DeepCollectionEquality().hash(_projectAssignments),empId]);

@override
String toString() {
  return 'ProfileEntity(fullName: $fullName, firstName: $firstName, lastName: $lastName, email: $email, deskTheme: $deskTheme, userImage: $userImage, birthDate: $birthDate, gender: $gender, designation: $designation, company: $company, department: $department, reportsTo: $reportsTo, employmentType: $employmentType, companyEmail: $companyEmail, phone: $phone, bloodGroup: $bloodGroup, dateOfJoining: $dateOfJoining, employee: $employee, customPayrollId: $customPayrollId, reportsToName: $reportsToName, orgDepartment: $orgDepartment, division: $division, maritalStatus: $maritalStatus, docType: $docType, namingSeries: $namingSeries, emergencyContact: $emergencyContact, projectAssignments: $projectAssignments, empId: $empId)';
}


}

/// @nodoc
abstract mixin class _$ProfileEntityCopyWith<$Res> implements $ProfileEntityCopyWith<$Res> {
  factory _$ProfileEntityCopyWith(_ProfileEntity value, $Res Function(_ProfileEntity) _then) = __$ProfileEntityCopyWithImpl;
@override @useResult
$Res call({
 String fullName, String firstName, String lastName, String email, String? deskTheme, String? userImage, String? birthDate, String? gender, String? designation, String? company, String? department, String? reportsTo, String? employmentType, String? companyEmail, String? phone, String? bloodGroup, String? dateOfJoining, String? employee, String? customPayrollId, String? reportsToName, String? orgDepartment, String? division, String? maritalStatus, String? docType, String? namingSeries, String? emergencyContact, List<ProfileProjectAssignmentEntity>? projectAssignments, String? empId
});




}
/// @nodoc
class __$ProfileEntityCopyWithImpl<$Res>
    implements _$ProfileEntityCopyWith<$Res> {
  __$ProfileEntityCopyWithImpl(this._self, this._then);

  final _ProfileEntity _self;
  final $Res Function(_ProfileEntity) _then;

/// Create a copy of ProfileEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = null,Object? firstName = null,Object? lastName = null,Object? email = null,Object? deskTheme = freezed,Object? userImage = freezed,Object? birthDate = freezed,Object? gender = freezed,Object? designation = freezed,Object? company = freezed,Object? department = freezed,Object? reportsTo = freezed,Object? employmentType = freezed,Object? companyEmail = freezed,Object? phone = freezed,Object? bloodGroup = freezed,Object? dateOfJoining = freezed,Object? employee = freezed,Object? customPayrollId = freezed,Object? reportsToName = freezed,Object? orgDepartment = freezed,Object? division = freezed,Object? maritalStatus = freezed,Object? docType = freezed,Object? namingSeries = freezed,Object? emergencyContact = freezed,Object? projectAssignments = freezed,Object? empId = freezed,}) {
  return _then(_ProfileEntity(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,deskTheme: freezed == deskTheme ? _self.deskTheme : deskTheme // ignore: cast_nullable_to_non_nullable
as String?,userImage: freezed == userImage ? _self.userImage : userImage // ignore: cast_nullable_to_non_nullable
as String?,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,company: freezed == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String?,department: freezed == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String?,reportsTo: freezed == reportsTo ? _self.reportsTo : reportsTo // ignore: cast_nullable_to_non_nullable
as String?,employmentType: freezed == employmentType ? _self.employmentType : employmentType // ignore: cast_nullable_to_non_nullable
as String?,companyEmail: freezed == companyEmail ? _self.companyEmail : companyEmail // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,bloodGroup: freezed == bloodGroup ? _self.bloodGroup : bloodGroup // ignore: cast_nullable_to_non_nullable
as String?,dateOfJoining: freezed == dateOfJoining ? _self.dateOfJoining : dateOfJoining // ignore: cast_nullable_to_non_nullable
as String?,employee: freezed == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as String?,customPayrollId: freezed == customPayrollId ? _self.customPayrollId : customPayrollId // ignore: cast_nullable_to_non_nullable
as String?,reportsToName: freezed == reportsToName ? _self.reportsToName : reportsToName // ignore: cast_nullable_to_non_nullable
as String?,orgDepartment: freezed == orgDepartment ? _self.orgDepartment : orgDepartment // ignore: cast_nullable_to_non_nullable
as String?,division: freezed == division ? _self.division : division // ignore: cast_nullable_to_non_nullable
as String?,maritalStatus: freezed == maritalStatus ? _self.maritalStatus : maritalStatus // ignore: cast_nullable_to_non_nullable
as String?,docType: freezed == docType ? _self.docType : docType // ignore: cast_nullable_to_non_nullable
as String?,namingSeries: freezed == namingSeries ? _self.namingSeries : namingSeries // ignore: cast_nullable_to_non_nullable
as String?,emergencyContact: freezed == emergencyContact ? _self.emergencyContact : emergencyContact // ignore: cast_nullable_to_non_nullable
as String?,projectAssignments: freezed == projectAssignments ? _self._projectAssignments : projectAssignments // ignore: cast_nullable_to_non_nullable
as List<ProfileProjectAssignmentEntity>?,empId: freezed == empId ? _self.empId : empId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
