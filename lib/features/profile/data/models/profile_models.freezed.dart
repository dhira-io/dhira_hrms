// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProfileModel {

@JsonKey(name: 'employee_name') String get fullName;@JsonKey(name: 'first_name') String get firstName;@JsonKey(name: 'last_name') String get lastName;@JsonKey(name: 'user_id') String get email;@JsonKey(name: 'desk_theme') String? get deskTheme;@JsonKey(name: 'image') String? get userImage;@JsonKey(name: 'date_of_birth') String? get birthDate; String? get gender; String? get designation; String? get company; String? get department;@JsonKey(name: 'reports_to') String? get reportsTo;@JsonKey(name: 'status') String? get employmentType;@JsonKey(name: 'company_email') String? get companyEmail;@JsonKey(name: 'cell_number') String? get phone;@JsonKey(name: 'blood_group') String? get bloodGroup;@JsonKey(name: 'date_of_joining') String? get dateOfJoining;@JsonKey(name: 'employee') String? get employee;@JsonKey(name: 'custom_payroll_id') String? get customPayrollId;@JsonKey(name: 'custom_report_to_name') String? get reportsToName;@JsonKey(name: 'custom_organization_department') String? get orgDepartment;@JsonKey(name: 'custom_division') String? get division;@JsonKey(name: 'marital_status') String? get maritalStatus;@JsonKey(name: 'doctype') String? get docType;@JsonKey(name: 'naming_series') String? get namingSeries;@JsonKey(name: 'emergency_contact_name') String? get emergencyContact;@JsonKey(name: 'custom_employee_assignment') List<ProfileProjectAssignmentModel>? get projectAssignments;@JsonKey(name: 'name') String? get empId;
/// Create a copy of ProfileModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileModelCopyWith<ProfileModel> get copyWith => _$ProfileModelCopyWithImpl<ProfileModel>(this as ProfileModel, _$identity);

  /// Serializes this ProfileModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileModel&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.deskTheme, deskTheme) || other.deskTheme == deskTheme)&&(identical(other.userImage, userImage) || other.userImage == userImage)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.company, company) || other.company == company)&&(identical(other.department, department) || other.department == department)&&(identical(other.reportsTo, reportsTo) || other.reportsTo == reportsTo)&&(identical(other.employmentType, employmentType) || other.employmentType == employmentType)&&(identical(other.companyEmail, companyEmail) || other.companyEmail == companyEmail)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.bloodGroup, bloodGroup) || other.bloodGroup == bloodGroup)&&(identical(other.dateOfJoining, dateOfJoining) || other.dateOfJoining == dateOfJoining)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.customPayrollId, customPayrollId) || other.customPayrollId == customPayrollId)&&(identical(other.reportsToName, reportsToName) || other.reportsToName == reportsToName)&&(identical(other.orgDepartment, orgDepartment) || other.orgDepartment == orgDepartment)&&(identical(other.division, division) || other.division == division)&&(identical(other.maritalStatus, maritalStatus) || other.maritalStatus == maritalStatus)&&(identical(other.docType, docType) || other.docType == docType)&&(identical(other.namingSeries, namingSeries) || other.namingSeries == namingSeries)&&(identical(other.emergencyContact, emergencyContact) || other.emergencyContact == emergencyContact)&&const DeepCollectionEquality().equals(other.projectAssignments, projectAssignments)&&(identical(other.empId, empId) || other.empId == empId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,fullName,firstName,lastName,email,deskTheme,userImage,birthDate,gender,designation,company,department,reportsTo,employmentType,companyEmail,phone,bloodGroup,dateOfJoining,employee,customPayrollId,reportsToName,orgDepartment,division,maritalStatus,docType,namingSeries,emergencyContact,const DeepCollectionEquality().hash(projectAssignments),empId]);

@override
String toString() {
  return 'ProfileModel(fullName: $fullName, firstName: $firstName, lastName: $lastName, email: $email, deskTheme: $deskTheme, userImage: $userImage, birthDate: $birthDate, gender: $gender, designation: $designation, company: $company, department: $department, reportsTo: $reportsTo, employmentType: $employmentType, companyEmail: $companyEmail, phone: $phone, bloodGroup: $bloodGroup, dateOfJoining: $dateOfJoining, employee: $employee, customPayrollId: $customPayrollId, reportsToName: $reportsToName, orgDepartment: $orgDepartment, division: $division, maritalStatus: $maritalStatus, docType: $docType, namingSeries: $namingSeries, emergencyContact: $emergencyContact, projectAssignments: $projectAssignments, empId: $empId)';
}


}

/// @nodoc
abstract mixin class $ProfileModelCopyWith<$Res>  {
  factory $ProfileModelCopyWith(ProfileModel value, $Res Function(ProfileModel) _then) = _$ProfileModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'employee_name') String fullName,@JsonKey(name: 'first_name') String firstName,@JsonKey(name: 'last_name') String lastName,@JsonKey(name: 'user_id') String email,@JsonKey(name: 'desk_theme') String? deskTheme,@JsonKey(name: 'image') String? userImage,@JsonKey(name: 'date_of_birth') String? birthDate, String? gender, String? designation, String? company, String? department,@JsonKey(name: 'reports_to') String? reportsTo,@JsonKey(name: 'status') String? employmentType,@JsonKey(name: 'company_email') String? companyEmail,@JsonKey(name: 'cell_number') String? phone,@JsonKey(name: 'blood_group') String? bloodGroup,@JsonKey(name: 'date_of_joining') String? dateOfJoining,@JsonKey(name: 'employee') String? employee,@JsonKey(name: 'custom_payroll_id') String? customPayrollId,@JsonKey(name: 'custom_report_to_name') String? reportsToName,@JsonKey(name: 'custom_organization_department') String? orgDepartment,@JsonKey(name: 'custom_division') String? division,@JsonKey(name: 'marital_status') String? maritalStatus,@JsonKey(name: 'doctype') String? docType,@JsonKey(name: 'naming_series') String? namingSeries,@JsonKey(name: 'emergency_contact_name') String? emergencyContact,@JsonKey(name: 'custom_employee_assignment') List<ProfileProjectAssignmentModel>? projectAssignments,@JsonKey(name: 'name') String? empId
});




}
/// @nodoc
class _$ProfileModelCopyWithImpl<$Res>
    implements $ProfileModelCopyWith<$Res> {
  _$ProfileModelCopyWithImpl(this._self, this._then);

  final ProfileModel _self;
  final $Res Function(ProfileModel) _then;

/// Create a copy of ProfileModel
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
as List<ProfileProjectAssignmentModel>?,empId: freezed == empId ? _self.empId : empId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileModel].
extension ProfileModelPatterns on ProfileModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileModel value)  $default,){
final _that = this;
switch (_that) {
case _ProfileModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'employee_name')  String fullName, @JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String lastName, @JsonKey(name: 'user_id')  String email, @JsonKey(name: 'desk_theme')  String? deskTheme, @JsonKey(name: 'image')  String? userImage, @JsonKey(name: 'date_of_birth')  String? birthDate,  String? gender,  String? designation,  String? company,  String? department, @JsonKey(name: 'reports_to')  String? reportsTo, @JsonKey(name: 'status')  String? employmentType, @JsonKey(name: 'company_email')  String? companyEmail, @JsonKey(name: 'cell_number')  String? phone, @JsonKey(name: 'blood_group')  String? bloodGroup, @JsonKey(name: 'date_of_joining')  String? dateOfJoining, @JsonKey(name: 'employee')  String? employee, @JsonKey(name: 'custom_payroll_id')  String? customPayrollId, @JsonKey(name: 'custom_report_to_name')  String? reportsToName, @JsonKey(name: 'custom_organization_department')  String? orgDepartment, @JsonKey(name: 'custom_division')  String? division, @JsonKey(name: 'marital_status')  String? maritalStatus, @JsonKey(name: 'doctype')  String? docType, @JsonKey(name: 'naming_series')  String? namingSeries, @JsonKey(name: 'emergency_contact_name')  String? emergencyContact, @JsonKey(name: 'custom_employee_assignment')  List<ProfileProjectAssignmentModel>? projectAssignments, @JsonKey(name: 'name')  String? empId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'employee_name')  String fullName, @JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String lastName, @JsonKey(name: 'user_id')  String email, @JsonKey(name: 'desk_theme')  String? deskTheme, @JsonKey(name: 'image')  String? userImage, @JsonKey(name: 'date_of_birth')  String? birthDate,  String? gender,  String? designation,  String? company,  String? department, @JsonKey(name: 'reports_to')  String? reportsTo, @JsonKey(name: 'status')  String? employmentType, @JsonKey(name: 'company_email')  String? companyEmail, @JsonKey(name: 'cell_number')  String? phone, @JsonKey(name: 'blood_group')  String? bloodGroup, @JsonKey(name: 'date_of_joining')  String? dateOfJoining, @JsonKey(name: 'employee')  String? employee, @JsonKey(name: 'custom_payroll_id')  String? customPayrollId, @JsonKey(name: 'custom_report_to_name')  String? reportsToName, @JsonKey(name: 'custom_organization_department')  String? orgDepartment, @JsonKey(name: 'custom_division')  String? division, @JsonKey(name: 'marital_status')  String? maritalStatus, @JsonKey(name: 'doctype')  String? docType, @JsonKey(name: 'naming_series')  String? namingSeries, @JsonKey(name: 'emergency_contact_name')  String? emergencyContact, @JsonKey(name: 'custom_employee_assignment')  List<ProfileProjectAssignmentModel>? projectAssignments, @JsonKey(name: 'name')  String? empId)  $default,) {final _that = this;
switch (_that) {
case _ProfileModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'employee_name')  String fullName, @JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String lastName, @JsonKey(name: 'user_id')  String email, @JsonKey(name: 'desk_theme')  String? deskTheme, @JsonKey(name: 'image')  String? userImage, @JsonKey(name: 'date_of_birth')  String? birthDate,  String? gender,  String? designation,  String? company,  String? department, @JsonKey(name: 'reports_to')  String? reportsTo, @JsonKey(name: 'status')  String? employmentType, @JsonKey(name: 'company_email')  String? companyEmail, @JsonKey(name: 'cell_number')  String? phone, @JsonKey(name: 'blood_group')  String? bloodGroup, @JsonKey(name: 'date_of_joining')  String? dateOfJoining, @JsonKey(name: 'employee')  String? employee, @JsonKey(name: 'custom_payroll_id')  String? customPayrollId, @JsonKey(name: 'custom_report_to_name')  String? reportsToName, @JsonKey(name: 'custom_organization_department')  String? orgDepartment, @JsonKey(name: 'custom_division')  String? division, @JsonKey(name: 'marital_status')  String? maritalStatus, @JsonKey(name: 'doctype')  String? docType, @JsonKey(name: 'naming_series')  String? namingSeries, @JsonKey(name: 'emergency_contact_name')  String? emergencyContact, @JsonKey(name: 'custom_employee_assignment')  List<ProfileProjectAssignmentModel>? projectAssignments, @JsonKey(name: 'name')  String? empId)?  $default,) {final _that = this;
switch (_that) {
case _ProfileModel() when $default != null:
return $default(_that.fullName,_that.firstName,_that.lastName,_that.email,_that.deskTheme,_that.userImage,_that.birthDate,_that.gender,_that.designation,_that.company,_that.department,_that.reportsTo,_that.employmentType,_that.companyEmail,_that.phone,_that.bloodGroup,_that.dateOfJoining,_that.employee,_that.customPayrollId,_that.reportsToName,_that.orgDepartment,_that.division,_that.maritalStatus,_that.docType,_that.namingSeries,_that.emergencyContact,_that.projectAssignments,_that.empId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileModel extends ProfileModel {
  const _ProfileModel({@JsonKey(name: 'employee_name') required this.fullName, @JsonKey(name: 'first_name') required this.firstName, @JsonKey(name: 'last_name') required this.lastName, @JsonKey(name: 'user_id') required this.email, @JsonKey(name: 'desk_theme') this.deskTheme, @JsonKey(name: 'image') this.userImage, @JsonKey(name: 'date_of_birth') this.birthDate, this.gender, this.designation, this.company, this.department, @JsonKey(name: 'reports_to') this.reportsTo, @JsonKey(name: 'status') this.employmentType, @JsonKey(name: 'company_email') this.companyEmail, @JsonKey(name: 'cell_number') this.phone, @JsonKey(name: 'blood_group') this.bloodGroup, @JsonKey(name: 'date_of_joining') this.dateOfJoining, @JsonKey(name: 'employee') this.employee, @JsonKey(name: 'custom_payroll_id') this.customPayrollId, @JsonKey(name: 'custom_report_to_name') this.reportsToName, @JsonKey(name: 'custom_organization_department') this.orgDepartment, @JsonKey(name: 'custom_division') this.division, @JsonKey(name: 'marital_status') this.maritalStatus, @JsonKey(name: 'doctype') this.docType, @JsonKey(name: 'naming_series') this.namingSeries, @JsonKey(name: 'emergency_contact_name') this.emergencyContact, @JsonKey(name: 'custom_employee_assignment') final  List<ProfileProjectAssignmentModel>? projectAssignments, @JsonKey(name: 'name') this.empId}): _projectAssignments = projectAssignments,super._();
  factory _ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);

@override@JsonKey(name: 'employee_name') final  String fullName;
@override@JsonKey(name: 'first_name') final  String firstName;
@override@JsonKey(name: 'last_name') final  String lastName;
@override@JsonKey(name: 'user_id') final  String email;
@override@JsonKey(name: 'desk_theme') final  String? deskTheme;
@override@JsonKey(name: 'image') final  String? userImage;
@override@JsonKey(name: 'date_of_birth') final  String? birthDate;
@override final  String? gender;
@override final  String? designation;
@override final  String? company;
@override final  String? department;
@override@JsonKey(name: 'reports_to') final  String? reportsTo;
@override@JsonKey(name: 'status') final  String? employmentType;
@override@JsonKey(name: 'company_email') final  String? companyEmail;
@override@JsonKey(name: 'cell_number') final  String? phone;
@override@JsonKey(name: 'blood_group') final  String? bloodGroup;
@override@JsonKey(name: 'date_of_joining') final  String? dateOfJoining;
@override@JsonKey(name: 'employee') final  String? employee;
@override@JsonKey(name: 'custom_payroll_id') final  String? customPayrollId;
@override@JsonKey(name: 'custom_report_to_name') final  String? reportsToName;
@override@JsonKey(name: 'custom_organization_department') final  String? orgDepartment;
@override@JsonKey(name: 'custom_division') final  String? division;
@override@JsonKey(name: 'marital_status') final  String? maritalStatus;
@override@JsonKey(name: 'doctype') final  String? docType;
@override@JsonKey(name: 'naming_series') final  String? namingSeries;
@override@JsonKey(name: 'emergency_contact_name') final  String? emergencyContact;
 final  List<ProfileProjectAssignmentModel>? _projectAssignments;
@override@JsonKey(name: 'custom_employee_assignment') List<ProfileProjectAssignmentModel>? get projectAssignments {
  final value = _projectAssignments;
  if (value == null) return null;
  if (_projectAssignments is EqualUnmodifiableListView) return _projectAssignments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'name') final  String? empId;

/// Create a copy of ProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileModelCopyWith<_ProfileModel> get copyWith => __$ProfileModelCopyWithImpl<_ProfileModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileModel&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.deskTheme, deskTheme) || other.deskTheme == deskTheme)&&(identical(other.userImage, userImage) || other.userImage == userImage)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.company, company) || other.company == company)&&(identical(other.department, department) || other.department == department)&&(identical(other.reportsTo, reportsTo) || other.reportsTo == reportsTo)&&(identical(other.employmentType, employmentType) || other.employmentType == employmentType)&&(identical(other.companyEmail, companyEmail) || other.companyEmail == companyEmail)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.bloodGroup, bloodGroup) || other.bloodGroup == bloodGroup)&&(identical(other.dateOfJoining, dateOfJoining) || other.dateOfJoining == dateOfJoining)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.customPayrollId, customPayrollId) || other.customPayrollId == customPayrollId)&&(identical(other.reportsToName, reportsToName) || other.reportsToName == reportsToName)&&(identical(other.orgDepartment, orgDepartment) || other.orgDepartment == orgDepartment)&&(identical(other.division, division) || other.division == division)&&(identical(other.maritalStatus, maritalStatus) || other.maritalStatus == maritalStatus)&&(identical(other.docType, docType) || other.docType == docType)&&(identical(other.namingSeries, namingSeries) || other.namingSeries == namingSeries)&&(identical(other.emergencyContact, emergencyContact) || other.emergencyContact == emergencyContact)&&const DeepCollectionEquality().equals(other._projectAssignments, _projectAssignments)&&(identical(other.empId, empId) || other.empId == empId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,fullName,firstName,lastName,email,deskTheme,userImage,birthDate,gender,designation,company,department,reportsTo,employmentType,companyEmail,phone,bloodGroup,dateOfJoining,employee,customPayrollId,reportsToName,orgDepartment,division,maritalStatus,docType,namingSeries,emergencyContact,const DeepCollectionEquality().hash(_projectAssignments),empId]);

@override
String toString() {
  return 'ProfileModel(fullName: $fullName, firstName: $firstName, lastName: $lastName, email: $email, deskTheme: $deskTheme, userImage: $userImage, birthDate: $birthDate, gender: $gender, designation: $designation, company: $company, department: $department, reportsTo: $reportsTo, employmentType: $employmentType, companyEmail: $companyEmail, phone: $phone, bloodGroup: $bloodGroup, dateOfJoining: $dateOfJoining, employee: $employee, customPayrollId: $customPayrollId, reportsToName: $reportsToName, orgDepartment: $orgDepartment, division: $division, maritalStatus: $maritalStatus, docType: $docType, namingSeries: $namingSeries, emergencyContact: $emergencyContact, projectAssignments: $projectAssignments, empId: $empId)';
}


}

/// @nodoc
abstract mixin class _$ProfileModelCopyWith<$Res> implements $ProfileModelCopyWith<$Res> {
  factory _$ProfileModelCopyWith(_ProfileModel value, $Res Function(_ProfileModel) _then) = __$ProfileModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'employee_name') String fullName,@JsonKey(name: 'first_name') String firstName,@JsonKey(name: 'last_name') String lastName,@JsonKey(name: 'user_id') String email,@JsonKey(name: 'desk_theme') String? deskTheme,@JsonKey(name: 'image') String? userImage,@JsonKey(name: 'date_of_birth') String? birthDate, String? gender, String? designation, String? company, String? department,@JsonKey(name: 'reports_to') String? reportsTo,@JsonKey(name: 'status') String? employmentType,@JsonKey(name: 'company_email') String? companyEmail,@JsonKey(name: 'cell_number') String? phone,@JsonKey(name: 'blood_group') String? bloodGroup,@JsonKey(name: 'date_of_joining') String? dateOfJoining,@JsonKey(name: 'employee') String? employee,@JsonKey(name: 'custom_payroll_id') String? customPayrollId,@JsonKey(name: 'custom_report_to_name') String? reportsToName,@JsonKey(name: 'custom_organization_department') String? orgDepartment,@JsonKey(name: 'custom_division') String? division,@JsonKey(name: 'marital_status') String? maritalStatus,@JsonKey(name: 'doctype') String? docType,@JsonKey(name: 'naming_series') String? namingSeries,@JsonKey(name: 'emergency_contact_name') String? emergencyContact,@JsonKey(name: 'custom_employee_assignment') List<ProfileProjectAssignmentModel>? projectAssignments,@JsonKey(name: 'name') String? empId
});




}
/// @nodoc
class __$ProfileModelCopyWithImpl<$Res>
    implements _$ProfileModelCopyWith<$Res> {
  __$ProfileModelCopyWithImpl(this._self, this._then);

  final _ProfileModel _self;
  final $Res Function(_ProfileModel) _then;

/// Create a copy of ProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = null,Object? firstName = null,Object? lastName = null,Object? email = null,Object? deskTheme = freezed,Object? userImage = freezed,Object? birthDate = freezed,Object? gender = freezed,Object? designation = freezed,Object? company = freezed,Object? department = freezed,Object? reportsTo = freezed,Object? employmentType = freezed,Object? companyEmail = freezed,Object? phone = freezed,Object? bloodGroup = freezed,Object? dateOfJoining = freezed,Object? employee = freezed,Object? customPayrollId = freezed,Object? reportsToName = freezed,Object? orgDepartment = freezed,Object? division = freezed,Object? maritalStatus = freezed,Object? docType = freezed,Object? namingSeries = freezed,Object? emergencyContact = freezed,Object? projectAssignments = freezed,Object? empId = freezed,}) {
  return _then(_ProfileModel(
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
as List<ProfileProjectAssignmentModel>?,empId: freezed == empId ? _self.empId : empId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
