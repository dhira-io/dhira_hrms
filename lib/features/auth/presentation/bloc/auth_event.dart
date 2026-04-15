import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user_entity.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.started() = _Started;
  const factory AuthEvent.authStatusChecked() = _AuthStatusChecked;
  const factory AuthEvent.forgotPasswordRequested(String email) = _ForgotPasswordRequested;
  const factory AuthEvent.microsoftSSORequested() = _MicrosoftSSORequested;
  const factory AuthEvent.ssoCallbackReceived(String apiKey, String apiSecret) = _SSOCallbackReceived;
  const factory AuthEvent.verifyOtpRequested(String email, String otp) = _VerifyOtpRequested;
  const factory AuthEvent.resendOtpRequested(String email) = _ResendOtpRequested;
  const factory AuthEvent.logoutRequested() = _LogoutRequested;
  const factory AuthEvent.loggedIn(UserEntity user) = _LoggedIn;
}
