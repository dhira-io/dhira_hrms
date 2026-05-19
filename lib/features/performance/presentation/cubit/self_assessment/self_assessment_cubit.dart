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
import 'package:dhira_hrms/core/services/image_compress_service.dart';
import 'package:dhira_hrms/core/utils/toast_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dhira_hrms/core/utils/file_validation_utils.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';

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

  Future<void> initSelfAssessment() async {
    emit(state.copyWith(status: SelfAssessmentStatus.loading));

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
            errorMessage: failure.message,
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

    final results = await Future.wait([
      getSelfAssessmentDetailsUseCase(selfAssessmentId, evaluationId),
      getSaTrackingUseCase(selfAssessmentId),
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
            errorMessage: failure.message,
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



    // Validation: If rating or comment is provided, both must be provided
    for (var goal in details.goalReviews) {
      final hasRating = goal.selfRating.isNotEmpty;
      final hasComment = goal.selfComment.isNotEmpty;
      if ((hasRating && !hasComment) || (!hasRating && hasComment)) {
        emit(
          state.copyWith(
            status: SelfAssessmentStatus.failure,
            errorMessage:
                "Incomplete answer found: Please provide both a rating and a comment for all answered questions.",
          ),
        );
        // Reset to success state so the user can fix the error
        emit(state.copyWith(status: SelfAssessmentStatus.success));
        return;
      }
    }

    // Map Goals
    final goalReviews = details.goalReviews.asMap().entries.map((entry) {
      final index = entry.key;
      final goal = entry.value;
      String formattedRating = goal.selfRating;
      if (formattedRating.length == 1) {
        switch (formattedRating) {
          case '1':
            formattedRating = '1 - Needs Improvement';
            break;
          case '2':
            formattedRating = '2 - Below Expectations';
            break;
          case '3':
            formattedRating = '3 - Meets Expectations';
            break;
          case '4':
            formattedRating = '4 - Exceeds Expectations';
            break;
        }
      }

      return {
        PerformanceApiKeys.name: goal.name,
        PerformanceApiKeys.goal: goal.goal,
        'idx': index + 1,
        'kras': goal.kras,
        PerformanceApiKeys.weightage: goal.weightage,
        PerformanceApiKeys.target: goal.target,
        'progress': goal.progress,
        PerformanceApiKeys.selfRating: formattedRating,
        PerformanceApiKeys.selfComment: goal.selfComment,
        PerformanceApiKeys.parent: details.name,
        PerformanceApiKeys.parentField: PerformanceApiKeys.goalReview,
        PerformanceApiKeys.parentType: PerformanceApiKeys.pmsSelfAssessment,
        PerformanceApiKeys.docType: PerformanceApiKeys.goalReviewDocType,
        PerformanceApiKeys.docStatus: isSubmit ? 1 : 0,
      };
    }).toList();

    final competencyReviews = details.competencyReviews.asMap().entries.map((
      entry,
    ) {
      final index = entry.key;
      final comp = entry.value;
      return {
        PerformanceApiKeys.name: comp.name,
        'idx': index + 1,
        'competency': comp.competency,
        PerformanceApiKeys.parent: details.name,
        PerformanceApiKeys.parentField: PerformanceApiKeys.competencyReview,
        PerformanceApiKeys.parentType: PerformanceApiKeys.pmsSelfAssessment,
        PerformanceApiKeys.docType: PerformanceApiKeys.competencyReviewDocType,
        PerformanceApiKeys.docStatus: isSubmit ? 1 : 0,
      };
    }).toList();

    // Map Timeline
    final timeline = details.timeline.asMap().entries.map((entry) {
      final index = entry.key;
      final stage = entry.value;
      return {
        PerformanceApiKeys.name: stage.name,
        'idx': index + 1,
        'stage_name': stage.stageName,
        'date': stage.date.toIso8601String().split('T').first,
        'stauts': stage.status,
        PerformanceApiKeys.parent: details.name,
        PerformanceApiKeys.parentField: 'timeline',
        PerformanceApiKeys.parentType: PerformanceApiKeys.pmsSelfAssessment,
        PerformanceApiKeys.docType: 'PMS Cycle Timeline',
        PerformanceApiKeys.docStatus: isSubmit ? 1 : 0,
      };
    }).toList();

    final payload = {
      "data": {
        PerformanceApiKeys.name: details.name,
        'employee': details.employee,
        'employee_name': details.employeeName,
        'department': details.department,
        'cycle': details.cycle,
        'goal': details.goal,
        'submission_date': details.submissionDate
            .toIso8601String()
            .split('T')
            .first,
        'doctype': 'PMS Self Assesment',
        PerformanceApiKeys.docStatus: isSubmit ? 1 : 0,
        PerformanceApiKeys.goalReview: goalReviews,
        PerformanceApiKeys.competencyReview: competencyReviews,
        'timeline': timeline,
        'achievements': details.achievements,
        'challenges': details.challenges,
        'development_needs': details.developmentNeeds,
      },
    };

    if (isSubmit) {
      emit(state.copyWith(actionStatus: SelfAssessmentActionStatus.submitting));
    } else {
      emit(state.copyWith(actionStatus: SelfAssessmentActionStatus.saving));
    }

    final result = await updateSelfAssessmentUseCase(details.name, payload);

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
        final updatedTracking = trackingResult.fold(
          (_) => state.tracking,
          (t) => t,
        );

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

  double parseRating(String ratingStr) {
    if (ratingStr.isEmpty) return 0;
    final match = RegExp(r'\d+').firstMatch(ratingStr);
    if (match != null) {
      return double.tryParse(match.group(0)!) ?? 0;
    }
    return 0;
  }

  List<double> getProgressValues(int rating) {
    switch (rating) {
      case 1:
        return [0, 18, 35, 53, 70];
      case 2:
        return [71, 73, 76, 78, 80];
      case 3:
        return [81, 85, 88, 92, 95];
      case 4:
        return [96, 98, 101, 103, 105];
      default:
        return [0, 25, 50, 75, 100];
    }
  }

  void updateGoal(
    GoalReviewEntity goal, {
    String? selfRating,
    double? progress,
    String? selfComment,
  }) {
    String finalRating = selfRating ?? goal.selfRating;
    double finalProgress = progress ?? goal.progress;

    final int ratingInt = parseRating(finalRating).toInt();
    final values = getProgressValues(ratingInt);
    final double minVal = values.first;
    final double maxVal = values.last;

    if (selfRating != null) {
      // Rating changed, snap to the first value of the new range if current progress is out of bounds
      if (finalProgress < minVal || finalProgress > maxVal) {
        finalProgress = minVal;
      }
    }

    // Clamp progress to current rating range
    finalProgress = finalProgress.clamp(minVal, maxVal);

    updateLocalGoalFeedback(
      goal.copyWith(
        selfRating: finalRating,
        progress: finalProgress,
        selfComment: selfComment ?? goal.selfComment,
      ),
    );
  }

  String formatSessionDate(String sessionStart) {
    final startDt = DateTime.tryParse(sessionStart);
    if (startDt != null) {
      return DateTimeUtils.formatDate(
        startDt,
        pattern: AppConstants.dateFormatDayMonthYear,
      );
    }
    return sessionStart;
  }

  String formatSessionTime(String sessionStart, String sessionEnd) {
    final startDt = DateTime.tryParse(sessionStart);
    if (startDt == null) return '';

    final startTime = DateTimeUtils.formatDate(
      startDt,
      pattern: AppConstants.timeFormat12hrPadded,
    ).toLowerCase();

    if (sessionEnd.isEmpty) {
      return '$startTime - ${AppConstants.placeholderText}';
    }

    final endDt = DateTime.tryParse(sessionEnd);
    if (endDt != null) {
      final endTime = DateTimeUtils.formatDate(
        endDt,
        pattern: AppConstants.timeFormat12hrPadded,
      ).toLowerCase();
      if (DateTimeUtils.isSameDay(startDt, endDt)) {
        return '$startTime - $endTime';
      } else {
        final endDate = DateTimeUtils.formatDate(
          endDt,
          pattern: AppConstants.dateFormatDayMonthYear,
        );
        return '$startTime - $endDate, $endTime';
      }
    }
    return '$startTime - ${AppConstants.placeholderText}';
  }

  String formatQuestionTime(String lastModified) {
    final dt = DateTime.tryParse(lastModified);
    if (dt != null) {
      return DateTimeUtils.formatDate(
        dt,
        pattern: AppConstants.timeFormat12hrPadded,
      ).toLowerCase();
    }
    return lastModified;
  }

  String getRatingOutOfFour(String rating) {
    if (rating.isEmpty) return '0';
    return rating.split(' ').first;
  }

  Future<void> pickAndUploadAttachment({
    required AppLocalizations l10n,
    required int currentCount,
  }) async {
    if (!FileValidationUtils.canUploadMore(
      currentCount: currentCount,
      l10n: l10n,
      maxCount: 5,
    )) {
      return;
    }

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'xlsx', 'jpg', 'jpeg', 'png', 'webp'],
    );

    if (result != null && result.files.single.path != null) {
      final file = result.files.single;

      if (!FileValidationUtils.validateFile(
        file: file,
        l10n: l10n,
        maxSizeBytes: 50 * 1024 * 1024,
      )) {
        return;
      }

      emit(state.copyWith(isAttachmentUploading: true));

      try {
        await uploadAttachment(filePath: file.path!, fileName: file.name);
      } finally {
        emit(state.copyWith(isAttachmentUploading: false));
      }
    }
  }

  Future<String?> uploadAttachment({
    required String filePath,
    required String fileName,
  }) async {
    final details = state.details;
    if (details == null) {
      ToastUtils.showError('Unable to upload: Assessment details not loaded.');
      return null;
    }

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
          ToastUtils.showError(failure.message);
          return null;
        },
        (fileUrl) async {
          // Re-fetch assessment to update attachments list
          await fetchSelfAssessment(details.name, '');
          ToastUtils.showSuccess('File uploaded successfully.');
          return fileUrl;
        },
      );
    } catch (e) {
      ToastUtils.showError('An error occurred during file upload: $e');
      return null;
    }
  }

  Future<bool> deleteAttachment(String fileId) async {
    final details = state.details;
    if (details == null) {
      ToastUtils.showError('Unable to delete: Assessment details not loaded.');
      return false;
    }

    emit(state.copyWith(deletingAttachmentId: fileId));

    try {
      final result = await deleteSaAttachmentUseCase(fileId);

      return await result.fold(
        (failure) {
          ToastUtils.showError(failure.message);
          return false;
        },
        (_) async {
          // Re-fetch assessment to update attachments list
          await fetchSelfAssessment(details.name, '');
          ToastUtils.showSuccess('File deleted successfully.');
          return true;
        },
      );
    } catch (e) {
      ToastUtils.showError('An error occurred during file deletion: $e');
      return false;
    } finally {
      emit(state.copyWith(deletingAttachmentId: ''));
    }
  }
}
