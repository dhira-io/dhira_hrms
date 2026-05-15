import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import '../../domain/usecases/resend_otp_usecase.dart';

part 'otp_verification_cubit.freezed.dart';

enum OtpVerificationStatus { none, otpVerified, otpResent }

@freezed
class OtpVerificationState with _$OtpVerificationState {
  const factory OtpVerificationState.initial() = _Initial;
  const factory OtpVerificationState.loading() = _Loading;
  const factory OtpVerificationState.success(String message, {required OtpVerificationStatus status}) = _Success;
  const factory OtpVerificationState.error(String message) = _Error;
}

class OtpVerificationCubit extends Cubit<OtpVerificationState> {
  final VerifyOtpUseCase verifyOtpUseCase;
  final ResendOtpUseCase resendOtpUseCase;

  OtpVerificationCubit({
    required this.verifyOtpUseCase,
    required this.resendOtpUseCase,
  }) : super(const OtpVerificationState.initial());

  Future<void> verifyOtp(String email, String otp) async {
    emit(const _Loading());
    final result = await verifyOtpUseCase(email, otp);
    result.fold(
      (failure) => emit(_Error(failure.message)),
      (_) => emit(const _Success("OTP Verified Successfully", status: OtpVerificationStatus.otpVerified)),
    );
  }

  Future<void> resendOtp(String email) async {
    emit(const _Loading());
    final result = await resendOtpUseCase(email);
    result.fold(
      (failure) => emit(_Error(failure.message)),
      (_) => emit(const _Success("OTP Resent Successfully", status: OtpVerificationStatus.otpResent)),
    );
  }
}
