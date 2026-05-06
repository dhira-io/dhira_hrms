// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'performance_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PerformanceEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PerformanceEvent()';
}


}

/// @nodoc
class $PerformanceEventCopyWith<$Res>  {
$PerformanceEventCopyWith(PerformanceEvent _, $Res Function(PerformanceEvent) __);
}


/// Adds pattern-matching-related methods to [PerformanceEvent].
extension PerformanceEventPatterns on PerformanceEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PerformanceStarted value)?  started,TResult Function( PerformanceFetchRequested value)?  fetchRequested,TResult Function( PerformanceKraUpdated value)?  kraUpdated,TResult Function( PerformanceKraDeleted value)?  kraDeleted,TResult Function( PerformanceKraCreated value)?  kraCreated,TResult Function( PerformanceKpiUpdated value)?  kpiUpdated,TResult Function( PerformanceKpiDeleted value)?  kpiDeleted,TResult Function( PerformanceKpiCreated value)?  kpiCreated,TResult Function( PerformanceGoalSaved value)?  goalSaved,TResult Function( PerformanceGoalSubmitted value)?  goalSubmitted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PerformanceStarted() when started != null:
return started(_that);case PerformanceFetchRequested() when fetchRequested != null:
return fetchRequested(_that);case PerformanceKraUpdated() when kraUpdated != null:
return kraUpdated(_that);case PerformanceKraDeleted() when kraDeleted != null:
return kraDeleted(_that);case PerformanceKraCreated() when kraCreated != null:
return kraCreated(_that);case PerformanceKpiUpdated() when kpiUpdated != null:
return kpiUpdated(_that);case PerformanceKpiDeleted() when kpiDeleted != null:
return kpiDeleted(_that);case PerformanceKpiCreated() when kpiCreated != null:
return kpiCreated(_that);case PerformanceGoalSaved() when goalSaved != null:
return goalSaved(_that);case PerformanceGoalSubmitted() when goalSubmitted != null:
return goalSubmitted(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PerformanceStarted value)  started,required TResult Function( PerformanceFetchRequested value)  fetchRequested,required TResult Function( PerformanceKraUpdated value)  kraUpdated,required TResult Function( PerformanceKraDeleted value)  kraDeleted,required TResult Function( PerformanceKraCreated value)  kraCreated,required TResult Function( PerformanceKpiUpdated value)  kpiUpdated,required TResult Function( PerformanceKpiDeleted value)  kpiDeleted,required TResult Function( PerformanceKpiCreated value)  kpiCreated,required TResult Function( PerformanceGoalSaved value)  goalSaved,required TResult Function( PerformanceGoalSubmitted value)  goalSubmitted,}){
final _that = this;
switch (_that) {
case PerformanceStarted():
return started(_that);case PerformanceFetchRequested():
return fetchRequested(_that);case PerformanceKraUpdated():
return kraUpdated(_that);case PerformanceKraDeleted():
return kraDeleted(_that);case PerformanceKraCreated():
return kraCreated(_that);case PerformanceKpiUpdated():
return kpiUpdated(_that);case PerformanceKpiDeleted():
return kpiDeleted(_that);case PerformanceKpiCreated():
return kpiCreated(_that);case PerformanceGoalSaved():
return goalSaved(_that);case PerformanceGoalSubmitted():
return goalSubmitted(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PerformanceStarted value)?  started,TResult? Function( PerformanceFetchRequested value)?  fetchRequested,TResult? Function( PerformanceKraUpdated value)?  kraUpdated,TResult? Function( PerformanceKraDeleted value)?  kraDeleted,TResult? Function( PerformanceKraCreated value)?  kraCreated,TResult? Function( PerformanceKpiUpdated value)?  kpiUpdated,TResult? Function( PerformanceKpiDeleted value)?  kpiDeleted,TResult? Function( PerformanceKpiCreated value)?  kpiCreated,TResult? Function( PerformanceGoalSaved value)?  goalSaved,TResult? Function( PerformanceGoalSubmitted value)?  goalSubmitted,}){
final _that = this;
switch (_that) {
case PerformanceStarted() when started != null:
return started(_that);case PerformanceFetchRequested() when fetchRequested != null:
return fetchRequested(_that);case PerformanceKraUpdated() when kraUpdated != null:
return kraUpdated(_that);case PerformanceKraDeleted() when kraDeleted != null:
return kraDeleted(_that);case PerformanceKraCreated() when kraCreated != null:
return kraCreated(_that);case PerformanceKpiUpdated() when kpiUpdated != null:
return kpiUpdated(_that);case PerformanceKpiDeleted() when kpiDeleted != null:
return kpiDeleted(_that);case PerformanceKpiCreated() when kpiCreated != null:
return kpiCreated(_that);case PerformanceGoalSaved() when goalSaved != null:
return goalSaved(_that);case PerformanceGoalSubmitted() when goalSubmitted != null:
return goalSubmitted(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String employeeId)?  fetchRequested,TResult Function( KraEntity oldKra,  String newName,  double newWeightage)?  kraUpdated,TResult Function( KraEntity kra)?  kraDeleted,TResult Function( String name,  double weightage)?  kraCreated,TResult Function( KpiEntity oldKpi,  double newWeightage)?  kpiUpdated,TResult Function( KpiEntity kpi)?  kpiDeleted,TResult Function( String title,  double weightage,  String kra)?  kpiCreated,TResult Function( AppLocalizations l10n)?  goalSaved,TResult Function( AppLocalizations l10n)?  goalSubmitted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PerformanceStarted() when started != null:
return started();case PerformanceFetchRequested() when fetchRequested != null:
return fetchRequested(_that.employeeId);case PerformanceKraUpdated() when kraUpdated != null:
return kraUpdated(_that.oldKra,_that.newName,_that.newWeightage);case PerformanceKraDeleted() when kraDeleted != null:
return kraDeleted(_that.kra);case PerformanceKraCreated() when kraCreated != null:
return kraCreated(_that.name,_that.weightage);case PerformanceKpiUpdated() when kpiUpdated != null:
return kpiUpdated(_that.oldKpi,_that.newWeightage);case PerformanceKpiDeleted() when kpiDeleted != null:
return kpiDeleted(_that.kpi);case PerformanceKpiCreated() when kpiCreated != null:
return kpiCreated(_that.title,_that.weightage,_that.kra);case PerformanceGoalSaved() when goalSaved != null:
return goalSaved(_that.l10n);case PerformanceGoalSubmitted() when goalSubmitted != null:
return goalSubmitted(_that.l10n);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String employeeId)  fetchRequested,required TResult Function( KraEntity oldKra,  String newName,  double newWeightage)  kraUpdated,required TResult Function( KraEntity kra)  kraDeleted,required TResult Function( String name,  double weightage)  kraCreated,required TResult Function( KpiEntity oldKpi,  double newWeightage)  kpiUpdated,required TResult Function( KpiEntity kpi)  kpiDeleted,required TResult Function( String title,  double weightage,  String kra)  kpiCreated,required TResult Function( AppLocalizations l10n)  goalSaved,required TResult Function( AppLocalizations l10n)  goalSubmitted,}) {final _that = this;
switch (_that) {
case PerformanceStarted():
return started();case PerformanceFetchRequested():
return fetchRequested(_that.employeeId);case PerformanceKraUpdated():
return kraUpdated(_that.oldKra,_that.newName,_that.newWeightage);case PerformanceKraDeleted():
return kraDeleted(_that.kra);case PerformanceKraCreated():
return kraCreated(_that.name,_that.weightage);case PerformanceKpiUpdated():
return kpiUpdated(_that.oldKpi,_that.newWeightage);case PerformanceKpiDeleted():
return kpiDeleted(_that.kpi);case PerformanceKpiCreated():
return kpiCreated(_that.title,_that.weightage,_that.kra);case PerformanceGoalSaved():
return goalSaved(_that.l10n);case PerformanceGoalSubmitted():
return goalSubmitted(_that.l10n);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String employeeId)?  fetchRequested,TResult? Function( KraEntity oldKra,  String newName,  double newWeightage)?  kraUpdated,TResult? Function( KraEntity kra)?  kraDeleted,TResult? Function( String name,  double weightage)?  kraCreated,TResult? Function( KpiEntity oldKpi,  double newWeightage)?  kpiUpdated,TResult? Function( KpiEntity kpi)?  kpiDeleted,TResult? Function( String title,  double weightage,  String kra)?  kpiCreated,TResult? Function( AppLocalizations l10n)?  goalSaved,TResult? Function( AppLocalizations l10n)?  goalSubmitted,}) {final _that = this;
switch (_that) {
case PerformanceStarted() when started != null:
return started();case PerformanceFetchRequested() when fetchRequested != null:
return fetchRequested(_that.employeeId);case PerformanceKraUpdated() when kraUpdated != null:
return kraUpdated(_that.oldKra,_that.newName,_that.newWeightage);case PerformanceKraDeleted() when kraDeleted != null:
return kraDeleted(_that.kra);case PerformanceKraCreated() when kraCreated != null:
return kraCreated(_that.name,_that.weightage);case PerformanceKpiUpdated() when kpiUpdated != null:
return kpiUpdated(_that.oldKpi,_that.newWeightage);case PerformanceKpiDeleted() when kpiDeleted != null:
return kpiDeleted(_that.kpi);case PerformanceKpiCreated() when kpiCreated != null:
return kpiCreated(_that.title,_that.weightage,_that.kra);case PerformanceGoalSaved() when goalSaved != null:
return goalSaved(_that.l10n);case PerformanceGoalSubmitted() when goalSubmitted != null:
return goalSubmitted(_that.l10n);case _:
  return null;

}
}

}

/// @nodoc


class PerformanceStarted implements PerformanceEvent {
  const PerformanceStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PerformanceEvent.started()';
}


}




/// @nodoc


class PerformanceFetchRequested implements PerformanceEvent {
  const PerformanceFetchRequested(this.employeeId);
  

 final  String employeeId;

/// Create a copy of PerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceFetchRequestedCopyWith<PerformanceFetchRequested> get copyWith => _$PerformanceFetchRequestedCopyWithImpl<PerformanceFetchRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceFetchRequested&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId));
}


@override
int get hashCode => Object.hash(runtimeType,employeeId);

@override
String toString() {
  return 'PerformanceEvent.fetchRequested(employeeId: $employeeId)';
}


}

/// @nodoc
abstract mixin class $PerformanceFetchRequestedCopyWith<$Res> implements $PerformanceEventCopyWith<$Res> {
  factory $PerformanceFetchRequestedCopyWith(PerformanceFetchRequested value, $Res Function(PerformanceFetchRequested) _then) = _$PerformanceFetchRequestedCopyWithImpl;
@useResult
$Res call({
 String employeeId
});




}
/// @nodoc
class _$PerformanceFetchRequestedCopyWithImpl<$Res>
    implements $PerformanceFetchRequestedCopyWith<$Res> {
  _$PerformanceFetchRequestedCopyWithImpl(this._self, this._then);

  final PerformanceFetchRequested _self;
  final $Res Function(PerformanceFetchRequested) _then;

/// Create a copy of PerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? employeeId = null,}) {
  return _then(PerformanceFetchRequested(
null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class PerformanceKraUpdated implements PerformanceEvent {
  const PerformanceKraUpdated({required this.oldKra, required this.newName, required this.newWeightage});
  

 final  KraEntity oldKra;
 final  String newName;
 final  double newWeightage;

/// Create a copy of PerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceKraUpdatedCopyWith<PerformanceKraUpdated> get copyWith => _$PerformanceKraUpdatedCopyWithImpl<PerformanceKraUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceKraUpdated&&(identical(other.oldKra, oldKra) || other.oldKra == oldKra)&&(identical(other.newName, newName) || other.newName == newName)&&(identical(other.newWeightage, newWeightage) || other.newWeightage == newWeightage));
}


@override
int get hashCode => Object.hash(runtimeType,oldKra,newName,newWeightage);

@override
String toString() {
  return 'PerformanceEvent.kraUpdated(oldKra: $oldKra, newName: $newName, newWeightage: $newWeightage)';
}


}

/// @nodoc
abstract mixin class $PerformanceKraUpdatedCopyWith<$Res> implements $PerformanceEventCopyWith<$Res> {
  factory $PerformanceKraUpdatedCopyWith(PerformanceKraUpdated value, $Res Function(PerformanceKraUpdated) _then) = _$PerformanceKraUpdatedCopyWithImpl;
@useResult
$Res call({
 KraEntity oldKra, String newName, double newWeightage
});


$KraEntityCopyWith<$Res> get oldKra;

}
/// @nodoc
class _$PerformanceKraUpdatedCopyWithImpl<$Res>
    implements $PerformanceKraUpdatedCopyWith<$Res> {
  _$PerformanceKraUpdatedCopyWithImpl(this._self, this._then);

  final PerformanceKraUpdated _self;
  final $Res Function(PerformanceKraUpdated) _then;

/// Create a copy of PerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? oldKra = null,Object? newName = null,Object? newWeightage = null,}) {
  return _then(PerformanceKraUpdated(
oldKra: null == oldKra ? _self.oldKra : oldKra // ignore: cast_nullable_to_non_nullable
as KraEntity,newName: null == newName ? _self.newName : newName // ignore: cast_nullable_to_non_nullable
as String,newWeightage: null == newWeightage ? _self.newWeightage : newWeightage // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of PerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KraEntityCopyWith<$Res> get oldKra {
  
  return $KraEntityCopyWith<$Res>(_self.oldKra, (value) {
    return _then(_self.copyWith(oldKra: value));
  });
}
}

/// @nodoc


class PerformanceKraDeleted implements PerformanceEvent {
  const PerformanceKraDeleted(this.kra);
  

 final  KraEntity kra;

/// Create a copy of PerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceKraDeletedCopyWith<PerformanceKraDeleted> get copyWith => _$PerformanceKraDeletedCopyWithImpl<PerformanceKraDeleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceKraDeleted&&(identical(other.kra, kra) || other.kra == kra));
}


@override
int get hashCode => Object.hash(runtimeType,kra);

@override
String toString() {
  return 'PerformanceEvent.kraDeleted(kra: $kra)';
}


}

/// @nodoc
abstract mixin class $PerformanceKraDeletedCopyWith<$Res> implements $PerformanceEventCopyWith<$Res> {
  factory $PerformanceKraDeletedCopyWith(PerformanceKraDeleted value, $Res Function(PerformanceKraDeleted) _then) = _$PerformanceKraDeletedCopyWithImpl;
@useResult
$Res call({
 KraEntity kra
});


$KraEntityCopyWith<$Res> get kra;

}
/// @nodoc
class _$PerformanceKraDeletedCopyWithImpl<$Res>
    implements $PerformanceKraDeletedCopyWith<$Res> {
  _$PerformanceKraDeletedCopyWithImpl(this._self, this._then);

  final PerformanceKraDeleted _self;
  final $Res Function(PerformanceKraDeleted) _then;

/// Create a copy of PerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? kra = null,}) {
  return _then(PerformanceKraDeleted(
null == kra ? _self.kra : kra // ignore: cast_nullable_to_non_nullable
as KraEntity,
  ));
}

/// Create a copy of PerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KraEntityCopyWith<$Res> get kra {
  
  return $KraEntityCopyWith<$Res>(_self.kra, (value) {
    return _then(_self.copyWith(kra: value));
  });
}
}

/// @nodoc


class PerformanceKraCreated implements PerformanceEvent {
  const PerformanceKraCreated({required this.name, required this.weightage});
  

 final  String name;
 final  double weightage;

/// Create a copy of PerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceKraCreatedCopyWith<PerformanceKraCreated> get copyWith => _$PerformanceKraCreatedCopyWithImpl<PerformanceKraCreated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceKraCreated&&(identical(other.name, name) || other.name == name)&&(identical(other.weightage, weightage) || other.weightage == weightage));
}


@override
int get hashCode => Object.hash(runtimeType,name,weightage);

@override
String toString() {
  return 'PerformanceEvent.kraCreated(name: $name, weightage: $weightage)';
}


}

/// @nodoc
abstract mixin class $PerformanceKraCreatedCopyWith<$Res> implements $PerformanceEventCopyWith<$Res> {
  factory $PerformanceKraCreatedCopyWith(PerformanceKraCreated value, $Res Function(PerformanceKraCreated) _then) = _$PerformanceKraCreatedCopyWithImpl;
@useResult
$Res call({
 String name, double weightage
});




}
/// @nodoc
class _$PerformanceKraCreatedCopyWithImpl<$Res>
    implements $PerformanceKraCreatedCopyWith<$Res> {
  _$PerformanceKraCreatedCopyWithImpl(this._self, this._then);

  final PerformanceKraCreated _self;
  final $Res Function(PerformanceKraCreated) _then;

/// Create a copy of PerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? weightage = null,}) {
  return _then(PerformanceKraCreated(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,weightage: null == weightage ? _self.weightage : weightage // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class PerformanceKpiUpdated implements PerformanceEvent {
  const PerformanceKpiUpdated({required this.oldKpi, required this.newWeightage});
  

 final  KpiEntity oldKpi;
 final  double newWeightage;

/// Create a copy of PerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceKpiUpdatedCopyWith<PerformanceKpiUpdated> get copyWith => _$PerformanceKpiUpdatedCopyWithImpl<PerformanceKpiUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceKpiUpdated&&(identical(other.oldKpi, oldKpi) || other.oldKpi == oldKpi)&&(identical(other.newWeightage, newWeightage) || other.newWeightage == newWeightage));
}


@override
int get hashCode => Object.hash(runtimeType,oldKpi,newWeightage);

@override
String toString() {
  return 'PerformanceEvent.kpiUpdated(oldKpi: $oldKpi, newWeightage: $newWeightage)';
}


}

/// @nodoc
abstract mixin class $PerformanceKpiUpdatedCopyWith<$Res> implements $PerformanceEventCopyWith<$Res> {
  factory $PerformanceKpiUpdatedCopyWith(PerformanceKpiUpdated value, $Res Function(PerformanceKpiUpdated) _then) = _$PerformanceKpiUpdatedCopyWithImpl;
@useResult
$Res call({
 KpiEntity oldKpi, double newWeightage
});


$KpiEntityCopyWith<$Res> get oldKpi;

}
/// @nodoc
class _$PerformanceKpiUpdatedCopyWithImpl<$Res>
    implements $PerformanceKpiUpdatedCopyWith<$Res> {
  _$PerformanceKpiUpdatedCopyWithImpl(this._self, this._then);

  final PerformanceKpiUpdated _self;
  final $Res Function(PerformanceKpiUpdated) _then;

/// Create a copy of PerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? oldKpi = null,Object? newWeightage = null,}) {
  return _then(PerformanceKpiUpdated(
oldKpi: null == oldKpi ? _self.oldKpi : oldKpi // ignore: cast_nullable_to_non_nullable
as KpiEntity,newWeightage: null == newWeightage ? _self.newWeightage : newWeightage // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of PerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KpiEntityCopyWith<$Res> get oldKpi {
  
  return $KpiEntityCopyWith<$Res>(_self.oldKpi, (value) {
    return _then(_self.copyWith(oldKpi: value));
  });
}
}

/// @nodoc


class PerformanceKpiDeleted implements PerformanceEvent {
  const PerformanceKpiDeleted(this.kpi);
  

 final  KpiEntity kpi;

/// Create a copy of PerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceKpiDeletedCopyWith<PerformanceKpiDeleted> get copyWith => _$PerformanceKpiDeletedCopyWithImpl<PerformanceKpiDeleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceKpiDeleted&&(identical(other.kpi, kpi) || other.kpi == kpi));
}


@override
int get hashCode => Object.hash(runtimeType,kpi);

@override
String toString() {
  return 'PerformanceEvent.kpiDeleted(kpi: $kpi)';
}


}

/// @nodoc
abstract mixin class $PerformanceKpiDeletedCopyWith<$Res> implements $PerformanceEventCopyWith<$Res> {
  factory $PerformanceKpiDeletedCopyWith(PerformanceKpiDeleted value, $Res Function(PerformanceKpiDeleted) _then) = _$PerformanceKpiDeletedCopyWithImpl;
@useResult
$Res call({
 KpiEntity kpi
});


$KpiEntityCopyWith<$Res> get kpi;

}
/// @nodoc
class _$PerformanceKpiDeletedCopyWithImpl<$Res>
    implements $PerformanceKpiDeletedCopyWith<$Res> {
  _$PerformanceKpiDeletedCopyWithImpl(this._self, this._then);

  final PerformanceKpiDeleted _self;
  final $Res Function(PerformanceKpiDeleted) _then;

/// Create a copy of PerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? kpi = null,}) {
  return _then(PerformanceKpiDeleted(
null == kpi ? _self.kpi : kpi // ignore: cast_nullable_to_non_nullable
as KpiEntity,
  ));
}

/// Create a copy of PerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KpiEntityCopyWith<$Res> get kpi {
  
  return $KpiEntityCopyWith<$Res>(_self.kpi, (value) {
    return _then(_self.copyWith(kpi: value));
  });
}
}

/// @nodoc


class PerformanceKpiCreated implements PerformanceEvent {
  const PerformanceKpiCreated({required this.title, required this.weightage, required this.kra});
  

 final  String title;
 final  double weightage;
 final  String kra;

/// Create a copy of PerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceKpiCreatedCopyWith<PerformanceKpiCreated> get copyWith => _$PerformanceKpiCreatedCopyWithImpl<PerformanceKpiCreated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceKpiCreated&&(identical(other.title, title) || other.title == title)&&(identical(other.weightage, weightage) || other.weightage == weightage)&&(identical(other.kra, kra) || other.kra == kra));
}


@override
int get hashCode => Object.hash(runtimeType,title,weightage,kra);

@override
String toString() {
  return 'PerformanceEvent.kpiCreated(title: $title, weightage: $weightage, kra: $kra)';
}


}

/// @nodoc
abstract mixin class $PerformanceKpiCreatedCopyWith<$Res> implements $PerformanceEventCopyWith<$Res> {
  factory $PerformanceKpiCreatedCopyWith(PerformanceKpiCreated value, $Res Function(PerformanceKpiCreated) _then) = _$PerformanceKpiCreatedCopyWithImpl;
@useResult
$Res call({
 String title, double weightage, String kra
});




}
/// @nodoc
class _$PerformanceKpiCreatedCopyWithImpl<$Res>
    implements $PerformanceKpiCreatedCopyWith<$Res> {
  _$PerformanceKpiCreatedCopyWithImpl(this._self, this._then);

  final PerformanceKpiCreated _self;
  final $Res Function(PerformanceKpiCreated) _then;

/// Create a copy of PerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? title = null,Object? weightage = null,Object? kra = null,}) {
  return _then(PerformanceKpiCreated(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,weightage: null == weightage ? _self.weightage : weightage // ignore: cast_nullable_to_non_nullable
as double,kra: null == kra ? _self.kra : kra // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class PerformanceGoalSaved implements PerformanceEvent {
  const PerformanceGoalSaved({required this.l10n});
  

 final  AppLocalizations l10n;

/// Create a copy of PerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceGoalSavedCopyWith<PerformanceGoalSaved> get copyWith => _$PerformanceGoalSavedCopyWithImpl<PerformanceGoalSaved>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceGoalSaved&&(identical(other.l10n, l10n) || other.l10n == l10n));
}


@override
int get hashCode => Object.hash(runtimeType,l10n);

@override
String toString() {
  return 'PerformanceEvent.goalSaved(l10n: $l10n)';
}


}

/// @nodoc
abstract mixin class $PerformanceGoalSavedCopyWith<$Res> implements $PerformanceEventCopyWith<$Res> {
  factory $PerformanceGoalSavedCopyWith(PerformanceGoalSaved value, $Res Function(PerformanceGoalSaved) _then) = _$PerformanceGoalSavedCopyWithImpl;
@useResult
$Res call({
 AppLocalizations l10n
});




}
/// @nodoc
class _$PerformanceGoalSavedCopyWithImpl<$Res>
    implements $PerformanceGoalSavedCopyWith<$Res> {
  _$PerformanceGoalSavedCopyWithImpl(this._self, this._then);

  final PerformanceGoalSaved _self;
  final $Res Function(PerformanceGoalSaved) _then;

/// Create a copy of PerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? l10n = null,}) {
  return _then(PerformanceGoalSaved(
l10n: null == l10n ? _self.l10n : l10n // ignore: cast_nullable_to_non_nullable
as AppLocalizations,
  ));
}


}

/// @nodoc


class PerformanceGoalSubmitted implements PerformanceEvent {
  const PerformanceGoalSubmitted({required this.l10n});
  

 final  AppLocalizations l10n;

/// Create a copy of PerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceGoalSubmittedCopyWith<PerformanceGoalSubmitted> get copyWith => _$PerformanceGoalSubmittedCopyWithImpl<PerformanceGoalSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceGoalSubmitted&&(identical(other.l10n, l10n) || other.l10n == l10n));
}


@override
int get hashCode => Object.hash(runtimeType,l10n);

@override
String toString() {
  return 'PerformanceEvent.goalSubmitted(l10n: $l10n)';
}


}

/// @nodoc
abstract mixin class $PerformanceGoalSubmittedCopyWith<$Res> implements $PerformanceEventCopyWith<$Res> {
  factory $PerformanceGoalSubmittedCopyWith(PerformanceGoalSubmitted value, $Res Function(PerformanceGoalSubmitted) _then) = _$PerformanceGoalSubmittedCopyWithImpl;
@useResult
$Res call({
 AppLocalizations l10n
});




}
/// @nodoc
class _$PerformanceGoalSubmittedCopyWithImpl<$Res>
    implements $PerformanceGoalSubmittedCopyWith<$Res> {
  _$PerformanceGoalSubmittedCopyWithImpl(this._self, this._then);

  final PerformanceGoalSubmitted _self;
  final $Res Function(PerformanceGoalSubmitted) _then;

/// Create a copy of PerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? l10n = null,}) {
  return _then(PerformanceGoalSubmitted(
l10n: null == l10n ? _self.l10n : l10n // ignore: cast_nullable_to_non_nullable
as AppLocalizations,
  ));
}


}

// dart format on
