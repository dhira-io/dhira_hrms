// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_evaluation_filter_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TeamEvaluationFilterState {

 List<TeamEvaluationEntity> get allEvaluations; List<TeamEvaluationEntity> get filteredEvaluations; String get selectedDepartment; String get selectedStatus; String get searchQuery; List<String> get departments; List<String> get statuses; int get totalCount; int get submittedCount; int get pendingCount;
/// Create a copy of TeamEvaluationFilterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamEvaluationFilterStateCopyWith<TeamEvaluationFilterState> get copyWith => _$TeamEvaluationFilterStateCopyWithImpl<TeamEvaluationFilterState>(this as TeamEvaluationFilterState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamEvaluationFilterState&&const DeepCollectionEquality().equals(other.allEvaluations, allEvaluations)&&const DeepCollectionEquality().equals(other.filteredEvaluations, filteredEvaluations)&&(identical(other.selectedDepartment, selectedDepartment) || other.selectedDepartment == selectedDepartment)&&(identical(other.selectedStatus, selectedStatus) || other.selectedStatus == selectedStatus)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&const DeepCollectionEquality().equals(other.departments, departments)&&const DeepCollectionEquality().equals(other.statuses, statuses)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.submittedCount, submittedCount) || other.submittedCount == submittedCount)&&(identical(other.pendingCount, pendingCount) || other.pendingCount == pendingCount));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(allEvaluations),const DeepCollectionEquality().hash(filteredEvaluations),selectedDepartment,selectedStatus,searchQuery,const DeepCollectionEquality().hash(departments),const DeepCollectionEquality().hash(statuses),totalCount,submittedCount,pendingCount);

@override
String toString() {
  return 'TeamEvaluationFilterState(allEvaluations: $allEvaluations, filteredEvaluations: $filteredEvaluations, selectedDepartment: $selectedDepartment, selectedStatus: $selectedStatus, searchQuery: $searchQuery, departments: $departments, statuses: $statuses, totalCount: $totalCount, submittedCount: $submittedCount, pendingCount: $pendingCount)';
}


}

/// @nodoc
abstract mixin class $TeamEvaluationFilterStateCopyWith<$Res>  {
  factory $TeamEvaluationFilterStateCopyWith(TeamEvaluationFilterState value, $Res Function(TeamEvaluationFilterState) _then) = _$TeamEvaluationFilterStateCopyWithImpl;
@useResult
$Res call({
 List<TeamEvaluationEntity> allEvaluations, List<TeamEvaluationEntity> filteredEvaluations, String selectedDepartment, String selectedStatus, String searchQuery, List<String> departments, List<String> statuses, int totalCount, int submittedCount, int pendingCount
});




}
/// @nodoc
class _$TeamEvaluationFilterStateCopyWithImpl<$Res>
    implements $TeamEvaluationFilterStateCopyWith<$Res> {
  _$TeamEvaluationFilterStateCopyWithImpl(this._self, this._then);

  final TeamEvaluationFilterState _self;
  final $Res Function(TeamEvaluationFilterState) _then;

/// Create a copy of TeamEvaluationFilterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? allEvaluations = null,Object? filteredEvaluations = null,Object? selectedDepartment = null,Object? selectedStatus = null,Object? searchQuery = null,Object? departments = null,Object? statuses = null,Object? totalCount = null,Object? submittedCount = null,Object? pendingCount = null,}) {
  return _then(_self.copyWith(
allEvaluations: null == allEvaluations ? _self.allEvaluations : allEvaluations // ignore: cast_nullable_to_non_nullable
as List<TeamEvaluationEntity>,filteredEvaluations: null == filteredEvaluations ? _self.filteredEvaluations : filteredEvaluations // ignore: cast_nullable_to_non_nullable
as List<TeamEvaluationEntity>,selectedDepartment: null == selectedDepartment ? _self.selectedDepartment : selectedDepartment // ignore: cast_nullable_to_non_nullable
as String,selectedStatus: null == selectedStatus ? _self.selectedStatus : selectedStatus // ignore: cast_nullable_to_non_nullable
as String,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,departments: null == departments ? _self.departments : departments // ignore: cast_nullable_to_non_nullable
as List<String>,statuses: null == statuses ? _self.statuses : statuses // ignore: cast_nullable_to_non_nullable
as List<String>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,submittedCount: null == submittedCount ? _self.submittedCount : submittedCount // ignore: cast_nullable_to_non_nullable
as int,pendingCount: null == pendingCount ? _self.pendingCount : pendingCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TeamEvaluationFilterState].
extension TeamEvaluationFilterStatePatterns on TeamEvaluationFilterState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeamEvaluationFilterState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeamEvaluationFilterState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeamEvaluationFilterState value)  $default,){
final _that = this;
switch (_that) {
case _TeamEvaluationFilterState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeamEvaluationFilterState value)?  $default,){
final _that = this;
switch (_that) {
case _TeamEvaluationFilterState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TeamEvaluationEntity> allEvaluations,  List<TeamEvaluationEntity> filteredEvaluations,  String selectedDepartment,  String selectedStatus,  String searchQuery,  List<String> departments,  List<String> statuses,  int totalCount,  int submittedCount,  int pendingCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeamEvaluationFilterState() when $default != null:
return $default(_that.allEvaluations,_that.filteredEvaluations,_that.selectedDepartment,_that.selectedStatus,_that.searchQuery,_that.departments,_that.statuses,_that.totalCount,_that.submittedCount,_that.pendingCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TeamEvaluationEntity> allEvaluations,  List<TeamEvaluationEntity> filteredEvaluations,  String selectedDepartment,  String selectedStatus,  String searchQuery,  List<String> departments,  List<String> statuses,  int totalCount,  int submittedCount,  int pendingCount)  $default,) {final _that = this;
switch (_that) {
case _TeamEvaluationFilterState():
return $default(_that.allEvaluations,_that.filteredEvaluations,_that.selectedDepartment,_that.selectedStatus,_that.searchQuery,_that.departments,_that.statuses,_that.totalCount,_that.submittedCount,_that.pendingCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TeamEvaluationEntity> allEvaluations,  List<TeamEvaluationEntity> filteredEvaluations,  String selectedDepartment,  String selectedStatus,  String searchQuery,  List<String> departments,  List<String> statuses,  int totalCount,  int submittedCount,  int pendingCount)?  $default,) {final _that = this;
switch (_that) {
case _TeamEvaluationFilterState() when $default != null:
return $default(_that.allEvaluations,_that.filteredEvaluations,_that.selectedDepartment,_that.selectedStatus,_that.searchQuery,_that.departments,_that.statuses,_that.totalCount,_that.submittedCount,_that.pendingCount);case _:
  return null;

}
}

}

/// @nodoc


class _TeamEvaluationFilterState implements TeamEvaluationFilterState {
  const _TeamEvaluationFilterState({final  List<TeamEvaluationEntity> allEvaluations = const [], final  List<TeamEvaluationEntity> filteredEvaluations = const [], this.selectedDepartment = 'All Department', this.selectedStatus = 'All Status', this.searchQuery = '', final  List<String> departments = const ['All Department'], final  List<String> statuses = const ['All Status', 'Submitted', 'Pending'], this.totalCount = 0, this.submittedCount = 0, this.pendingCount = 0}): _allEvaluations = allEvaluations,_filteredEvaluations = filteredEvaluations,_departments = departments,_statuses = statuses;
  

 final  List<TeamEvaluationEntity> _allEvaluations;
@override@JsonKey() List<TeamEvaluationEntity> get allEvaluations {
  if (_allEvaluations is EqualUnmodifiableListView) return _allEvaluations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allEvaluations);
}

 final  List<TeamEvaluationEntity> _filteredEvaluations;
@override@JsonKey() List<TeamEvaluationEntity> get filteredEvaluations {
  if (_filteredEvaluations is EqualUnmodifiableListView) return _filteredEvaluations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredEvaluations);
}

@override@JsonKey() final  String selectedDepartment;
@override@JsonKey() final  String selectedStatus;
@override@JsonKey() final  String searchQuery;
 final  List<String> _departments;
@override@JsonKey() List<String> get departments {
  if (_departments is EqualUnmodifiableListView) return _departments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_departments);
}

 final  List<String> _statuses;
@override@JsonKey() List<String> get statuses {
  if (_statuses is EqualUnmodifiableListView) return _statuses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_statuses);
}

@override@JsonKey() final  int totalCount;
@override@JsonKey() final  int submittedCount;
@override@JsonKey() final  int pendingCount;

/// Create a copy of TeamEvaluationFilterState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeamEvaluationFilterStateCopyWith<_TeamEvaluationFilterState> get copyWith => __$TeamEvaluationFilterStateCopyWithImpl<_TeamEvaluationFilterState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeamEvaluationFilterState&&const DeepCollectionEquality().equals(other._allEvaluations, _allEvaluations)&&const DeepCollectionEquality().equals(other._filteredEvaluations, _filteredEvaluations)&&(identical(other.selectedDepartment, selectedDepartment) || other.selectedDepartment == selectedDepartment)&&(identical(other.selectedStatus, selectedStatus) || other.selectedStatus == selectedStatus)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&const DeepCollectionEquality().equals(other._departments, _departments)&&const DeepCollectionEquality().equals(other._statuses, _statuses)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.submittedCount, submittedCount) || other.submittedCount == submittedCount)&&(identical(other.pendingCount, pendingCount) || other.pendingCount == pendingCount));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_allEvaluations),const DeepCollectionEquality().hash(_filteredEvaluations),selectedDepartment,selectedStatus,searchQuery,const DeepCollectionEquality().hash(_departments),const DeepCollectionEquality().hash(_statuses),totalCount,submittedCount,pendingCount);

@override
String toString() {
  return 'TeamEvaluationFilterState(allEvaluations: $allEvaluations, filteredEvaluations: $filteredEvaluations, selectedDepartment: $selectedDepartment, selectedStatus: $selectedStatus, searchQuery: $searchQuery, departments: $departments, statuses: $statuses, totalCount: $totalCount, submittedCount: $submittedCount, pendingCount: $pendingCount)';
}


}

/// @nodoc
abstract mixin class _$TeamEvaluationFilterStateCopyWith<$Res> implements $TeamEvaluationFilterStateCopyWith<$Res> {
  factory _$TeamEvaluationFilterStateCopyWith(_TeamEvaluationFilterState value, $Res Function(_TeamEvaluationFilterState) _then) = __$TeamEvaluationFilterStateCopyWithImpl;
@override @useResult
$Res call({
 List<TeamEvaluationEntity> allEvaluations, List<TeamEvaluationEntity> filteredEvaluations, String selectedDepartment, String selectedStatus, String searchQuery, List<String> departments, List<String> statuses, int totalCount, int submittedCount, int pendingCount
});




}
/// @nodoc
class __$TeamEvaluationFilterStateCopyWithImpl<$Res>
    implements _$TeamEvaluationFilterStateCopyWith<$Res> {
  __$TeamEvaluationFilterStateCopyWithImpl(this._self, this._then);

  final _TeamEvaluationFilterState _self;
  final $Res Function(_TeamEvaluationFilterState) _then;

/// Create a copy of TeamEvaluationFilterState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? allEvaluations = null,Object? filteredEvaluations = null,Object? selectedDepartment = null,Object? selectedStatus = null,Object? searchQuery = null,Object? departments = null,Object? statuses = null,Object? totalCount = null,Object? submittedCount = null,Object? pendingCount = null,}) {
  return _then(_TeamEvaluationFilterState(
allEvaluations: null == allEvaluations ? _self._allEvaluations : allEvaluations // ignore: cast_nullable_to_non_nullable
as List<TeamEvaluationEntity>,filteredEvaluations: null == filteredEvaluations ? _self._filteredEvaluations : filteredEvaluations // ignore: cast_nullable_to_non_nullable
as List<TeamEvaluationEntity>,selectedDepartment: null == selectedDepartment ? _self.selectedDepartment : selectedDepartment // ignore: cast_nullable_to_non_nullable
as String,selectedStatus: null == selectedStatus ? _self.selectedStatus : selectedStatus // ignore: cast_nullable_to_non_nullable
as String,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,departments: null == departments ? _self._departments : departments // ignore: cast_nullable_to_non_nullable
as List<String>,statuses: null == statuses ? _self._statuses : statuses // ignore: cast_nullable_to_non_nullable
as List<String>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,submittedCount: null == submittedCount ? _self.submittedCount : submittedCount // ignore: cast_nullable_to_non_nullable
as int,pendingCount: null == pendingCount ? _self.pendingCount : pendingCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
