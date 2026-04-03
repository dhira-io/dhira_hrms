import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/dio_client.dart';
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
    try {
      final response = await dioClient.post(
        "api/method/login",
        data: {
          "usr": email,
          "pwd": password,
        },
      );

      if (response.statusCode == 200) {
        // Successful login, response body might not contain user info but cookies are saved by interceptor
        // We now fetch the user's basic info to return a model
        return await getEmployeeDetails(email);
      } else {
        throw const ServerException("Failed to sign in");
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw ServerException(e.response?.data['message'] ?? "Invalid credentials");
      }
      throw ServerException(e.message ?? "Network error during sign in");
    }
  }

  @override
  Future<void> logout() async {
    try {
      final response = await dioClient.get("api/method/logout");
      if (response.statusCode != 200) {
        throw const ServerException("Logout failed remotely");
      }
    } on DioException {
      throw const ServerException("Network error during logout");
    }
  }

  @override
  Future<UserModel> getEmployeeDetails(String userId) async {
    try {
      final response = await dioClient.get(
        "api/resource/Employee",
        queryParameters: {
          "filters": '[["user_id", "=", "$userId"]]',
          "fields": '["name", "employee_name", "department", "user_image", "email"]',
        },
      );

      if (response.statusCode == 200) {
        final List data = response.data['data'];
        if (data.isEmpty) {
          throw const ServerException("Employee record not found");
        }
        return UserModel.fromJson(data.first);
      } else {
        throw const ServerException("Failed to fetch employee details");
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? "Exception during fetching employee details");
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      final response = await dioClient.post(
        "api/method/frappe.core.doctype.user.user.reset_password",
        data: {"user": email},
      );

      if (response.statusCode != 200) {
        throw const ServerException("Failed to request password reset");
      }
    } on DioException catch (e) {
      throw ServerException(e.response?.data['message'] ?? e.message ?? "Network error during password reset");
    }
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
      throw const ServerException("Invalid OTP");
    }
  }

  @override
  Future<bool> resendOtp(String email) async {
    // Mock implementation for Resend OTP
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}
