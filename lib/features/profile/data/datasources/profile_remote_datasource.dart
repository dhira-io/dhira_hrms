import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../constants/profile_api_constants.dart';
import '../models/profile_models.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile(String identifier);
  Future<bool> updateAvatar(String filePath, String identifier);
  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
    required String logoutAllSessions,
  });
  Future<bool> updateProfileDetails({
    required String identifier,
    required String companyEmail,
    required String phone,
    required String emergencyContact,
    required String currentAddress,
    required String permanentAddress,
  });
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final DioClient dioClient;

  ProfileRemoteDataSourceImpl(this.dioClient);

  @override
  Future<ProfileModel> getProfile(String identifier) async {
    // We use api/resource/Employee/$identifier
    final response = await dioClient.get(
      "${ProfileApiConstants.getUserDetails}/$identifier",
    );

    final userData = response.data['data'];
    if (userData == null) throw const ServerException(message: "Profile data not found");
    return ProfileModel.fromJson(userData);
  }

  @override
  Future<bool> updateAvatar(String filePath, String identifier) async {
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
        "data": {
          "image": fileUrl,
        }
      },
    );

    return updateResponse.statusCode == 200 || updateResponse.statusCode == 202;
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
    required String companyEmail,
    required String phone,
    required String emergencyContact,
    required String currentAddress,
    required String permanentAddress,
  }) async {
    final response = await dioClient.put(
      "${ProfileApiConstants.getUserDetails}/$identifier",
      data: {
        "data": {
          "company_email": companyEmail,
          "cell_number": phone,
          "emergency_contact_name": emergencyContact,
          "current_address": currentAddress,
          "permanent_address": permanentAddress,
        }
      },
    );
    return response.statusCode == 200 || response.statusCode == 202;
  }
}
