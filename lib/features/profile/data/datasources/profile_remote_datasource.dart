import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../constants/profile_api_constants.dart';
import '../models/profile_models.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile(String identifier);
  Future<String> updateAvatar(String filePath, String identifier);
  Future<bool> deleteProfileImage(String employeeId);
  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
    required String logoutAllSessions,
  });
  Future<bool> updateProfileDetails({
    required String identifier,
    required String personalEmail,
    required String phone,
    required String emergencyContact,
    required String currentAddress,
    required String permanentAddress,
    String? dateOfBirth,
  });
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final DioClient dioClient;

  ProfileRemoteDataSourceImpl(this.dioClient);

  @override
  Future<ProfileModel> getProfile(String identifier) async {
    Response response;
    if (identifier.contains('@')) {
      response = await dioClient.get(
        ProfileApiConstants.getUserDetails,
        queryParameters: {
          "filters": '[["user_id","=","$identifier"]]',
          "fields": '["*"]',
        },
      );
      final List? dataList = response.data['data'];
      if (dataList == null || dataList.isEmpty) {
        throw const ServerException(message: "Profile data not found");
      }
      return ProfileModel.fromJson(Map<String, dynamic>.from(dataList.first));
    } else {
      response = await dioClient.get(
        "${ProfileApiConstants.getUserDetails}/$identifier",
        queryParameters: {"fields": '["*"]'},
      );
      final userData = response.data['data'];
      if (userData == null)
        throw const ServerException(message: "Profile data not found");
      return ProfileModel.fromJson(userData);
    }
  }

  @override
  Future<String> updateAvatar(String filePath, String identifier) async {
    final fileName = filePath.split('/').last;

    // Step 1: Upload the file
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath, filename: fileName),
      'docname': identifier,
      'doctype': 'Employee',
      'fieldname': 'image',
      'folder': 'Home',
      'is_private': '0',
    });

    final uploadResponse = await dioClient.post(
      ProfileApiConstants.uploadFile,
      data: formData,
    );

    final fileUrl = uploadResponse.data['message']['file_url'];

    // Step 2: Update the Employee record
    final updateResponse = await dioClient.put(
      "${ProfileApiConstants.getUserDetails}/$identifier",
      data: {
        "data": {"image": fileUrl},
      },
    );

    if (updateResponse.statusCode == 200 || updateResponse.statusCode == 202) {
      final message = updateResponse.data['message'];
      if (message is String && message.trim().isNotEmpty) {
        return message.trim();
      }
      return "Profile picture updated successfully";
    } else {
      throw const ServerException(message: "Failed to update profile picture");
    }
  }

  @override
  Future<bool> deleteProfileImage(String employeeId) async {
    final response = await dioClient.post(
      ProfileApiConstants.deleteProfileImage,
      queryParameters: {"employee_id": employeeId},
    );
    return response.statusCode == 200 &&
        response.data['message']?['success'] == true;
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

  @override
  Future<bool> updateProfileDetails({
    required String identifier,
    required String personalEmail,
    required String phone,
    required String emergencyContact,
    required String currentAddress,
    required String permanentAddress,
    String? dateOfBirth,
  }) async {
    final response = await dioClient.put(
      "${ProfileApiConstants.getUserDetails}/$identifier",
      data: {
        "data": {
          "personal_email": personalEmail,
          "cell_number": phone,
          "emergency_phone_number": emergencyContact,
          "current_address": currentAddress,
          "permanent_address": permanentAddress,
          if (dateOfBirth != null) "date_of_birth": dateOfBirth,
        },
      },
    );
    return response.statusCode == 200 || response.statusCode == 202;
  }
}
