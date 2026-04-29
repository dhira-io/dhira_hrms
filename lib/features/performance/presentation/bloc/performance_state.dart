import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/performance_entity.dart';

part 'performance_state.freezed.dart';

@freezed
abstract class PerformanceState with _$PerformanceState {
  const factory PerformanceState.initial({
    PerformanceEntity? summary,
    @Default(false) bool isLoading,
    @Default(false) bool isActionLoading,
    String? errorMessage,
  }) = PerformanceInitial;

  const factory PerformanceState.loading({
    PerformanceEntity? summary,
    @Default(true) bool isLoading,
    @Default(false) bool isActionLoading,
    String? errorMessage,
  }) = PerformanceLoading;

  const factory PerformanceState.loaded({
    required PerformanceEntity summary,
    @Default(false) bool isLoading,
    @Default(false) bool isActionLoading,
    String? errorMessage,
  }) = PerformanceLoaded;

  const factory PerformanceState.error({
    PerformanceEntity? summary,
    @Default(false) bool isLoading,
    @Default(false) bool isActionLoading,
    required String errorMessage,
  }) = PerformanceError;
}
