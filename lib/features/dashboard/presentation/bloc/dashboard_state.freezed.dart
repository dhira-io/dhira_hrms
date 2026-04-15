// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DashboardState {

 List<DashboardItem> get allEmployeeActions; List<DashboardItem> get allCompanyInfo; List<DashboardItem> get filteredEmployeeActions; List<DashboardItem> get filteredCompanyInfo; String get searchQuery; bool get isProfileMenuOpen; bool get isMainMenuOpen;
/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardStateCopyWith<DashboardState> get copyWith => _$DashboardStateCopyWithImpl<DashboardState>(this as DashboardState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardState&&const DeepCollectionEquality().equals(other.allEmployeeActions, allEmployeeActions)&&const DeepCollectionEquality().equals(other.allCompanyInfo, allCompanyInfo)&&const DeepCollectionEquality().equals(other.filteredEmployeeActions, filteredEmployeeActions)&&const DeepCollectionEquality().equals(other.filteredCompanyInfo, filteredCompanyInfo)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.isProfileMenuOpen, isProfileMenuOpen) || other.isProfileMenuOpen == isProfileMenuOpen)&&(identical(other.isMainMenuOpen, isMainMenuOpen) || other.isMainMenuOpen == isMainMenuOpen));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(allEmployeeActions),const DeepCollectionEquality().hash(allCompanyInfo),const DeepCollectionEquality().hash(filteredEmployeeActions),const DeepCollectionEquality().hash(filteredCompanyInfo),searchQuery,isProfileMenuOpen,isMainMenuOpen);

@override
String toString() {
  return 'DashboardState(allEmployeeActions: $allEmployeeActions, allCompanyInfo: $allCompanyInfo, filteredEmployeeActions: $filteredEmployeeActions, filteredCompanyInfo: $filteredCompanyInfo, searchQuery: $searchQuery, isProfileMenuOpen: $isProfileMenuOpen, isMainMenuOpen: $isMainMenuOpen)';
}


}

/// @nodoc
abstract mixin class $DashboardStateCopyWith<$Res>  {
  factory $DashboardStateCopyWith(DashboardState value, $Res Function(DashboardState) _then) = _$DashboardStateCopyWithImpl;
@useResult
$Res call({
 List<DashboardItem> allEmployeeActions, List<DashboardItem> allCompanyInfo, List<DashboardItem> filteredEmployeeActions, List<DashboardItem> filteredCompanyInfo, String searchQuery, bool isProfileMenuOpen, bool isMainMenuOpen
});




}
/// @nodoc
class _$DashboardStateCopyWithImpl<$Res>
    implements $DashboardStateCopyWith<$Res> {
  _$DashboardStateCopyWithImpl(this._self, this._then);

  final DashboardState _self;
  final $Res Function(DashboardState) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? allEmployeeActions = null,Object? allCompanyInfo = null,Object? filteredEmployeeActions = null,Object? filteredCompanyInfo = null,Object? searchQuery = null,Object? isProfileMenuOpen = null,Object? isMainMenuOpen = null,}) {
  return _then(_self.copyWith(
allEmployeeActions: null == allEmployeeActions ? _self.allEmployeeActions : allEmployeeActions // ignore: cast_nullable_to_non_nullable
as List<DashboardItem>,allCompanyInfo: null == allCompanyInfo ? _self.allCompanyInfo : allCompanyInfo // ignore: cast_nullable_to_non_nullable
as List<DashboardItem>,filteredEmployeeActions: null == filteredEmployeeActions ? _self.filteredEmployeeActions : filteredEmployeeActions // ignore: cast_nullable_to_non_nullable
as List<DashboardItem>,filteredCompanyInfo: null == filteredCompanyInfo ? _self.filteredCompanyInfo : filteredCompanyInfo // ignore: cast_nullable_to_non_nullable
as List<DashboardItem>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,isProfileMenuOpen: null == isProfileMenuOpen ? _self.isProfileMenuOpen : isProfileMenuOpen // ignore: cast_nullable_to_non_nullable
as bool,isMainMenuOpen: null == isMainMenuOpen ? _self.isMainMenuOpen : isMainMenuOpen // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DashboardState].
extension DashboardStatePatterns on DashboardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardState value)  $default,){
final _that = this;
switch (_that) {
case _DashboardState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardState value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<DashboardItem> allEmployeeActions,  List<DashboardItem> allCompanyInfo,  List<DashboardItem> filteredEmployeeActions,  List<DashboardItem> filteredCompanyInfo,  String searchQuery,  bool isProfileMenuOpen,  bool isMainMenuOpen)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
return $default(_that.allEmployeeActions,_that.allCompanyInfo,_that.filteredEmployeeActions,_that.filteredCompanyInfo,_that.searchQuery,_that.isProfileMenuOpen,_that.isMainMenuOpen);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<DashboardItem> allEmployeeActions,  List<DashboardItem> allCompanyInfo,  List<DashboardItem> filteredEmployeeActions,  List<DashboardItem> filteredCompanyInfo,  String searchQuery,  bool isProfileMenuOpen,  bool isMainMenuOpen)  $default,) {final _that = this;
switch (_that) {
case _DashboardState():
return $default(_that.allEmployeeActions,_that.allCompanyInfo,_that.filteredEmployeeActions,_that.filteredCompanyInfo,_that.searchQuery,_that.isProfileMenuOpen,_that.isMainMenuOpen);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<DashboardItem> allEmployeeActions,  List<DashboardItem> allCompanyInfo,  List<DashboardItem> filteredEmployeeActions,  List<DashboardItem> filteredCompanyInfo,  String searchQuery,  bool isProfileMenuOpen,  bool isMainMenuOpen)?  $default,) {final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
return $default(_that.allEmployeeActions,_that.allCompanyInfo,_that.filteredEmployeeActions,_that.filteredCompanyInfo,_that.searchQuery,_that.isProfileMenuOpen,_that.isMainMenuOpen);case _:
  return null;

}
}

}

/// @nodoc


class _DashboardState implements DashboardState {
  const _DashboardState({final  List<DashboardItem> allEmployeeActions = const [], final  List<DashboardItem> allCompanyInfo = const [], final  List<DashboardItem> filteredEmployeeActions = const [], final  List<DashboardItem> filteredCompanyInfo = const [], this.searchQuery = '', this.isProfileMenuOpen = false, this.isMainMenuOpen = false}): _allEmployeeActions = allEmployeeActions,_allCompanyInfo = allCompanyInfo,_filteredEmployeeActions = filteredEmployeeActions,_filteredCompanyInfo = filteredCompanyInfo;
  

 final  List<DashboardItem> _allEmployeeActions;
@override@JsonKey() List<DashboardItem> get allEmployeeActions {
  if (_allEmployeeActions is EqualUnmodifiableListView) return _allEmployeeActions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allEmployeeActions);
}

 final  List<DashboardItem> _allCompanyInfo;
@override@JsonKey() List<DashboardItem> get allCompanyInfo {
  if (_allCompanyInfo is EqualUnmodifiableListView) return _allCompanyInfo;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allCompanyInfo);
}

 final  List<DashboardItem> _filteredEmployeeActions;
@override@JsonKey() List<DashboardItem> get filteredEmployeeActions {
  if (_filteredEmployeeActions is EqualUnmodifiableListView) return _filteredEmployeeActions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredEmployeeActions);
}

 final  List<DashboardItem> _filteredCompanyInfo;
@override@JsonKey() List<DashboardItem> get filteredCompanyInfo {
  if (_filteredCompanyInfo is EqualUnmodifiableListView) return _filteredCompanyInfo;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredCompanyInfo);
}

@override@JsonKey() final  String searchQuery;
@override@JsonKey() final  bool isProfileMenuOpen;
@override@JsonKey() final  bool isMainMenuOpen;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardStateCopyWith<_DashboardState> get copyWith => __$DashboardStateCopyWithImpl<_DashboardState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardState&&const DeepCollectionEquality().equals(other._allEmployeeActions, _allEmployeeActions)&&const DeepCollectionEquality().equals(other._allCompanyInfo, _allCompanyInfo)&&const DeepCollectionEquality().equals(other._filteredEmployeeActions, _filteredEmployeeActions)&&const DeepCollectionEquality().equals(other._filteredCompanyInfo, _filteredCompanyInfo)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.isProfileMenuOpen, isProfileMenuOpen) || other.isProfileMenuOpen == isProfileMenuOpen)&&(identical(other.isMainMenuOpen, isMainMenuOpen) || other.isMainMenuOpen == isMainMenuOpen));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_allEmployeeActions),const DeepCollectionEquality().hash(_allCompanyInfo),const DeepCollectionEquality().hash(_filteredEmployeeActions),const DeepCollectionEquality().hash(_filteredCompanyInfo),searchQuery,isProfileMenuOpen,isMainMenuOpen);

@override
String toString() {
  return 'DashboardState(allEmployeeActions: $allEmployeeActions, allCompanyInfo: $allCompanyInfo, filteredEmployeeActions: $filteredEmployeeActions, filteredCompanyInfo: $filteredCompanyInfo, searchQuery: $searchQuery, isProfileMenuOpen: $isProfileMenuOpen, isMainMenuOpen: $isMainMenuOpen)';
}


}

/// @nodoc
abstract mixin class _$DashboardStateCopyWith<$Res> implements $DashboardStateCopyWith<$Res> {
  factory _$DashboardStateCopyWith(_DashboardState value, $Res Function(_DashboardState) _then) = __$DashboardStateCopyWithImpl;
@override @useResult
$Res call({
 List<DashboardItem> allEmployeeActions, List<DashboardItem> allCompanyInfo, List<DashboardItem> filteredEmployeeActions, List<DashboardItem> filteredCompanyInfo, String searchQuery, bool isProfileMenuOpen, bool isMainMenuOpen
});




}
/// @nodoc
class __$DashboardStateCopyWithImpl<$Res>
    implements _$DashboardStateCopyWith<$Res> {
  __$DashboardStateCopyWithImpl(this._self, this._then);

  final _DashboardState _self;
  final $Res Function(_DashboardState) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? allEmployeeActions = null,Object? allCompanyInfo = null,Object? filteredEmployeeActions = null,Object? filteredCompanyInfo = null,Object? searchQuery = null,Object? isProfileMenuOpen = null,Object? isMainMenuOpen = null,}) {
  return _then(_DashboardState(
allEmployeeActions: null == allEmployeeActions ? _self._allEmployeeActions : allEmployeeActions // ignore: cast_nullable_to_non_nullable
as List<DashboardItem>,allCompanyInfo: null == allCompanyInfo ? _self._allCompanyInfo : allCompanyInfo // ignore: cast_nullable_to_non_nullable
as List<DashboardItem>,filteredEmployeeActions: null == filteredEmployeeActions ? _self._filteredEmployeeActions : filteredEmployeeActions // ignore: cast_nullable_to_non_nullable
as List<DashboardItem>,filteredCompanyInfo: null == filteredCompanyInfo ? _self._filteredCompanyInfo : filteredCompanyInfo // ignore: cast_nullable_to_non_nullable
as List<DashboardItem>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,isProfileMenuOpen: null == isProfileMenuOpen ? _self.isProfileMenuOpen : isProfileMenuOpen // ignore: cast_nullable_to_non_nullable
as bool,isMainMenuOpen: null == isMainMenuOpen ? _self.isMainMenuOpen : isMainMenuOpen // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
