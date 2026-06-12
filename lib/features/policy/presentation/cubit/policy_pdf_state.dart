import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/policy_pdf_entity.dart';

part 'policy_pdf_state.freezed.dart';

@freezed
abstract class PolicyPdfState with _$PolicyPdfState {
  const factory PolicyPdfState.initial() = _Initial;
  const factory PolicyPdfState.loading() = _Loading;
  const factory PolicyPdfState.success(PolicyPdfEntity pdf) = _Success;
  const factory PolicyPdfState.failure(String message) = _Failure;
}
