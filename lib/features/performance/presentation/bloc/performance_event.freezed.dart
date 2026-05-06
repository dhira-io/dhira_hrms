// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'performance_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PerformanceEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String employeeId) fetchRequested,
    required TResult Function(
      KraEntity oldKra,
      String newName,
      double newWeightage,
    )
    kraUpdated,
    required TResult Function(KraEntity kra) kraDeleted,
    required TResult Function(String name, double weightage) kraCreated,
    required TResult Function(KpiEntity oldKpi, double newWeightage) kpiUpdated,
    required TResult Function(KpiEntity kpi) kpiDeleted,
    required TResult Function(String title, double weightage, String kra)
    kpiCreated,
    required TResult Function(AppLocalizations l10n) goalSaved,
    required TResult Function(AppLocalizations l10n) goalSubmitted,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String employeeId)? fetchRequested,
    TResult? Function(KraEntity oldKra, String newName, double newWeightage)?
    kraUpdated,
    TResult? Function(KraEntity kra)? kraDeleted,
    TResult? Function(String name, double weightage)? kraCreated,
    TResult? Function(KpiEntity oldKpi, double newWeightage)? kpiUpdated,
    TResult? Function(KpiEntity kpi)? kpiDeleted,
    TResult? Function(String title, double weightage, String kra)? kpiCreated,
    TResult? Function(AppLocalizations l10n)? goalSaved,
    TResult? Function(AppLocalizations l10n)? goalSubmitted,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String employeeId)? fetchRequested,
    TResult Function(KraEntity oldKra, String newName, double newWeightage)?
    kraUpdated,
    TResult Function(KraEntity kra)? kraDeleted,
    TResult Function(String name, double weightage)? kraCreated,
    TResult Function(KpiEntity oldKpi, double newWeightage)? kpiUpdated,
    TResult Function(KpiEntity kpi)? kpiDeleted,
    TResult Function(String title, double weightage, String kra)? kpiCreated,
    TResult Function(AppLocalizations l10n)? goalSaved,
    TResult Function(AppLocalizations l10n)? goalSubmitted,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PerformanceStarted value) started,
    required TResult Function(PerformanceFetchRequested value) fetchRequested,
    required TResult Function(PerformanceKraUpdated value) kraUpdated,
    required TResult Function(PerformanceKraDeleted value) kraDeleted,
    required TResult Function(PerformanceKraCreated value) kraCreated,
    required TResult Function(PerformanceKpiUpdated value) kpiUpdated,
    required TResult Function(PerformanceKpiDeleted value) kpiDeleted,
    required TResult Function(PerformanceKpiCreated value) kpiCreated,
    required TResult Function(PerformanceGoalSaved value) goalSaved,
    required TResult Function(PerformanceGoalSubmitted value) goalSubmitted,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PerformanceStarted value)? started,
    TResult? Function(PerformanceFetchRequested value)? fetchRequested,
    TResult? Function(PerformanceKraUpdated value)? kraUpdated,
    TResult? Function(PerformanceKraDeleted value)? kraDeleted,
    TResult? Function(PerformanceKraCreated value)? kraCreated,
    TResult? Function(PerformanceKpiUpdated value)? kpiUpdated,
    TResult? Function(PerformanceKpiDeleted value)? kpiDeleted,
    TResult? Function(PerformanceKpiCreated value)? kpiCreated,
    TResult? Function(PerformanceGoalSaved value)? goalSaved,
    TResult? Function(PerformanceGoalSubmitted value)? goalSubmitted,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PerformanceStarted value)? started,
    TResult Function(PerformanceFetchRequested value)? fetchRequested,
    TResult Function(PerformanceKraUpdated value)? kraUpdated,
    TResult Function(PerformanceKraDeleted value)? kraDeleted,
    TResult Function(PerformanceKraCreated value)? kraCreated,
    TResult Function(PerformanceKpiUpdated value)? kpiUpdated,
    TResult Function(PerformanceKpiDeleted value)? kpiDeleted,
    TResult Function(PerformanceKpiCreated value)? kpiCreated,
    TResult Function(PerformanceGoalSaved value)? goalSaved,
    TResult Function(PerformanceGoalSubmitted value)? goalSubmitted,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PerformanceEventCopyWith<$Res> {
  factory $PerformanceEventCopyWith(
    PerformanceEvent value,
    $Res Function(PerformanceEvent) then,
  ) = _$PerformanceEventCopyWithImpl<$Res, PerformanceEvent>;
}

/// @nodoc
class _$PerformanceEventCopyWithImpl<$Res, $Val extends PerformanceEvent>
    implements $PerformanceEventCopyWith<$Res> {
  _$PerformanceEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PerformanceStartedImplCopyWith<$Res> {
  factory _$$PerformanceStartedImplCopyWith(
    _$PerformanceStartedImpl value,
    $Res Function(_$PerformanceStartedImpl) then,
  ) = __$$PerformanceStartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PerformanceStartedImplCopyWithImpl<$Res>
    extends _$PerformanceEventCopyWithImpl<$Res, _$PerformanceStartedImpl>
    implements _$$PerformanceStartedImplCopyWith<$Res> {
  __$$PerformanceStartedImplCopyWithImpl(
    _$PerformanceStartedImpl _value,
    $Res Function(_$PerformanceStartedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PerformanceStartedImpl implements PerformanceStarted {
  const _$PerformanceStartedImpl();

  @override
  String toString() {
    return 'PerformanceEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PerformanceStartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String employeeId) fetchRequested,
    required TResult Function(
      KraEntity oldKra,
      String newName,
      double newWeightage,
    )
    kraUpdated,
    required TResult Function(KraEntity kra) kraDeleted,
    required TResult Function(String name, double weightage) kraCreated,
    required TResult Function(KpiEntity oldKpi, double newWeightage) kpiUpdated,
    required TResult Function(KpiEntity kpi) kpiDeleted,
    required TResult Function(String title, double weightage, String kra)
    kpiCreated,
    required TResult Function(AppLocalizations l10n) goalSaved,
    required TResult Function(AppLocalizations l10n) goalSubmitted,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String employeeId)? fetchRequested,
    TResult? Function(KraEntity oldKra, String newName, double newWeightage)?
    kraUpdated,
    TResult? Function(KraEntity kra)? kraDeleted,
    TResult? Function(String name, double weightage)? kraCreated,
    TResult? Function(KpiEntity oldKpi, double newWeightage)? kpiUpdated,
    TResult? Function(KpiEntity kpi)? kpiDeleted,
    TResult? Function(String title, double weightage, String kra)? kpiCreated,
    TResult? Function(AppLocalizations l10n)? goalSaved,
    TResult? Function(AppLocalizations l10n)? goalSubmitted,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String employeeId)? fetchRequested,
    TResult Function(KraEntity oldKra, String newName, double newWeightage)?
    kraUpdated,
    TResult Function(KraEntity kra)? kraDeleted,
    TResult Function(String name, double weightage)? kraCreated,
    TResult Function(KpiEntity oldKpi, double newWeightage)? kpiUpdated,
    TResult Function(KpiEntity kpi)? kpiDeleted,
    TResult Function(String title, double weightage, String kra)? kpiCreated,
    TResult Function(AppLocalizations l10n)? goalSaved,
    TResult Function(AppLocalizations l10n)? goalSubmitted,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PerformanceStarted value) started,
    required TResult Function(PerformanceFetchRequested value) fetchRequested,
    required TResult Function(PerformanceKraUpdated value) kraUpdated,
    required TResult Function(PerformanceKraDeleted value) kraDeleted,
    required TResult Function(PerformanceKraCreated value) kraCreated,
    required TResult Function(PerformanceKpiUpdated value) kpiUpdated,
    required TResult Function(PerformanceKpiDeleted value) kpiDeleted,
    required TResult Function(PerformanceKpiCreated value) kpiCreated,
    required TResult Function(PerformanceGoalSaved value) goalSaved,
    required TResult Function(PerformanceGoalSubmitted value) goalSubmitted,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PerformanceStarted value)? started,
    TResult? Function(PerformanceFetchRequested value)? fetchRequested,
    TResult? Function(PerformanceKraUpdated value)? kraUpdated,
    TResult? Function(PerformanceKraDeleted value)? kraDeleted,
    TResult? Function(PerformanceKraCreated value)? kraCreated,
    TResult? Function(PerformanceKpiUpdated value)? kpiUpdated,
    TResult? Function(PerformanceKpiDeleted value)? kpiDeleted,
    TResult? Function(PerformanceKpiCreated value)? kpiCreated,
    TResult? Function(PerformanceGoalSaved value)? goalSaved,
    TResult? Function(PerformanceGoalSubmitted value)? goalSubmitted,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PerformanceStarted value)? started,
    TResult Function(PerformanceFetchRequested value)? fetchRequested,
    TResult Function(PerformanceKraUpdated value)? kraUpdated,
    TResult Function(PerformanceKraDeleted value)? kraDeleted,
    TResult Function(PerformanceKraCreated value)? kraCreated,
    TResult Function(PerformanceKpiUpdated value)? kpiUpdated,
    TResult Function(PerformanceKpiDeleted value)? kpiDeleted,
    TResult Function(PerformanceKpiCreated value)? kpiCreated,
    TResult Function(PerformanceGoalSaved value)? goalSaved,
    TResult Function(PerformanceGoalSubmitted value)? goalSubmitted,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class PerformanceStarted implements PerformanceEvent {
  const factory PerformanceStarted() = _$PerformanceStartedImpl;
}

/// @nodoc
abstract class _$$PerformanceFetchRequestedImplCopyWith<$Res> {
  factory _$$PerformanceFetchRequestedImplCopyWith(
    _$PerformanceFetchRequestedImpl value,
    $Res Function(_$PerformanceFetchRequestedImpl) then,
  ) = __$$PerformanceFetchRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String employeeId});
}

/// @nodoc
class __$$PerformanceFetchRequestedImplCopyWithImpl<$Res>
    extends
        _$PerformanceEventCopyWithImpl<$Res, _$PerformanceFetchRequestedImpl>
    implements _$$PerformanceFetchRequestedImplCopyWith<$Res> {
  __$$PerformanceFetchRequestedImplCopyWithImpl(
    _$PerformanceFetchRequestedImpl _value,
    $Res Function(_$PerformanceFetchRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? employeeId = null}) {
    return _then(
      _$PerformanceFetchRequestedImpl(
        null == employeeId
            ? _value.employeeId
            : employeeId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$PerformanceFetchRequestedImpl implements PerformanceFetchRequested {
  const _$PerformanceFetchRequestedImpl(this.employeeId);

  @override
  final String employeeId;

  @override
  String toString() {
    return 'PerformanceEvent.fetchRequested(employeeId: $employeeId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PerformanceFetchRequestedImpl &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, employeeId);

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PerformanceFetchRequestedImplCopyWith<_$PerformanceFetchRequestedImpl>
  get copyWith =>
      __$$PerformanceFetchRequestedImplCopyWithImpl<
        _$PerformanceFetchRequestedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String employeeId) fetchRequested,
    required TResult Function(
      KraEntity oldKra,
      String newName,
      double newWeightage,
    )
    kraUpdated,
    required TResult Function(KraEntity kra) kraDeleted,
    required TResult Function(String name, double weightage) kraCreated,
    required TResult Function(KpiEntity oldKpi, double newWeightage) kpiUpdated,
    required TResult Function(KpiEntity kpi) kpiDeleted,
    required TResult Function(String title, double weightage, String kra)
    kpiCreated,
    required TResult Function(AppLocalizations l10n) goalSaved,
    required TResult Function(AppLocalizations l10n) goalSubmitted,
  }) {
    return fetchRequested(employeeId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String employeeId)? fetchRequested,
    TResult? Function(KraEntity oldKra, String newName, double newWeightage)?
    kraUpdated,
    TResult? Function(KraEntity kra)? kraDeleted,
    TResult? Function(String name, double weightage)? kraCreated,
    TResult? Function(KpiEntity oldKpi, double newWeightage)? kpiUpdated,
    TResult? Function(KpiEntity kpi)? kpiDeleted,
    TResult? Function(String title, double weightage, String kra)? kpiCreated,
    TResult? Function(AppLocalizations l10n)? goalSaved,
    TResult? Function(AppLocalizations l10n)? goalSubmitted,
  }) {
    return fetchRequested?.call(employeeId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String employeeId)? fetchRequested,
    TResult Function(KraEntity oldKra, String newName, double newWeightage)?
    kraUpdated,
    TResult Function(KraEntity kra)? kraDeleted,
    TResult Function(String name, double weightage)? kraCreated,
    TResult Function(KpiEntity oldKpi, double newWeightage)? kpiUpdated,
    TResult Function(KpiEntity kpi)? kpiDeleted,
    TResult Function(String title, double weightage, String kra)? kpiCreated,
    TResult Function(AppLocalizations l10n)? goalSaved,
    TResult Function(AppLocalizations l10n)? goalSubmitted,
    required TResult orElse(),
  }) {
    if (fetchRequested != null) {
      return fetchRequested(employeeId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PerformanceStarted value) started,
    required TResult Function(PerformanceFetchRequested value) fetchRequested,
    required TResult Function(PerformanceKraUpdated value) kraUpdated,
    required TResult Function(PerformanceKraDeleted value) kraDeleted,
    required TResult Function(PerformanceKraCreated value) kraCreated,
    required TResult Function(PerformanceKpiUpdated value) kpiUpdated,
    required TResult Function(PerformanceKpiDeleted value) kpiDeleted,
    required TResult Function(PerformanceKpiCreated value) kpiCreated,
    required TResult Function(PerformanceGoalSaved value) goalSaved,
    required TResult Function(PerformanceGoalSubmitted value) goalSubmitted,
  }) {
    return fetchRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PerformanceStarted value)? started,
    TResult? Function(PerformanceFetchRequested value)? fetchRequested,
    TResult? Function(PerformanceKraUpdated value)? kraUpdated,
    TResult? Function(PerformanceKraDeleted value)? kraDeleted,
    TResult? Function(PerformanceKraCreated value)? kraCreated,
    TResult? Function(PerformanceKpiUpdated value)? kpiUpdated,
    TResult? Function(PerformanceKpiDeleted value)? kpiDeleted,
    TResult? Function(PerformanceKpiCreated value)? kpiCreated,
    TResult? Function(PerformanceGoalSaved value)? goalSaved,
    TResult? Function(PerformanceGoalSubmitted value)? goalSubmitted,
  }) {
    return fetchRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PerformanceStarted value)? started,
    TResult Function(PerformanceFetchRequested value)? fetchRequested,
    TResult Function(PerformanceKraUpdated value)? kraUpdated,
    TResult Function(PerformanceKraDeleted value)? kraDeleted,
    TResult Function(PerformanceKraCreated value)? kraCreated,
    TResult Function(PerformanceKpiUpdated value)? kpiUpdated,
    TResult Function(PerformanceKpiDeleted value)? kpiDeleted,
    TResult Function(PerformanceKpiCreated value)? kpiCreated,
    TResult Function(PerformanceGoalSaved value)? goalSaved,
    TResult Function(PerformanceGoalSubmitted value)? goalSubmitted,
    required TResult orElse(),
  }) {
    if (fetchRequested != null) {
      return fetchRequested(this);
    }
    return orElse();
  }
}

abstract class PerformanceFetchRequested implements PerformanceEvent {
  const factory PerformanceFetchRequested(final String employeeId) =
      _$PerformanceFetchRequestedImpl;

  String get employeeId;

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PerformanceFetchRequestedImplCopyWith<_$PerformanceFetchRequestedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PerformanceKraUpdatedImplCopyWith<$Res> {
  factory _$$PerformanceKraUpdatedImplCopyWith(
    _$PerformanceKraUpdatedImpl value,
    $Res Function(_$PerformanceKraUpdatedImpl) then,
  ) = __$$PerformanceKraUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({KraEntity oldKra, String newName, double newWeightage});

  $KraEntityCopyWith<$Res> get oldKra;
}

/// @nodoc
class __$$PerformanceKraUpdatedImplCopyWithImpl<$Res>
    extends _$PerformanceEventCopyWithImpl<$Res, _$PerformanceKraUpdatedImpl>
    implements _$$PerformanceKraUpdatedImplCopyWith<$Res> {
  __$$PerformanceKraUpdatedImplCopyWithImpl(
    _$PerformanceKraUpdatedImpl _value,
    $Res Function(_$PerformanceKraUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oldKra = null,
    Object? newName = null,
    Object? newWeightage = null,
  }) {
    return _then(
      _$PerformanceKraUpdatedImpl(
        oldKra: null == oldKra
            ? _value.oldKra
            : oldKra // ignore: cast_nullable_to_non_nullable
                  as KraEntity,
        newName: null == newName
            ? _value.newName
            : newName // ignore: cast_nullable_to_non_nullable
                  as String,
        newWeightage: null == newWeightage
            ? _value.newWeightage
            : newWeightage // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $KraEntityCopyWith<$Res> get oldKra {
    return $KraEntityCopyWith<$Res>(_value.oldKra, (value) {
      return _then(_value.copyWith(oldKra: value));
    });
  }
}

/// @nodoc

class _$PerformanceKraUpdatedImpl implements PerformanceKraUpdated {
  const _$PerformanceKraUpdatedImpl({
    required this.oldKra,
    required this.newName,
    required this.newWeightage,
  });

  @override
  final KraEntity oldKra;
  @override
  final String newName;
  @override
  final double newWeightage;

  @override
  String toString() {
    return 'PerformanceEvent.kraUpdated(oldKra: $oldKra, newName: $newName, newWeightage: $newWeightage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PerformanceKraUpdatedImpl &&
            (identical(other.oldKra, oldKra) || other.oldKra == oldKra) &&
            (identical(other.newName, newName) || other.newName == newName) &&
            (identical(other.newWeightage, newWeightage) ||
                other.newWeightage == newWeightage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, oldKra, newName, newWeightage);

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PerformanceKraUpdatedImplCopyWith<_$PerformanceKraUpdatedImpl>
  get copyWith =>
      __$$PerformanceKraUpdatedImplCopyWithImpl<_$PerformanceKraUpdatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String employeeId) fetchRequested,
    required TResult Function(
      KraEntity oldKra,
      String newName,
      double newWeightage,
    )
    kraUpdated,
    required TResult Function(KraEntity kra) kraDeleted,
    required TResult Function(String name, double weightage) kraCreated,
    required TResult Function(KpiEntity oldKpi, double newWeightage) kpiUpdated,
    required TResult Function(KpiEntity kpi) kpiDeleted,
    required TResult Function(String title, double weightage, String kra)
    kpiCreated,
    required TResult Function(AppLocalizations l10n) goalSaved,
    required TResult Function(AppLocalizations l10n) goalSubmitted,
  }) {
    return kraUpdated(oldKra, newName, newWeightage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String employeeId)? fetchRequested,
    TResult? Function(KraEntity oldKra, String newName, double newWeightage)?
    kraUpdated,
    TResult? Function(KraEntity kra)? kraDeleted,
    TResult? Function(String name, double weightage)? kraCreated,
    TResult? Function(KpiEntity oldKpi, double newWeightage)? kpiUpdated,
    TResult? Function(KpiEntity kpi)? kpiDeleted,
    TResult? Function(String title, double weightage, String kra)? kpiCreated,
    TResult? Function(AppLocalizations l10n)? goalSaved,
    TResult? Function(AppLocalizations l10n)? goalSubmitted,
  }) {
    return kraUpdated?.call(oldKra, newName, newWeightage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String employeeId)? fetchRequested,
    TResult Function(KraEntity oldKra, String newName, double newWeightage)?
    kraUpdated,
    TResult Function(KraEntity kra)? kraDeleted,
    TResult Function(String name, double weightage)? kraCreated,
    TResult Function(KpiEntity oldKpi, double newWeightage)? kpiUpdated,
    TResult Function(KpiEntity kpi)? kpiDeleted,
    TResult Function(String title, double weightage, String kra)? kpiCreated,
    TResult Function(AppLocalizations l10n)? goalSaved,
    TResult Function(AppLocalizations l10n)? goalSubmitted,
    required TResult orElse(),
  }) {
    if (kraUpdated != null) {
      return kraUpdated(oldKra, newName, newWeightage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PerformanceStarted value) started,
    required TResult Function(PerformanceFetchRequested value) fetchRequested,
    required TResult Function(PerformanceKraUpdated value) kraUpdated,
    required TResult Function(PerformanceKraDeleted value) kraDeleted,
    required TResult Function(PerformanceKraCreated value) kraCreated,
    required TResult Function(PerformanceKpiUpdated value) kpiUpdated,
    required TResult Function(PerformanceKpiDeleted value) kpiDeleted,
    required TResult Function(PerformanceKpiCreated value) kpiCreated,
    required TResult Function(PerformanceGoalSaved value) goalSaved,
    required TResult Function(PerformanceGoalSubmitted value) goalSubmitted,
  }) {
    return kraUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PerformanceStarted value)? started,
    TResult? Function(PerformanceFetchRequested value)? fetchRequested,
    TResult? Function(PerformanceKraUpdated value)? kraUpdated,
    TResult? Function(PerformanceKraDeleted value)? kraDeleted,
    TResult? Function(PerformanceKraCreated value)? kraCreated,
    TResult? Function(PerformanceKpiUpdated value)? kpiUpdated,
    TResult? Function(PerformanceKpiDeleted value)? kpiDeleted,
    TResult? Function(PerformanceKpiCreated value)? kpiCreated,
    TResult? Function(PerformanceGoalSaved value)? goalSaved,
    TResult? Function(PerformanceGoalSubmitted value)? goalSubmitted,
  }) {
    return kraUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PerformanceStarted value)? started,
    TResult Function(PerformanceFetchRequested value)? fetchRequested,
    TResult Function(PerformanceKraUpdated value)? kraUpdated,
    TResult Function(PerformanceKraDeleted value)? kraDeleted,
    TResult Function(PerformanceKraCreated value)? kraCreated,
    TResult Function(PerformanceKpiUpdated value)? kpiUpdated,
    TResult Function(PerformanceKpiDeleted value)? kpiDeleted,
    TResult Function(PerformanceKpiCreated value)? kpiCreated,
    TResult Function(PerformanceGoalSaved value)? goalSaved,
    TResult Function(PerformanceGoalSubmitted value)? goalSubmitted,
    required TResult orElse(),
  }) {
    if (kraUpdated != null) {
      return kraUpdated(this);
    }
    return orElse();
  }
}

abstract class PerformanceKraUpdated implements PerformanceEvent {
  const factory PerformanceKraUpdated({
    required final KraEntity oldKra,
    required final String newName,
    required final double newWeightage,
  }) = _$PerformanceKraUpdatedImpl;

  KraEntity get oldKra;
  String get newName;
  double get newWeightage;

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PerformanceKraUpdatedImplCopyWith<_$PerformanceKraUpdatedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PerformanceKraDeletedImplCopyWith<$Res> {
  factory _$$PerformanceKraDeletedImplCopyWith(
    _$PerformanceKraDeletedImpl value,
    $Res Function(_$PerformanceKraDeletedImpl) then,
  ) = __$$PerformanceKraDeletedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({KraEntity kra});

  $KraEntityCopyWith<$Res> get kra;
}

/// @nodoc
class __$$PerformanceKraDeletedImplCopyWithImpl<$Res>
    extends _$PerformanceEventCopyWithImpl<$Res, _$PerformanceKraDeletedImpl>
    implements _$$PerformanceKraDeletedImplCopyWith<$Res> {
  __$$PerformanceKraDeletedImplCopyWithImpl(
    _$PerformanceKraDeletedImpl _value,
    $Res Function(_$PerformanceKraDeletedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? kra = null}) {
    return _then(
      _$PerformanceKraDeletedImpl(
        null == kra
            ? _value.kra
            : kra // ignore: cast_nullable_to_non_nullable
                  as KraEntity,
      ),
    );
  }

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $KraEntityCopyWith<$Res> get kra {
    return $KraEntityCopyWith<$Res>(_value.kra, (value) {
      return _then(_value.copyWith(kra: value));
    });
  }
}

/// @nodoc

class _$PerformanceKraDeletedImpl implements PerformanceKraDeleted {
  const _$PerformanceKraDeletedImpl(this.kra);

  @override
  final KraEntity kra;

  @override
  String toString() {
    return 'PerformanceEvent.kraDeleted(kra: $kra)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PerformanceKraDeletedImpl &&
            (identical(other.kra, kra) || other.kra == kra));
  }

  @override
  int get hashCode => Object.hash(runtimeType, kra);

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PerformanceKraDeletedImplCopyWith<_$PerformanceKraDeletedImpl>
  get copyWith =>
      __$$PerformanceKraDeletedImplCopyWithImpl<_$PerformanceKraDeletedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String employeeId) fetchRequested,
    required TResult Function(
      KraEntity oldKra,
      String newName,
      double newWeightage,
    )
    kraUpdated,
    required TResult Function(KraEntity kra) kraDeleted,
    required TResult Function(String name, double weightage) kraCreated,
    required TResult Function(KpiEntity oldKpi, double newWeightage) kpiUpdated,
    required TResult Function(KpiEntity kpi) kpiDeleted,
    required TResult Function(String title, double weightage, String kra)
    kpiCreated,
    required TResult Function(AppLocalizations l10n) goalSaved,
    required TResult Function(AppLocalizations l10n) goalSubmitted,
  }) {
    return kraDeleted(kra);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String employeeId)? fetchRequested,
    TResult? Function(KraEntity oldKra, String newName, double newWeightage)?
    kraUpdated,
    TResult? Function(KraEntity kra)? kraDeleted,
    TResult? Function(String name, double weightage)? kraCreated,
    TResult? Function(KpiEntity oldKpi, double newWeightage)? kpiUpdated,
    TResult? Function(KpiEntity kpi)? kpiDeleted,
    TResult? Function(String title, double weightage, String kra)? kpiCreated,
    TResult? Function(AppLocalizations l10n)? goalSaved,
    TResult? Function(AppLocalizations l10n)? goalSubmitted,
  }) {
    return kraDeleted?.call(kra);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String employeeId)? fetchRequested,
    TResult Function(KraEntity oldKra, String newName, double newWeightage)?
    kraUpdated,
    TResult Function(KraEntity kra)? kraDeleted,
    TResult Function(String name, double weightage)? kraCreated,
    TResult Function(KpiEntity oldKpi, double newWeightage)? kpiUpdated,
    TResult Function(KpiEntity kpi)? kpiDeleted,
    TResult Function(String title, double weightage, String kra)? kpiCreated,
    TResult Function(AppLocalizations l10n)? goalSaved,
    TResult Function(AppLocalizations l10n)? goalSubmitted,
    required TResult orElse(),
  }) {
    if (kraDeleted != null) {
      return kraDeleted(kra);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PerformanceStarted value) started,
    required TResult Function(PerformanceFetchRequested value) fetchRequested,
    required TResult Function(PerformanceKraUpdated value) kraUpdated,
    required TResult Function(PerformanceKraDeleted value) kraDeleted,
    required TResult Function(PerformanceKraCreated value) kraCreated,
    required TResult Function(PerformanceKpiUpdated value) kpiUpdated,
    required TResult Function(PerformanceKpiDeleted value) kpiDeleted,
    required TResult Function(PerformanceKpiCreated value) kpiCreated,
    required TResult Function(PerformanceGoalSaved value) goalSaved,
    required TResult Function(PerformanceGoalSubmitted value) goalSubmitted,
  }) {
    return kraDeleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PerformanceStarted value)? started,
    TResult? Function(PerformanceFetchRequested value)? fetchRequested,
    TResult? Function(PerformanceKraUpdated value)? kraUpdated,
    TResult? Function(PerformanceKraDeleted value)? kraDeleted,
    TResult? Function(PerformanceKraCreated value)? kraCreated,
    TResult? Function(PerformanceKpiUpdated value)? kpiUpdated,
    TResult? Function(PerformanceKpiDeleted value)? kpiDeleted,
    TResult? Function(PerformanceKpiCreated value)? kpiCreated,
    TResult? Function(PerformanceGoalSaved value)? goalSaved,
    TResult? Function(PerformanceGoalSubmitted value)? goalSubmitted,
  }) {
    return kraDeleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PerformanceStarted value)? started,
    TResult Function(PerformanceFetchRequested value)? fetchRequested,
    TResult Function(PerformanceKraUpdated value)? kraUpdated,
    TResult Function(PerformanceKraDeleted value)? kraDeleted,
    TResult Function(PerformanceKraCreated value)? kraCreated,
    TResult Function(PerformanceKpiUpdated value)? kpiUpdated,
    TResult Function(PerformanceKpiDeleted value)? kpiDeleted,
    TResult Function(PerformanceKpiCreated value)? kpiCreated,
    TResult Function(PerformanceGoalSaved value)? goalSaved,
    TResult Function(PerformanceGoalSubmitted value)? goalSubmitted,
    required TResult orElse(),
  }) {
    if (kraDeleted != null) {
      return kraDeleted(this);
    }
    return orElse();
  }
}

abstract class PerformanceKraDeleted implements PerformanceEvent {
  const factory PerformanceKraDeleted(final KraEntity kra) =
      _$PerformanceKraDeletedImpl;

  KraEntity get kra;

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PerformanceKraDeletedImplCopyWith<_$PerformanceKraDeletedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PerformanceKraCreatedImplCopyWith<$Res> {
  factory _$$PerformanceKraCreatedImplCopyWith(
    _$PerformanceKraCreatedImpl value,
    $Res Function(_$PerformanceKraCreatedImpl) then,
  ) = __$$PerformanceKraCreatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String name, double weightage});
}

/// @nodoc
class __$$PerformanceKraCreatedImplCopyWithImpl<$Res>
    extends _$PerformanceEventCopyWithImpl<$Res, _$PerformanceKraCreatedImpl>
    implements _$$PerformanceKraCreatedImplCopyWith<$Res> {
  __$$PerformanceKraCreatedImplCopyWithImpl(
    _$PerformanceKraCreatedImpl _value,
    $Res Function(_$PerformanceKraCreatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? weightage = null}) {
    return _then(
      _$PerformanceKraCreatedImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        weightage: null == weightage
            ? _value.weightage
            : weightage // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$PerformanceKraCreatedImpl implements PerformanceKraCreated {
  const _$PerformanceKraCreatedImpl({
    required this.name,
    required this.weightage,
  });

  @override
  final String name;
  @override
  final double weightage;

  @override
  String toString() {
    return 'PerformanceEvent.kraCreated(name: $name, weightage: $weightage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PerformanceKraCreatedImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.weightage, weightage) ||
                other.weightage == weightage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, weightage);

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PerformanceKraCreatedImplCopyWith<_$PerformanceKraCreatedImpl>
  get copyWith =>
      __$$PerformanceKraCreatedImplCopyWithImpl<_$PerformanceKraCreatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String employeeId) fetchRequested,
    required TResult Function(
      KraEntity oldKra,
      String newName,
      double newWeightage,
    )
    kraUpdated,
    required TResult Function(KraEntity kra) kraDeleted,
    required TResult Function(String name, double weightage) kraCreated,
    required TResult Function(KpiEntity oldKpi, double newWeightage) kpiUpdated,
    required TResult Function(KpiEntity kpi) kpiDeleted,
    required TResult Function(String title, double weightage, String kra)
    kpiCreated,
    required TResult Function(AppLocalizations l10n) goalSaved,
    required TResult Function(AppLocalizations l10n) goalSubmitted,
  }) {
    return kraCreated(name, weightage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String employeeId)? fetchRequested,
    TResult? Function(KraEntity oldKra, String newName, double newWeightage)?
    kraUpdated,
    TResult? Function(KraEntity kra)? kraDeleted,
    TResult? Function(String name, double weightage)? kraCreated,
    TResult? Function(KpiEntity oldKpi, double newWeightage)? kpiUpdated,
    TResult? Function(KpiEntity kpi)? kpiDeleted,
    TResult? Function(String title, double weightage, String kra)? kpiCreated,
    TResult? Function(AppLocalizations l10n)? goalSaved,
    TResult? Function(AppLocalizations l10n)? goalSubmitted,
  }) {
    return kraCreated?.call(name, weightage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String employeeId)? fetchRequested,
    TResult Function(KraEntity oldKra, String newName, double newWeightage)?
    kraUpdated,
    TResult Function(KraEntity kra)? kraDeleted,
    TResult Function(String name, double weightage)? kraCreated,
    TResult Function(KpiEntity oldKpi, double newWeightage)? kpiUpdated,
    TResult Function(KpiEntity kpi)? kpiDeleted,
    TResult Function(String title, double weightage, String kra)? kpiCreated,
    TResult Function(AppLocalizations l10n)? goalSaved,
    TResult Function(AppLocalizations l10n)? goalSubmitted,
    required TResult orElse(),
  }) {
    if (kraCreated != null) {
      return kraCreated(name, weightage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PerformanceStarted value) started,
    required TResult Function(PerformanceFetchRequested value) fetchRequested,
    required TResult Function(PerformanceKraUpdated value) kraUpdated,
    required TResult Function(PerformanceKraDeleted value) kraDeleted,
    required TResult Function(PerformanceKraCreated value) kraCreated,
    required TResult Function(PerformanceKpiUpdated value) kpiUpdated,
    required TResult Function(PerformanceKpiDeleted value) kpiDeleted,
    required TResult Function(PerformanceKpiCreated value) kpiCreated,
    required TResult Function(PerformanceGoalSaved value) goalSaved,
    required TResult Function(PerformanceGoalSubmitted value) goalSubmitted,
  }) {
    return kraCreated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PerformanceStarted value)? started,
    TResult? Function(PerformanceFetchRequested value)? fetchRequested,
    TResult? Function(PerformanceKraUpdated value)? kraUpdated,
    TResult? Function(PerformanceKraDeleted value)? kraDeleted,
    TResult? Function(PerformanceKraCreated value)? kraCreated,
    TResult? Function(PerformanceKpiUpdated value)? kpiUpdated,
    TResult? Function(PerformanceKpiDeleted value)? kpiDeleted,
    TResult? Function(PerformanceKpiCreated value)? kpiCreated,
    TResult? Function(PerformanceGoalSaved value)? goalSaved,
    TResult? Function(PerformanceGoalSubmitted value)? goalSubmitted,
  }) {
    return kraCreated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PerformanceStarted value)? started,
    TResult Function(PerformanceFetchRequested value)? fetchRequested,
    TResult Function(PerformanceKraUpdated value)? kraUpdated,
    TResult Function(PerformanceKraDeleted value)? kraDeleted,
    TResult Function(PerformanceKraCreated value)? kraCreated,
    TResult Function(PerformanceKpiUpdated value)? kpiUpdated,
    TResult Function(PerformanceKpiDeleted value)? kpiDeleted,
    TResult Function(PerformanceKpiCreated value)? kpiCreated,
    TResult Function(PerformanceGoalSaved value)? goalSaved,
    TResult Function(PerformanceGoalSubmitted value)? goalSubmitted,
    required TResult orElse(),
  }) {
    if (kraCreated != null) {
      return kraCreated(this);
    }
    return orElse();
  }
}

abstract class PerformanceKraCreated implements PerformanceEvent {
  const factory PerformanceKraCreated({
    required final String name,
    required final double weightage,
  }) = _$PerformanceKraCreatedImpl;

  String get name;
  double get weightage;

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PerformanceKraCreatedImplCopyWith<_$PerformanceKraCreatedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PerformanceKpiUpdatedImplCopyWith<$Res> {
  factory _$$PerformanceKpiUpdatedImplCopyWith(
    _$PerformanceKpiUpdatedImpl value,
    $Res Function(_$PerformanceKpiUpdatedImpl) then,
  ) = __$$PerformanceKpiUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({KpiEntity oldKpi, double newWeightage});

  $KpiEntityCopyWith<$Res> get oldKpi;
}

/// @nodoc
class __$$PerformanceKpiUpdatedImplCopyWithImpl<$Res>
    extends _$PerformanceEventCopyWithImpl<$Res, _$PerformanceKpiUpdatedImpl>
    implements _$$PerformanceKpiUpdatedImplCopyWith<$Res> {
  __$$PerformanceKpiUpdatedImplCopyWithImpl(
    _$PerformanceKpiUpdatedImpl _value,
    $Res Function(_$PerformanceKpiUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? oldKpi = null, Object? newWeightage = null}) {
    return _then(
      _$PerformanceKpiUpdatedImpl(
        oldKpi: null == oldKpi
            ? _value.oldKpi
            : oldKpi // ignore: cast_nullable_to_non_nullable
                  as KpiEntity,
        newWeightage: null == newWeightage
            ? _value.newWeightage
            : newWeightage // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $KpiEntityCopyWith<$Res> get oldKpi {
    return $KpiEntityCopyWith<$Res>(_value.oldKpi, (value) {
      return _then(_value.copyWith(oldKpi: value));
    });
  }
}

/// @nodoc

class _$PerformanceKpiUpdatedImpl implements PerformanceKpiUpdated {
  const _$PerformanceKpiUpdatedImpl({
    required this.oldKpi,
    required this.newWeightage,
  });

  @override
  final KpiEntity oldKpi;
  @override
  final double newWeightage;

  @override
  String toString() {
    return 'PerformanceEvent.kpiUpdated(oldKpi: $oldKpi, newWeightage: $newWeightage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PerformanceKpiUpdatedImpl &&
            (identical(other.oldKpi, oldKpi) || other.oldKpi == oldKpi) &&
            (identical(other.newWeightage, newWeightage) ||
                other.newWeightage == newWeightage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, oldKpi, newWeightage);

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PerformanceKpiUpdatedImplCopyWith<_$PerformanceKpiUpdatedImpl>
  get copyWith =>
      __$$PerformanceKpiUpdatedImplCopyWithImpl<_$PerformanceKpiUpdatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String employeeId) fetchRequested,
    required TResult Function(
      KraEntity oldKra,
      String newName,
      double newWeightage,
    )
    kraUpdated,
    required TResult Function(KraEntity kra) kraDeleted,
    required TResult Function(String name, double weightage) kraCreated,
    required TResult Function(KpiEntity oldKpi, double newWeightage) kpiUpdated,
    required TResult Function(KpiEntity kpi) kpiDeleted,
    required TResult Function(String title, double weightage, String kra)
    kpiCreated,
    required TResult Function(AppLocalizations l10n) goalSaved,
    required TResult Function(AppLocalizations l10n) goalSubmitted,
  }) {
    return kpiUpdated(oldKpi, newWeightage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String employeeId)? fetchRequested,
    TResult? Function(KraEntity oldKra, String newName, double newWeightage)?
    kraUpdated,
    TResult? Function(KraEntity kra)? kraDeleted,
    TResult? Function(String name, double weightage)? kraCreated,
    TResult? Function(KpiEntity oldKpi, double newWeightage)? kpiUpdated,
    TResult? Function(KpiEntity kpi)? kpiDeleted,
    TResult? Function(String title, double weightage, String kra)? kpiCreated,
    TResult? Function(AppLocalizations l10n)? goalSaved,
    TResult? Function(AppLocalizations l10n)? goalSubmitted,
  }) {
    return kpiUpdated?.call(oldKpi, newWeightage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String employeeId)? fetchRequested,
    TResult Function(KraEntity oldKra, String newName, double newWeightage)?
    kraUpdated,
    TResult Function(KraEntity kra)? kraDeleted,
    TResult Function(String name, double weightage)? kraCreated,
    TResult Function(KpiEntity oldKpi, double newWeightage)? kpiUpdated,
    TResult Function(KpiEntity kpi)? kpiDeleted,
    TResult Function(String title, double weightage, String kra)? kpiCreated,
    TResult Function(AppLocalizations l10n)? goalSaved,
    TResult Function(AppLocalizations l10n)? goalSubmitted,
    required TResult orElse(),
  }) {
    if (kpiUpdated != null) {
      return kpiUpdated(oldKpi, newWeightage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PerformanceStarted value) started,
    required TResult Function(PerformanceFetchRequested value) fetchRequested,
    required TResult Function(PerformanceKraUpdated value) kraUpdated,
    required TResult Function(PerformanceKraDeleted value) kraDeleted,
    required TResult Function(PerformanceKraCreated value) kraCreated,
    required TResult Function(PerformanceKpiUpdated value) kpiUpdated,
    required TResult Function(PerformanceKpiDeleted value) kpiDeleted,
    required TResult Function(PerformanceKpiCreated value) kpiCreated,
    required TResult Function(PerformanceGoalSaved value) goalSaved,
    required TResult Function(PerformanceGoalSubmitted value) goalSubmitted,
  }) {
    return kpiUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PerformanceStarted value)? started,
    TResult? Function(PerformanceFetchRequested value)? fetchRequested,
    TResult? Function(PerformanceKraUpdated value)? kraUpdated,
    TResult? Function(PerformanceKraDeleted value)? kraDeleted,
    TResult? Function(PerformanceKraCreated value)? kraCreated,
    TResult? Function(PerformanceKpiUpdated value)? kpiUpdated,
    TResult? Function(PerformanceKpiDeleted value)? kpiDeleted,
    TResult? Function(PerformanceKpiCreated value)? kpiCreated,
    TResult? Function(PerformanceGoalSaved value)? goalSaved,
    TResult? Function(PerformanceGoalSubmitted value)? goalSubmitted,
  }) {
    return kpiUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PerformanceStarted value)? started,
    TResult Function(PerformanceFetchRequested value)? fetchRequested,
    TResult Function(PerformanceKraUpdated value)? kraUpdated,
    TResult Function(PerformanceKraDeleted value)? kraDeleted,
    TResult Function(PerformanceKraCreated value)? kraCreated,
    TResult Function(PerformanceKpiUpdated value)? kpiUpdated,
    TResult Function(PerformanceKpiDeleted value)? kpiDeleted,
    TResult Function(PerformanceKpiCreated value)? kpiCreated,
    TResult Function(PerformanceGoalSaved value)? goalSaved,
    TResult Function(PerformanceGoalSubmitted value)? goalSubmitted,
    required TResult orElse(),
  }) {
    if (kpiUpdated != null) {
      return kpiUpdated(this);
    }
    return orElse();
  }
}

abstract class PerformanceKpiUpdated implements PerformanceEvent {
  const factory PerformanceKpiUpdated({
    required final KpiEntity oldKpi,
    required final double newWeightage,
  }) = _$PerformanceKpiUpdatedImpl;

  KpiEntity get oldKpi;
  double get newWeightage;

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PerformanceKpiUpdatedImplCopyWith<_$PerformanceKpiUpdatedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PerformanceKpiDeletedImplCopyWith<$Res> {
  factory _$$PerformanceKpiDeletedImplCopyWith(
    _$PerformanceKpiDeletedImpl value,
    $Res Function(_$PerformanceKpiDeletedImpl) then,
  ) = __$$PerformanceKpiDeletedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({KpiEntity kpi});

  $KpiEntityCopyWith<$Res> get kpi;
}

/// @nodoc
class __$$PerformanceKpiDeletedImplCopyWithImpl<$Res>
    extends _$PerformanceEventCopyWithImpl<$Res, _$PerformanceKpiDeletedImpl>
    implements _$$PerformanceKpiDeletedImplCopyWith<$Res> {
  __$$PerformanceKpiDeletedImplCopyWithImpl(
    _$PerformanceKpiDeletedImpl _value,
    $Res Function(_$PerformanceKpiDeletedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? kpi = null}) {
    return _then(
      _$PerformanceKpiDeletedImpl(
        null == kpi
            ? _value.kpi
            : kpi // ignore: cast_nullable_to_non_nullable
                  as KpiEntity,
      ),
    );
  }

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $KpiEntityCopyWith<$Res> get kpi {
    return $KpiEntityCopyWith<$Res>(_value.kpi, (value) {
      return _then(_value.copyWith(kpi: value));
    });
  }
}

/// @nodoc

class _$PerformanceKpiDeletedImpl implements PerformanceKpiDeleted {
  const _$PerformanceKpiDeletedImpl(this.kpi);

  @override
  final KpiEntity kpi;

  @override
  String toString() {
    return 'PerformanceEvent.kpiDeleted(kpi: $kpi)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PerformanceKpiDeletedImpl &&
            (identical(other.kpi, kpi) || other.kpi == kpi));
  }

  @override
  int get hashCode => Object.hash(runtimeType, kpi);

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PerformanceKpiDeletedImplCopyWith<_$PerformanceKpiDeletedImpl>
  get copyWith =>
      __$$PerformanceKpiDeletedImplCopyWithImpl<_$PerformanceKpiDeletedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String employeeId) fetchRequested,
    required TResult Function(
      KraEntity oldKra,
      String newName,
      double newWeightage,
    )
    kraUpdated,
    required TResult Function(KraEntity kra) kraDeleted,
    required TResult Function(String name, double weightage) kraCreated,
    required TResult Function(KpiEntity oldKpi, double newWeightage) kpiUpdated,
    required TResult Function(KpiEntity kpi) kpiDeleted,
    required TResult Function(String title, double weightage, String kra)
    kpiCreated,
    required TResult Function(AppLocalizations l10n) goalSaved,
    required TResult Function(AppLocalizations l10n) goalSubmitted,
  }) {
    return kpiDeleted(kpi);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String employeeId)? fetchRequested,
    TResult? Function(KraEntity oldKra, String newName, double newWeightage)?
    kraUpdated,
    TResult? Function(KraEntity kra)? kraDeleted,
    TResult? Function(String name, double weightage)? kraCreated,
    TResult? Function(KpiEntity oldKpi, double newWeightage)? kpiUpdated,
    TResult? Function(KpiEntity kpi)? kpiDeleted,
    TResult? Function(String title, double weightage, String kra)? kpiCreated,
    TResult? Function(AppLocalizations l10n)? goalSaved,
    TResult? Function(AppLocalizations l10n)? goalSubmitted,
  }) {
    return kpiDeleted?.call(kpi);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String employeeId)? fetchRequested,
    TResult Function(KraEntity oldKra, String newName, double newWeightage)?
    kraUpdated,
    TResult Function(KraEntity kra)? kraDeleted,
    TResult Function(String name, double weightage)? kraCreated,
    TResult Function(KpiEntity oldKpi, double newWeightage)? kpiUpdated,
    TResult Function(KpiEntity kpi)? kpiDeleted,
    TResult Function(String title, double weightage, String kra)? kpiCreated,
    TResult Function(AppLocalizations l10n)? goalSaved,
    TResult Function(AppLocalizations l10n)? goalSubmitted,
    required TResult orElse(),
  }) {
    if (kpiDeleted != null) {
      return kpiDeleted(kpi);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PerformanceStarted value) started,
    required TResult Function(PerformanceFetchRequested value) fetchRequested,
    required TResult Function(PerformanceKraUpdated value) kraUpdated,
    required TResult Function(PerformanceKraDeleted value) kraDeleted,
    required TResult Function(PerformanceKraCreated value) kraCreated,
    required TResult Function(PerformanceKpiUpdated value) kpiUpdated,
    required TResult Function(PerformanceKpiDeleted value) kpiDeleted,
    required TResult Function(PerformanceKpiCreated value) kpiCreated,
    required TResult Function(PerformanceGoalSaved value) goalSaved,
    required TResult Function(PerformanceGoalSubmitted value) goalSubmitted,
  }) {
    return kpiDeleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PerformanceStarted value)? started,
    TResult? Function(PerformanceFetchRequested value)? fetchRequested,
    TResult? Function(PerformanceKraUpdated value)? kraUpdated,
    TResult? Function(PerformanceKraDeleted value)? kraDeleted,
    TResult? Function(PerformanceKraCreated value)? kraCreated,
    TResult? Function(PerformanceKpiUpdated value)? kpiUpdated,
    TResult? Function(PerformanceKpiDeleted value)? kpiDeleted,
    TResult? Function(PerformanceKpiCreated value)? kpiCreated,
    TResult? Function(PerformanceGoalSaved value)? goalSaved,
    TResult? Function(PerformanceGoalSubmitted value)? goalSubmitted,
  }) {
    return kpiDeleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PerformanceStarted value)? started,
    TResult Function(PerformanceFetchRequested value)? fetchRequested,
    TResult Function(PerformanceKraUpdated value)? kraUpdated,
    TResult Function(PerformanceKraDeleted value)? kraDeleted,
    TResult Function(PerformanceKraCreated value)? kraCreated,
    TResult Function(PerformanceKpiUpdated value)? kpiUpdated,
    TResult Function(PerformanceKpiDeleted value)? kpiDeleted,
    TResult Function(PerformanceKpiCreated value)? kpiCreated,
    TResult Function(PerformanceGoalSaved value)? goalSaved,
    TResult Function(PerformanceGoalSubmitted value)? goalSubmitted,
    required TResult orElse(),
  }) {
    if (kpiDeleted != null) {
      return kpiDeleted(this);
    }
    return orElse();
  }
}

abstract class PerformanceKpiDeleted implements PerformanceEvent {
  const factory PerformanceKpiDeleted(final KpiEntity kpi) =
      _$PerformanceKpiDeletedImpl;

  KpiEntity get kpi;

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PerformanceKpiDeletedImplCopyWith<_$PerformanceKpiDeletedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PerformanceKpiCreatedImplCopyWith<$Res> {
  factory _$$PerformanceKpiCreatedImplCopyWith(
    _$PerformanceKpiCreatedImpl value,
    $Res Function(_$PerformanceKpiCreatedImpl) then,
  ) = __$$PerformanceKpiCreatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String title, double weightage, String kra});
}

/// @nodoc
class __$$PerformanceKpiCreatedImplCopyWithImpl<$Res>
    extends _$PerformanceEventCopyWithImpl<$Res, _$PerformanceKpiCreatedImpl>
    implements _$$PerformanceKpiCreatedImplCopyWith<$Res> {
  __$$PerformanceKpiCreatedImplCopyWithImpl(
    _$PerformanceKpiCreatedImpl _value,
    $Res Function(_$PerformanceKpiCreatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? weightage = null,
    Object? kra = null,
  }) {
    return _then(
      _$PerformanceKpiCreatedImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        weightage: null == weightage
            ? _value.weightage
            : weightage // ignore: cast_nullable_to_non_nullable
                  as double,
        kra: null == kra
            ? _value.kra
            : kra // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$PerformanceKpiCreatedImpl implements PerformanceKpiCreated {
  const _$PerformanceKpiCreatedImpl({
    required this.title,
    required this.weightage,
    required this.kra,
  });

  @override
  final String title;
  @override
  final double weightage;
  @override
  final String kra;

  @override
  String toString() {
    return 'PerformanceEvent.kpiCreated(title: $title, weightage: $weightage, kra: $kra)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PerformanceKpiCreatedImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.weightage, weightage) ||
                other.weightage == weightage) &&
            (identical(other.kra, kra) || other.kra == kra));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, weightage, kra);

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PerformanceKpiCreatedImplCopyWith<_$PerformanceKpiCreatedImpl>
  get copyWith =>
      __$$PerformanceKpiCreatedImplCopyWithImpl<_$PerformanceKpiCreatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String employeeId) fetchRequested,
    required TResult Function(
      KraEntity oldKra,
      String newName,
      double newWeightage,
    )
    kraUpdated,
    required TResult Function(KraEntity kra) kraDeleted,
    required TResult Function(String name, double weightage) kraCreated,
    required TResult Function(KpiEntity oldKpi, double newWeightage) kpiUpdated,
    required TResult Function(KpiEntity kpi) kpiDeleted,
    required TResult Function(String title, double weightage, String kra)
    kpiCreated,
    required TResult Function(AppLocalizations l10n) goalSaved,
    required TResult Function(AppLocalizations l10n) goalSubmitted,
  }) {
    return kpiCreated(title, weightage, kra);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String employeeId)? fetchRequested,
    TResult? Function(KraEntity oldKra, String newName, double newWeightage)?
    kraUpdated,
    TResult? Function(KraEntity kra)? kraDeleted,
    TResult? Function(String name, double weightage)? kraCreated,
    TResult? Function(KpiEntity oldKpi, double newWeightage)? kpiUpdated,
    TResult? Function(KpiEntity kpi)? kpiDeleted,
    TResult? Function(String title, double weightage, String kra)? kpiCreated,
    TResult? Function(AppLocalizations l10n)? goalSaved,
    TResult? Function(AppLocalizations l10n)? goalSubmitted,
  }) {
    return kpiCreated?.call(title, weightage, kra);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String employeeId)? fetchRequested,
    TResult Function(KraEntity oldKra, String newName, double newWeightage)?
    kraUpdated,
    TResult Function(KraEntity kra)? kraDeleted,
    TResult Function(String name, double weightage)? kraCreated,
    TResult Function(KpiEntity oldKpi, double newWeightage)? kpiUpdated,
    TResult Function(KpiEntity kpi)? kpiDeleted,
    TResult Function(String title, double weightage, String kra)? kpiCreated,
    TResult Function(AppLocalizations l10n)? goalSaved,
    TResult Function(AppLocalizations l10n)? goalSubmitted,
    required TResult orElse(),
  }) {
    if (kpiCreated != null) {
      return kpiCreated(title, weightage, kra);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PerformanceStarted value) started,
    required TResult Function(PerformanceFetchRequested value) fetchRequested,
    required TResult Function(PerformanceKraUpdated value) kraUpdated,
    required TResult Function(PerformanceKraDeleted value) kraDeleted,
    required TResult Function(PerformanceKraCreated value) kraCreated,
    required TResult Function(PerformanceKpiUpdated value) kpiUpdated,
    required TResult Function(PerformanceKpiDeleted value) kpiDeleted,
    required TResult Function(PerformanceKpiCreated value) kpiCreated,
    required TResult Function(PerformanceGoalSaved value) goalSaved,
    required TResult Function(PerformanceGoalSubmitted value) goalSubmitted,
  }) {
    return kpiCreated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PerformanceStarted value)? started,
    TResult? Function(PerformanceFetchRequested value)? fetchRequested,
    TResult? Function(PerformanceKraUpdated value)? kraUpdated,
    TResult? Function(PerformanceKraDeleted value)? kraDeleted,
    TResult? Function(PerformanceKraCreated value)? kraCreated,
    TResult? Function(PerformanceKpiUpdated value)? kpiUpdated,
    TResult? Function(PerformanceKpiDeleted value)? kpiDeleted,
    TResult? Function(PerformanceKpiCreated value)? kpiCreated,
    TResult? Function(PerformanceGoalSaved value)? goalSaved,
    TResult? Function(PerformanceGoalSubmitted value)? goalSubmitted,
  }) {
    return kpiCreated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PerformanceStarted value)? started,
    TResult Function(PerformanceFetchRequested value)? fetchRequested,
    TResult Function(PerformanceKraUpdated value)? kraUpdated,
    TResult Function(PerformanceKraDeleted value)? kraDeleted,
    TResult Function(PerformanceKraCreated value)? kraCreated,
    TResult Function(PerformanceKpiUpdated value)? kpiUpdated,
    TResult Function(PerformanceKpiDeleted value)? kpiDeleted,
    TResult Function(PerformanceKpiCreated value)? kpiCreated,
    TResult Function(PerformanceGoalSaved value)? goalSaved,
    TResult Function(PerformanceGoalSubmitted value)? goalSubmitted,
    required TResult orElse(),
  }) {
    if (kpiCreated != null) {
      return kpiCreated(this);
    }
    return orElse();
  }
}

abstract class PerformanceKpiCreated implements PerformanceEvent {
  const factory PerformanceKpiCreated({
    required final String title,
    required final double weightage,
    required final String kra,
  }) = _$PerformanceKpiCreatedImpl;

  String get title;
  double get weightage;
  String get kra;

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PerformanceKpiCreatedImplCopyWith<_$PerformanceKpiCreatedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PerformanceGoalSavedImplCopyWith<$Res> {
  factory _$$PerformanceGoalSavedImplCopyWith(
    _$PerformanceGoalSavedImpl value,
    $Res Function(_$PerformanceGoalSavedImpl) then,
  ) = __$$PerformanceGoalSavedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppLocalizations l10n});
}

/// @nodoc
class __$$PerformanceGoalSavedImplCopyWithImpl<$Res>
    extends _$PerformanceEventCopyWithImpl<$Res, _$PerformanceGoalSavedImpl>
    implements _$$PerformanceGoalSavedImplCopyWith<$Res> {
  __$$PerformanceGoalSavedImplCopyWithImpl(
    _$PerformanceGoalSavedImpl _value,
    $Res Function(_$PerformanceGoalSavedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? l10n = null}) {
    return _then(
      _$PerformanceGoalSavedImpl(
        l10n: null == l10n
            ? _value.l10n
            : l10n // ignore: cast_nullable_to_non_nullable
                  as AppLocalizations,
      ),
    );
  }
}

/// @nodoc

class _$PerformanceGoalSavedImpl implements PerformanceGoalSaved {
  const _$PerformanceGoalSavedImpl({required this.l10n});

  @override
  final AppLocalizations l10n;

  @override
  String toString() {
    return 'PerformanceEvent.goalSaved(l10n: $l10n)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PerformanceGoalSavedImpl &&
            (identical(other.l10n, l10n) || other.l10n == l10n));
  }

  @override
  int get hashCode => Object.hash(runtimeType, l10n);

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PerformanceGoalSavedImplCopyWith<_$PerformanceGoalSavedImpl>
  get copyWith =>
      __$$PerformanceGoalSavedImplCopyWithImpl<_$PerformanceGoalSavedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String employeeId) fetchRequested,
    required TResult Function(
      KraEntity oldKra,
      String newName,
      double newWeightage,
    )
    kraUpdated,
    required TResult Function(KraEntity kra) kraDeleted,
    required TResult Function(String name, double weightage) kraCreated,
    required TResult Function(KpiEntity oldKpi, double newWeightage) kpiUpdated,
    required TResult Function(KpiEntity kpi) kpiDeleted,
    required TResult Function(String title, double weightage, String kra)
    kpiCreated,
    required TResult Function(AppLocalizations l10n) goalSaved,
    required TResult Function(AppLocalizations l10n) goalSubmitted,
  }) {
    return goalSaved(l10n);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String employeeId)? fetchRequested,
    TResult? Function(KraEntity oldKra, String newName, double newWeightage)?
    kraUpdated,
    TResult? Function(KraEntity kra)? kraDeleted,
    TResult? Function(String name, double weightage)? kraCreated,
    TResult? Function(KpiEntity oldKpi, double newWeightage)? kpiUpdated,
    TResult? Function(KpiEntity kpi)? kpiDeleted,
    TResult? Function(String title, double weightage, String kra)? kpiCreated,
    TResult? Function(AppLocalizations l10n)? goalSaved,
    TResult? Function(AppLocalizations l10n)? goalSubmitted,
  }) {
    return goalSaved?.call(l10n);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String employeeId)? fetchRequested,
    TResult Function(KraEntity oldKra, String newName, double newWeightage)?
    kraUpdated,
    TResult Function(KraEntity kra)? kraDeleted,
    TResult Function(String name, double weightage)? kraCreated,
    TResult Function(KpiEntity oldKpi, double newWeightage)? kpiUpdated,
    TResult Function(KpiEntity kpi)? kpiDeleted,
    TResult Function(String title, double weightage, String kra)? kpiCreated,
    TResult Function(AppLocalizations l10n)? goalSaved,
    TResult Function(AppLocalizations l10n)? goalSubmitted,
    required TResult orElse(),
  }) {
    if (goalSaved != null) {
      return goalSaved(l10n);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PerformanceStarted value) started,
    required TResult Function(PerformanceFetchRequested value) fetchRequested,
    required TResult Function(PerformanceKraUpdated value) kraUpdated,
    required TResult Function(PerformanceKraDeleted value) kraDeleted,
    required TResult Function(PerformanceKraCreated value) kraCreated,
    required TResult Function(PerformanceKpiUpdated value) kpiUpdated,
    required TResult Function(PerformanceKpiDeleted value) kpiDeleted,
    required TResult Function(PerformanceKpiCreated value) kpiCreated,
    required TResult Function(PerformanceGoalSaved value) goalSaved,
    required TResult Function(PerformanceGoalSubmitted value) goalSubmitted,
  }) {
    return goalSaved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PerformanceStarted value)? started,
    TResult? Function(PerformanceFetchRequested value)? fetchRequested,
    TResult? Function(PerformanceKraUpdated value)? kraUpdated,
    TResult? Function(PerformanceKraDeleted value)? kraDeleted,
    TResult? Function(PerformanceKraCreated value)? kraCreated,
    TResult? Function(PerformanceKpiUpdated value)? kpiUpdated,
    TResult? Function(PerformanceKpiDeleted value)? kpiDeleted,
    TResult? Function(PerformanceKpiCreated value)? kpiCreated,
    TResult? Function(PerformanceGoalSaved value)? goalSaved,
    TResult? Function(PerformanceGoalSubmitted value)? goalSubmitted,
  }) {
    return goalSaved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PerformanceStarted value)? started,
    TResult Function(PerformanceFetchRequested value)? fetchRequested,
    TResult Function(PerformanceKraUpdated value)? kraUpdated,
    TResult Function(PerformanceKraDeleted value)? kraDeleted,
    TResult Function(PerformanceKraCreated value)? kraCreated,
    TResult Function(PerformanceKpiUpdated value)? kpiUpdated,
    TResult Function(PerformanceKpiDeleted value)? kpiDeleted,
    TResult Function(PerformanceKpiCreated value)? kpiCreated,
    TResult Function(PerformanceGoalSaved value)? goalSaved,
    TResult Function(PerformanceGoalSubmitted value)? goalSubmitted,
    required TResult orElse(),
  }) {
    if (goalSaved != null) {
      return goalSaved(this);
    }
    return orElse();
  }
}

abstract class PerformanceGoalSaved implements PerformanceEvent {
  const factory PerformanceGoalSaved({required final AppLocalizations l10n}) =
      _$PerformanceGoalSavedImpl;

  AppLocalizations get l10n;

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PerformanceGoalSavedImplCopyWith<_$PerformanceGoalSavedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PerformanceGoalSubmittedImplCopyWith<$Res> {
  factory _$$PerformanceGoalSubmittedImplCopyWith(
    _$PerformanceGoalSubmittedImpl value,
    $Res Function(_$PerformanceGoalSubmittedImpl) then,
  ) = __$$PerformanceGoalSubmittedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppLocalizations l10n});
}

/// @nodoc
class __$$PerformanceGoalSubmittedImplCopyWithImpl<$Res>
    extends _$PerformanceEventCopyWithImpl<$Res, _$PerformanceGoalSubmittedImpl>
    implements _$$PerformanceGoalSubmittedImplCopyWith<$Res> {
  __$$PerformanceGoalSubmittedImplCopyWithImpl(
    _$PerformanceGoalSubmittedImpl _value,
    $Res Function(_$PerformanceGoalSubmittedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? l10n = null}) {
    return _then(
      _$PerformanceGoalSubmittedImpl(
        l10n: null == l10n
            ? _value.l10n
            : l10n // ignore: cast_nullable_to_non_nullable
                  as AppLocalizations,
      ),
    );
  }
}

/// @nodoc

class _$PerformanceGoalSubmittedImpl implements PerformanceGoalSubmitted {
  const _$PerformanceGoalSubmittedImpl({required this.l10n});

  @override
  final AppLocalizations l10n;

  @override
  String toString() {
    return 'PerformanceEvent.goalSubmitted(l10n: $l10n)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PerformanceGoalSubmittedImpl &&
            (identical(other.l10n, l10n) || other.l10n == l10n));
  }

  @override
  int get hashCode => Object.hash(runtimeType, l10n);

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PerformanceGoalSubmittedImplCopyWith<_$PerformanceGoalSubmittedImpl>
  get copyWith =>
      __$$PerformanceGoalSubmittedImplCopyWithImpl<
        _$PerformanceGoalSubmittedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String employeeId) fetchRequested,
    required TResult Function(
      KraEntity oldKra,
      String newName,
      double newWeightage,
    )
    kraUpdated,
    required TResult Function(KraEntity kra) kraDeleted,
    required TResult Function(String name, double weightage) kraCreated,
    required TResult Function(KpiEntity oldKpi, double newWeightage) kpiUpdated,
    required TResult Function(KpiEntity kpi) kpiDeleted,
    required TResult Function(String title, double weightage, String kra)
    kpiCreated,
    required TResult Function(AppLocalizations l10n) goalSaved,
    required TResult Function(AppLocalizations l10n) goalSubmitted,
  }) {
    return goalSubmitted(l10n);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String employeeId)? fetchRequested,
    TResult? Function(KraEntity oldKra, String newName, double newWeightage)?
    kraUpdated,
    TResult? Function(KraEntity kra)? kraDeleted,
    TResult? Function(String name, double weightage)? kraCreated,
    TResult? Function(KpiEntity oldKpi, double newWeightage)? kpiUpdated,
    TResult? Function(KpiEntity kpi)? kpiDeleted,
    TResult? Function(String title, double weightage, String kra)? kpiCreated,
    TResult? Function(AppLocalizations l10n)? goalSaved,
    TResult? Function(AppLocalizations l10n)? goalSubmitted,
  }) {
    return goalSubmitted?.call(l10n);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String employeeId)? fetchRequested,
    TResult Function(KraEntity oldKra, String newName, double newWeightage)?
    kraUpdated,
    TResult Function(KraEntity kra)? kraDeleted,
    TResult Function(String name, double weightage)? kraCreated,
    TResult Function(KpiEntity oldKpi, double newWeightage)? kpiUpdated,
    TResult Function(KpiEntity kpi)? kpiDeleted,
    TResult Function(String title, double weightage, String kra)? kpiCreated,
    TResult Function(AppLocalizations l10n)? goalSaved,
    TResult Function(AppLocalizations l10n)? goalSubmitted,
    required TResult orElse(),
  }) {
    if (goalSubmitted != null) {
      return goalSubmitted(l10n);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PerformanceStarted value) started,
    required TResult Function(PerformanceFetchRequested value) fetchRequested,
    required TResult Function(PerformanceKraUpdated value) kraUpdated,
    required TResult Function(PerformanceKraDeleted value) kraDeleted,
    required TResult Function(PerformanceKraCreated value) kraCreated,
    required TResult Function(PerformanceKpiUpdated value) kpiUpdated,
    required TResult Function(PerformanceKpiDeleted value) kpiDeleted,
    required TResult Function(PerformanceKpiCreated value) kpiCreated,
    required TResult Function(PerformanceGoalSaved value) goalSaved,
    required TResult Function(PerformanceGoalSubmitted value) goalSubmitted,
  }) {
    return goalSubmitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PerformanceStarted value)? started,
    TResult? Function(PerformanceFetchRequested value)? fetchRequested,
    TResult? Function(PerformanceKraUpdated value)? kraUpdated,
    TResult? Function(PerformanceKraDeleted value)? kraDeleted,
    TResult? Function(PerformanceKraCreated value)? kraCreated,
    TResult? Function(PerformanceKpiUpdated value)? kpiUpdated,
    TResult? Function(PerformanceKpiDeleted value)? kpiDeleted,
    TResult? Function(PerformanceKpiCreated value)? kpiCreated,
    TResult? Function(PerformanceGoalSaved value)? goalSaved,
    TResult? Function(PerformanceGoalSubmitted value)? goalSubmitted,
  }) {
    return goalSubmitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PerformanceStarted value)? started,
    TResult Function(PerformanceFetchRequested value)? fetchRequested,
    TResult Function(PerformanceKraUpdated value)? kraUpdated,
    TResult Function(PerformanceKraDeleted value)? kraDeleted,
    TResult Function(PerformanceKraCreated value)? kraCreated,
    TResult Function(PerformanceKpiUpdated value)? kpiUpdated,
    TResult Function(PerformanceKpiDeleted value)? kpiDeleted,
    TResult Function(PerformanceKpiCreated value)? kpiCreated,
    TResult Function(PerformanceGoalSaved value)? goalSaved,
    TResult Function(PerformanceGoalSubmitted value)? goalSubmitted,
    required TResult orElse(),
  }) {
    if (goalSubmitted != null) {
      return goalSubmitted(this);
    }
    return orElse();
  }
}

abstract class PerformanceGoalSubmitted implements PerformanceEvent {
  const factory PerformanceGoalSubmitted({
    required final AppLocalizations l10n,
  }) = _$PerformanceGoalSubmittedImpl;

  AppLocalizations get l10n;

  /// Create a copy of PerformanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PerformanceGoalSubmittedImplCopyWith<_$PerformanceGoalSubmittedImpl>
  get copyWith => throw _privateConstructorUsedError;
}
