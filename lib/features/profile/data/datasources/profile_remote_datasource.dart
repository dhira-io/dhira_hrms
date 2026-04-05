import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../constants/profile_api_constants.dart';
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
    final response = await dioClient.get(
      ProfileApiConstants.getUserDetails,
      queryParameters: {"user": email},
    );

    final userData = response.data['data'];
    if (userData == null) throw const ServerException(message: "Profile data not found");
    return ProfileModel.fromJson(userData);
  }

  @override
  Future<bool> updateAvatar(String filePath, String email) async {
    final fileName = filePath.split('/').last;
    
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath, filename: fileName),
      'docname': email,
      'doctype': 'User',
      'fieldname': 'user_image',
      'is_private': 0,
    });

    final response = await dioClient.post(
      ProfileApiConstants.uploadFile,
      data: formData,
    );

    return response.statusCode == 200;
  }

  @override
  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
    required String logoutAllSessions,
  }) async {
    final response = await dioClient.post(
      ProfileApiConstants.changePassword,
      data: {
        "old_password": oldPassword,
        "new_password": newPassword,
        "logout_all_sessions": logoutAllSessions,
      },
    );
    return response.statusCode == 200;
  }
}
