import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/error/failures.dart';
import 'package:dhira_hrms/core/services/local_storage_service.dart';
import 'package:dhira_hrms/features/performance/domain/entities/self_assessment_entity.dart';
import 'package:dhira_hrms/features/performance/domain/usecases/get_active_self_assessment_id_usecase.dart';
import 'package:dhira_hrms/features/performance/domain/usecases/get_self_assessment_details_usecase.dart';
import 'package:dhira_hrms/features/performance/domain/usecases/update_evaluation_usecase.dart';
import 'package:dhira_hrms/features/performance/domain/usecases/update_self_assessment_usecase.dart';
import 'package:dhira_hrms/features/performance/domain/entities/sa_tracking_entity.dart';
import 'package:dhira_hrms/features/performance/domain/usecases/get_sa_tracking_usecase.dart';
import 'package:dhira_hrms/features/performance/domain/usecases/update_sa_tracking_usecase.dart';
import 'package:dhira_hrms/features/performance/domain/usecases/upload_sa_attachment_usecase.dart';
import 'package:dhira_hrms/features/performance/domain/usecases/delete_sa_attachment_usecase.dart';
import 'package:dhira_hrms/features/performance/presentation/cubit/self_assessment/self_assessment_payload_mapper.dart';
import 'package:dhira_hrms/features/performance/presentation/cubit/self_assessment/self_assessment_rating_policy.dart';
import 'package:dhira_hrms/features/performance/presentation/utils/performance_error_utils.dart';
import 'package:dhira_hrms/core/services/image_compress_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';

part 'self_assessment_state.dart';
part 'self_assessment_cubit.freezed.dart';

class SelfAssessmentCubit extends Cubit<SelfAssessmentState> {
  final GetActiveSelfAssessmentIdUseCase getActiveSelfAssessmentIdUseCase;
  final GetSelfAssessmentDetailsUseCase getSelfAssessmentDetailsUseCase;
  final UpdateEvaluationUseCase updateEvaluationUseCase;
  final UpdateSelfAssessmentUseCase updateSelfAssessmentUseCase;
  final GetSaTrackingUseCase getSaTrackingUseCase;
  final UpdateSaTrackingUseCase updateSaTrackingUseCase;
  final UploadSaAttachmentUseCase uploadSaAttachmentUseCase;
  final DeleteSaAttachmentUseCase deleteSaAttachmentUseCase;
  final ImageCompressService imageCompressService;
  final LocalStorageService localStorageService;

  SelfAssessmentCubit(
    this.getActiveSelfAssessmentIdUseCase,
    this.getSelfAssessmentDetailsUseCase,
    this.updateEvaluationUseCase,
    this.updateSelfAssessmentUseCase,
    this.getSaTrackingUseCase,
    this.updateSaTrackingUseCase,
    this.uploadSaAttachmentUseCase,
    this.deleteSaAttachmentUseCase,
    this.imageCompressService,
    this.localStorageService,
  ) : super(const SelfAssessmentState(status: SelfAssessmentStatus.initial));

  Future<void> initSelfAssessment({
    String selfAssessmentId = AppConstants.emptyString,
    String evaluationId = AppConstants.emptyString,
  }) async {
    emit(const SelfAssessmentState(status: SelfAssessmentStatus.loading));

    if (selfAssessmentId.isNotEmpty || evaluationId.isNotEmpty) {
      await fetchSelfAssessment(selfAssessmentId, evaluationId);
      return;
    }

    final employeeId = localStorageService.getEmpId() ?? '';
    if (employeeId.isEmpty) {
      emit(
        state.copyWith(
          status: SelfAssessmentStatus.failure,
          errorMessage: AppConstants.employeeIdNotFound,
        ),
      );
      return;
    }

    final idResult = await getActiveSelfAssessmentIdUseCase(employeeId);

    await idResult.fold(
      (failure) async {
        if (isClosed) return;
        emit(
          state.copyWith(
          status: SelfAssessmentStatus.failure,
          errorMessage: PerformanceErrorUtils.pageErrorMessage(failure),
        ),
      );
      },
      (saId) async {
        if (saId == null) {
          emit(
            state.copyWith(
              status: SelfAssessmentStatus.failure,
              errorMessage: PerformanceApiKeys.noData,
            ),
          );
          return;
        }
        await fetchSelfAssessment(saId, AppConstants.emptyString);
      },
    );
  }

  Future<void> fetchSelfAssessment(
    String selfAssessmentId,
    String evaluationId,
  ) async {
    if (state.details == null) {
      emit(state.copyWith(status: SelfAssessmentStatus.loading));
    }

    final isEvaluation =
        evaluationId.isNotEmpty || selfAssessmentId.startsWith('EVAL-');

    final results = await Future.wait([
      getSelfAssessmentDetailsUseCase(selfAssessmentId, evaluationId),
      isEvaluation
          ? Future.value(const Right<Failure, SaTrackingEntity>(
              SaTrackingEntity(name: '', sessions: [], questions: []),
            ))
          : getSaTrackingUseCase(selfAssessmentId),
    ]);

    final assessmentResult =
        results[0] as Either<Failure, SelfAssessmentEntity>;
    final trackingResult = results[1] as Either<Failure, SaTrackingEntity>;

    assessmentResult.fold(
      (failure) {
        if (isClosed) return;
        emit(
          state.copyWith(
            status: SelfAssessmentStatus.failure,
            errorMessage: PerformanceErrorUtils.pageErrorMessage(failure),
          ),
        );
      },
      (details) {
        if (isClosed) return;
        final tracking = trackingResult.fold((_) => null, (t) => t);
        final grouped = _groupGoals(details.goalReviews);
        final kras = grouped.keys.toList();
        final selectedKra =
            state.selectedKra ?? (kras.isNotEmpty ? kras.first : null);
        final kraWeightages = getKraWeightages(grouped);

        emit(
          state.copyWith(
            status: SelfAssessmentStatus.success,
            details: details,
            selectedKra: selectedKra,
            groupedGoals: grouped,
            kras: kras,
            tracking: tracking,
            kraWeightages: kraWeightages,
          ),
        );
      },
    );
  }

  Map<String, List<GoalReviewEntity>> _groupGoals(
    List<GoalReviewEntity> reviews,
  ) {
    final Map<String, List<GoalReviewEntity>> grouped = {};
    for (var goal in reviews) {
      grouped.putIfAbsent(goal.kras, () => []).add(goal);
    }
    return grouped;
  }

  void selectKra(String kra) {
    if (state.details == null) return;
    emit(state.copyWith(selectedKra: kra));
  }

  Future<void> saveSelfAssessment() async {
    await saveManagerFeedback(isSubmit: false);
  }

  Future<void> submitSelfAssessment() async {
    await saveManagerFeedback(isSubmit: true);
  }

  Future<void> saveManagerFeedback({bool isSubmit = false}) async {
    final details = state.details;
    if (details == null) return;

    final isEvaluation = details.name.startsWith('EVAL-');

    if (!isEvaluation) {
      for (var goal in details.goalReviews) {
        final hasRating = goal.selfRating.isNotEmpty;
        final hasComment = goal.selfComment.isNotEmpty;
        if ((hasRating && !hasComment) || (!hasRating && hasComment)) {
          emit(
            state.copyWith(
              actionStatus: SelfAssessmentActionStatus.failure,
              actionErrorMessage:
                  PerformanceApiKeys.incompleteSelfAssessmentAnswer,
            ),
          );
          return;
        }
      }
    }

    final payload = SelfAssessmentPayloadMapper.updatePayload(
      details: details,
      isSubmit: isSubmit,
      isEvaluation: isEvaluation,
    );

    if (isSubmit) {
      emit(state.copyWith(actionStatus: SelfAssessmentActionStatus.submitting));
    } else {
      emit(state.copyWith(actionStatus: SelfAssessmentActionStatus.saving));
    }

    final result = isEvaluation
        ? await updateEvaluationUseCase(details.name, payload)
        : await updateSelfAssessmentUseCase(details.name, payload);

    await result.fold(
      (failure) async {
        if (isClosed) return;
        emit(
          state.copyWith(
            actionStatus: SelfAssessmentActionStatus.failure,
            actionErrorMessage: failure.message,
          ),
        );
      },
      (_) async {
        if (isClosed) return;

        SaTrackingEntity? updatedTracking = state.tracking;

        if (!isEvaluation) {
          // Push tracking updates to the backend
          if (state.tracking != null && state.tracking!.sessions.isNotEmpty) {
            final questionsPayload = state.tracking!.questions.map((q) {
              final map = <String, dynamic>{
                'key': q.key,
                'question': q.question,
                'rating': q.rating,
                'session': q.session,
                'last_modified': q.lastModified,
              };
              if (q.name.isNotEmpty) {
                map['name'] = q.name;
              }
              return map;
            }).toList();

            if (questionsPayload.isNotEmpty) {
              final trackingPayload = {'questions': questionsPayload};
              await updateSaTrackingUseCase(
                details.name,
                trackingPayload,
              ).catchError((_) => const Right<Failure, void>(null));
            }
          }

          // Fetch updated tracking data after a successful save
          final trackingResult = await getSaTrackingUseCase(details.name);
          updatedTracking = trackingResult.fold(
            (_) => state.tracking,
            (t) => t,
          );
        }

        if (isClosed) return;

        if (isSubmit) {
          emit(
            state.copyWith(
              actionStatus: SelfAssessmentActionStatus.submitSuccess,
              tracking: updatedTracking,
            ),
          );
        } else {
          emit(
            state.copyWith(
              actionStatus: SelfAssessmentActionStatus.saveSuccess,
              tracking: updatedTracking,
            ),
          );
        }
      },
    );
  }

  void updateLocalGoalFeedback(GoalReviewEntity updatedGoal) {
    if (state.details == null) return;
    _emitUpdatedLocalGoal(state.details!, updatedGoal, state.selectedKra);
  }

  void _emitUpdatedLocalGoal(
    SelfAssessmentEntity details,
    GoalReviewEntity updatedGoal,
    String? selectedKra,
  ) {
    final updatedGoalReviews = details.goalReviews.map((g) {
      return g.name == updatedGoal.name ? updatedGoal : g;
    }).toList();

    final updatedDetails = details.copyWith(goalReviews: updatedGoalReviews);
    final grouped = _groupGoals(updatedGoalReviews);
    final kras = grouped.keys.toList();

    // Update tracking locally
    SaTrackingEntity? updatedTracking = state.tracking;
    if (updatedTracking != null && updatedTracking.sessions.isNotEmpty) {
      final currentSession = updatedTracking.sessions.last.session;
      final now = DateTimeUtils.formatDate(
        DateTime.now(),
        pattern: AppConstants.apiDateTimeFormat,
      );

      final questions = List<SaQuestionEntity>.from(updatedTracking.questions);
      final qIndex = questions.indexWhere(
        (q) =>
            (q.key == updatedGoal.name || q.question == updatedGoal.goal) &&
            q.session == currentSession,
      );

      if (qIndex >= 0) {
        questions[qIndex] = questions[qIndex].copyWith(
          rating: updatedGoal.selfRating,
          lastModified: now,
        );
      } else {
        questions.add(
          SaQuestionEntity(
            name: '',
            key: updatedGoal.name,
            session: currentSession,
            question: updatedGoal.goal,
            rating: updatedGoal.selfRating,
            lastModified: now,
          ),
        );
      }

      updatedTracking = updatedTracking.copyWith(questions: questions);
    }

    emit(
      state.copyWith(
        status: SelfAssessmentStatus.success,
        details: updatedDetails,
        selectedKra: selectedKra,
        groupedGoals: grouped,
        kras: kras,
        kraWeightages: getKraWeightages(grouped),
        tracking: updatedTracking,
      ),
    );
  }

  Map<String, double> getKraWeightages(
    Map<String, List<GoalReviewEntity>> groupedGoals,
  ) {
    final kraWeightages = <String, double>{};
    for (var entry in groupedGoals.entries) {
      kraWeightages[entry.key] = entry.value.fold(
        0.0,
        (sum, goal) => sum + goal.weightage,
      );
    }
    return kraWeightages;
  }

  void updateGoal(
    GoalReviewEntity goal, {
    String? selfRating,
    double? progress,
    String? selfComment,
  }) {
    String finalRating = selfRating ?? goal.selfRating;
    double finalProgress = progress ?? goal.progress;

    final int ratingInt =
        SelfAssessmentRatingPolicy.parseRating(finalRating).toInt();
    final values = SelfAssessmentRatingPolicy.progressValues(ratingInt);
    final double minVal = values.first;
    final double maxVal = values.last;

    if (selfRating != null) {
      if (finalProgress < minVal || finalProgress > maxVal) {
        finalProgress = minVal;
      }
    }

    finalProgress = finalProgress.clamp(minVal, maxVal);

    updateLocalGoalFeedback(
      goal.copyWith(
        selfRating: finalRating,
        progress: finalProgress,
        selfComment: selfComment ?? goal.selfComment,
      ),
    );
  }

  Future<String?> uploadAttachment({
    required String filePath,
    required String fileName,
  }) async {
    final details = state.details;
    if (details == null) {
      emit(
        state.copyWith(
          actionStatus: SelfAssessmentActionStatus.failure,
          actionErrorMessage: PerformanceApiKeys.assessmentDetailsNotLoaded,
        ),
      );
      return null;
    }

    emit(
      state.copyWith(
        isAttachmentUploading: true,
        actionStatus: SelfAssessmentActionStatus.none,
        actionErrorMessage: AppConstants.emptyString,
      ),
    );

    try {
      String finalPath = filePath;
      final extension = filePath.split('.').last.toLowerCase();
      final isImage = [
        'jpg',
        'jpeg',
        'png',
        'webp',
        'heic',
        'heif',
      ].contains(extension);

      if (isImage) {
        final compressedFile = await imageCompressService.compressImage(
          filePath,
        );
        if (compressedFile != null) {
          finalPath = compressedFile.path;
        }
      }

      final result = await uploadSaAttachmentUseCase(
        filePath: finalPath,
        fileName: fileName,
        selfAssessmentId: details.name,
      );

      return await result.fold(
        (failure) {
          emit(
            state.copyWith(
              actionStatus: SelfAssessmentActionStatus.failure,
              actionErrorMessage: failure.message,
            ),
          );
          return null;
        },
        (fileUrl) async {
          await fetchSelfAssessment(details.name, '');
          emit(
            state.copyWith(
              actionStatus: SelfAssessmentActionStatus.attachmentUploadSuccess,
            ),
          );
          return fileUrl;
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          actionStatus: SelfAssessmentActionStatus.failure,
          actionErrorMessage: e.toString(),
        ),
      );
      return null;
    } finally {
      emit(state.copyWith(isAttachmentUploading: false));
    }
  }

  Future<bool> deleteAttachment(String fileId) async {
    final details = state.details;
    if (details == null) {
      emit(
        state.copyWith(
          actionStatus: SelfAssessmentActionStatus.failure,
          actionErrorMessage: PerformanceApiKeys.assessmentDetailsNotLoaded,
        ),
      );
      return false;
    }

    emit(
      state.copyWith(
        deletingAttachmentId: fileId,
        actionStatus: SelfAssessmentActionStatus.none,
        actionErrorMessage: AppConstants.emptyString,
      ),
    );

    try {
      final result = await deleteSaAttachmentUseCase(fileId);

      return await result.fold(
        (failure) {
          emit(
            state.copyWith(
              actionStatus: SelfAssessmentActionStatus.failure,
              actionErrorMessage: failure.message,
            ),
          );
          return false;
        },
        (_) async {
          await fetchSelfAssessment(details.name, '');
          emit(
            state.copyWith(
              actionStatus: SelfAssessmentActionStatus.attachmentDeleteSuccess,
            ),
          );
          return true;
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          actionStatus: SelfAssessmentActionStatus.failure,
          actionErrorMessage: e.toString(),
        ),
      );
      return false;
    } finally {
      emit(state.copyWith(deletingAttachmentId: AppConstants.emptyString));
    }
  }
}
