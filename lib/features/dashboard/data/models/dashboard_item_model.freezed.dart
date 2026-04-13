// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DashboardItem {

 String get title; String get subtitle; String get assetImagePath; int get bgColorValue;// Store as int for serializability if needed
 String get route;
/// Create a copy of DashboardItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardItemCopyWith<DashboardItem> get copyWith => _$DashboardItemCopyWithImpl<DashboardItem>(this as DashboardItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardItem&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.assetImagePath, assetImagePath) || other.assetImagePath == assetImagePath)&&(identical(other.bgColorValue, bgColorValue) || other.bgColorValue == bgColorValue)&&(identical(other.route, route) || other.route == route));
}


@override
int get hashCode => Object.hash(runtimeType,title,subtitle,assetImagePath,bgColorValue,route);

@override
String toString() {
  return 'DashboardItem(title: $title, subtitle: $subtitle, assetImagePath: $assetImagePath, bgColorValue: $bgColorValue, route: $route)';
}


}

/// @nodoc
abstract mixin class $DashboardItemCopyWith<$Res>  {
  factory $DashboardItemCopyWith(DashboardItem value, $Res Function(DashboardItem) _then) = _$DashboardItemCopyWithImpl;
@useResult
$Res call({
 String title, String subtitle, String assetImagePath, int bgColorValue, String route
});




}
/// @nodoc
class _$DashboardItemCopyWithImpl<$Res>
    implements $DashboardItemCopyWith<$Res> {
  _$DashboardItemCopyWithImpl(this._self, this._then);

  final DashboardItem _self;
  final $Res Function(DashboardItem) _then;

/// Create a copy of DashboardItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? subtitle = null,Object? assetImagePath = null,Object? bgColorValue = null,Object? route = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,assetImagePath: null == assetImagePath ? _self.assetImagePath : assetImagePath // ignore: cast_nullable_to_non_nullable
as String,bgColorValue: null == bgColorValue ? _self.bgColorValue : bgColorValue // ignore: cast_nullable_to_non_nullable
as int,route: null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DashboardItem].
extension DashboardItemPatterns on DashboardItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardItem value)  $default,){
final _that = this;
switch (_that) {
case _DashboardItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardItem value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String subtitle,  String assetImagePath,  int bgColorValue,  String route)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardItem() when $default != null:
return $default(_that.title,_that.subtitle,_that.assetImagePath,_that.bgColorValue,_that.route);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String subtitle,  String assetImagePath,  int bgColorValue,  String route)  $default,) {final _that = this;
switch (_that) {
case _DashboardItem():
return $default(_that.title,_that.subtitle,_that.assetImagePath,_that.bgColorValue,_that.route);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String subtitle,  String assetImagePath,  int bgColorValue,  String route)?  $default,) {final _that = this;
switch (_that) {
case _DashboardItem() when $default != null:
return $default(_that.title,_that.subtitle,_that.assetImagePath,_that.bgColorValue,_that.route);case _:
  return null;

}
}

}

/// @nodoc


class _DashboardItem extends DashboardItem {
  const _DashboardItem({required this.title, required this.subtitle, required this.assetImagePath, required this.bgColorValue, required this.route}): super._();
  

@override final  String title;
@override final  String subtitle;
@override final  String assetImagePath;
@override final  int bgColorValue;
// Store as int for serializability if needed
@override final  String route;

/// Create a copy of DashboardItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardItemCopyWith<_DashboardItem> get copyWith => __$DashboardItemCopyWithImpl<_DashboardItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardItem&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.assetImagePath, assetImagePath) || other.assetImagePath == assetImagePath)&&(identical(other.bgColorValue, bgColorValue) || other.bgColorValue == bgColorValue)&&(identical(other.route, route) || other.route == route));
}


@override
int get hashCode => Object.hash(runtimeType,title,subtitle,assetImagePath,bgColorValue,route);

@override
String toString() {
  return 'DashboardItem(title: $title, subtitle: $subtitle, assetImagePath: $assetImagePath, bgColorValue: $bgColorValue, route: $route)';
}


}

/// @nodoc
abstract mixin class _$DashboardItemCopyWith<$Res> implements $DashboardItemCopyWith<$Res> {
  factory _$DashboardItemCopyWith(_DashboardItem value, $Res Function(_DashboardItem) _then) = __$DashboardItemCopyWithImpl;
@override @useResult
$Res call({
 String title, String subtitle, String assetImagePath, int bgColorValue, String route
});




}
/// @nodoc
class __$DashboardItemCopyWithImpl<$Res>
    implements _$DashboardItemCopyWith<$Res> {
  __$DashboardItemCopyWithImpl(this._self, this._then);

  final _DashboardItem _self;
  final $Res Function(_DashboardItem) _then;

/// Create a copy of DashboardItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? subtitle = null,Object? assetImagePath = null,Object? bgColorValue = null,Object? route = null,}) {
  return _then(_DashboardItem(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,assetImagePath: null == assetImagePath ? _self.assetImagePath : assetImagePath // ignore: cast_nullable_to_non_nullable
as String,bgColorValue: null == bgColorValue ? _self.bgColorValue : bgColorValue // ignore: cast_nullable_to_non_nullable
as int,route: null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
