import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dhira_hrms/features/policy/domain/entities/policy_pdf_entity.dart';

part 'policy_pdf_state.freezed.dart';

enum PolicyPdfStatus { initial, loading, success, failure }

@freezed
abstract class PolicyPdfState with _$PolicyPdfState {
  const factory PolicyPdfState({
    @Default(PolicyPdfStatus.initial) PolicyPdfStatus status,
    PolicyPdfEntity? pdf,
    String? message,
  }) = _PolicyPdfState;
}
