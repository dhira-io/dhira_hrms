import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../models/profile_models.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile(String email);
  Future<bool> updateAvatar(String filePath, String email);
  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
    required String logoutAllSessions,
  });
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final DioClient dioClient;

  ProfileRemoteDataSourceImpl(this.dioClient);

  @override
  Future<ProfileModel> getProfile(String email) async {
    try {
      final response = await dioClient.get(
        "api/method/dhira_hrms.api.user.get_user_details",
        queryParameters: {"user": email},
      );

      if (response.statusCode == 200) {
        final userData = response.data['data'];
        if (userData == null) throw const ServerException("Profile data not found");
        return ProfileModel.fromJson(userData);
      } else {
        throw const ServerException("Failed to fetch profile");
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? "Exception in getProfile");
    }
  }

  @override
  Future<bool> updateAvatar(String filePath, String email) async {
    try {
      final file = File(filePath);
      final fileName = file.path.split('/').last;
      
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath, filename: fileName),
        'docname': email,
        'doctype': 'User',
        'fieldname': 'user_image',
        'is_private': 0,
      });

      final response = await dioClient.post(
        "api/method/upload_file",
        data: formData,
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      throw ServerException(e.message ?? "Exception in updateAvatar");
    }
  }

  @override
  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
    required String logoutAllSessions,
  }) async {
    try {
      final response = await dioClient.post(
        "api/method/frappe.core.doctype.user.user.change_password",
        data: {
          "old_password": oldPassword,
          "new_password": newPassword,
          "logout_all_sessions": logoutAllSessions,
        },
      );
      return response.statusCode == 200;
    } on DioException catch (e) {
      throw ServerException(e.message ?? "Exception in changePassword");
    }
  }
}
