import '../../../../core/error/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../constants/auth_api_constants.dart';
import '../models/user_model.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signIn(String email, String password);
  Future<void> logout();
  Future<UserModel> getEmployeeDetails(String userId);
  Future<void> forgotPassword(String email);
  Future<void> initiateMicrosoftSSO();
  Future<UserModel> exchangeToken(String apiKey, String apiSecret);
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
        "filters": '[["user_id","=","$userId"]]',
        "fields": '["name","employee_name","custom_organization_department","leave_approver"]',
      },
    );

    final List data = response.data['data'];
    if (data.isEmpty) {
      throw const ServerException(message: "Employee record not found");
    }
    
    final Map<String, dynamic> dataMap = Map<String, dynamic>.from(data.first);
    dataMap['email'] = userId;
    
    return UserModel.fromJson(dataMap);
  }

  @override
  Future<void> forgotPassword(String email) async {
    await dioClient.post(
      AuthApiConstants.resetPassword,
      data: {"user": email},
    );
  }

  @override
  Future<void> initiateMicrosoftSSO() async {
    const callback = "com.dhira.hrms://auth/callback";
    final baseUrl = dioClient.baseUrl;
    final loginUrl = "${baseUrl}${AuthApiConstants.msLogin}?redirect_to=$callback";

    await launchUrl(
      Uri.parse(loginUrl),
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Future<UserModel> exchangeToken(String apiKey, String apiSecret) async {
    final response = await dioClient.post(
      AuthApiConstants.msExchangeToken,
      data: {
        "api_key": apiKey,
        "api_secret": apiSecret,
      },
    );

    final data = response.data;
    if (data["message"] != null) {
      final msg = data["message"];
      final String email = msg["user"];
      
      // After exchanging token, we fetch full employee details
      return await getEmployeeDetails(email);
    } else {
      throw const ServerException(message: "Invalid SSO Response");
    }
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
