import '../../../../core/error/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../constants/auth_api_constants.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signIn(String email, String password);
  Future<void> logout();
  Future<UserModel> getEmployeeDetails(String userId);
  Future<void> forgotPassword(String email);
  Future<UserModel> microsoftSSO();
  Future<bool> verifyOtp(String email, String otp);
  Future<bool> resendOtp(String email);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSourceImpl(this.dioClient);

  @override
  Future<UserModel> signIn(String email, String password) async {
    await dioClient.post(
      AuthApiConstants.login,
      data: {
        "usr": email,
        "pwd": password,
      },
    );
    // Successful login, response body might not contain user info but cookies are saved by interceptor
    // We now fetch the user's basic info to return a model
    return await getEmployeeDetails(email);
  }

  @override
  Future<void> logout() async {
    await dioClient.get(AuthApiConstants.logout);
  }

  @override
  Future<UserModel> getEmployeeDetails(String userId) async {
    final response = await dioClient.get(
      AuthApiConstants.employee,
      queryParameters: {
        "filters": '[["user_id", "=", "$userId"]]',
        "fields": '["name", "employee_name", "department", "user_image", "email"]',
      },
    );

    final List data = response.data['data'];
    if (data.isEmpty) {
      throw const ServerException(message: "Employee record not found");
    }
    return UserModel.fromJson(data.first);
  }

  @override
  Future<void> forgotPassword(String email) async {
    await dioClient.post(
      AuthApiConstants.resetPassword,
      data: {"user": email},
    );
  }

  @override
  Future<UserModel> microsoftSSO() async {
    // Mock implementation for Microsoft SSO
    await Future.delayed(const Duration(seconds: 1));
    return const UserModel(
      empId: "EMP-001",
      fullName: "Microsoft SSO User",
      email: "sso@dhira.io",
      department: "Engineering",
      userImage: null,
    );
  }

  @override
  Future<bool> verifyOtp(String email, String otp) async {
    // Mock implementation for OTP
    await Future.delayed(const Duration(seconds: 1));
    if (otp == "1234") {
      return true;
    } else {
      throw const ServerException(message: "Invalid OTP");
    }
  }

  @override
  Future<bool> resendOtp(String email) async {
    // Mock implementation for Resend OTP
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}
