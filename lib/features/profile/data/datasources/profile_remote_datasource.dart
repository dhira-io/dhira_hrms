import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../constants/profile_api_constants.dart';
import '../models/profile_models.dart';
import '../models/resume_model.dart';
import '../models/search_employee_model.dart';

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
    String? emergencyContactName,
    String? nationality,
    required String currentAddress,
    required String permanentAddress,
    String? currentLocation,
    String? dateOfBirth,
  });

  // Resume operations
  Future<ResumeModel> getEmployeeResume(String employeeId);
  Future<List<String>> searchSkills(String query);
  Future<List<String>> searchDesignations(String query);
  Future<List<String>> searchProjects(String query);
  Future<List<SearchEmployeeModel>> searchEmployees(String query);
  Future<List<SubSkillModel>> getSubSkills(String skillName);
  Future<void> upsertResumeRow(String employeeId, String section, String rowDataJson, {String? rowName});
  Future<void> deleteResumeRow(String employeeId, String section, String rowName);
  Future<void> updateEmployeeResume(String employeeId, String resumeDataJson);
  Future<void> updateEmployeeSubSkills(String employeeId, String subSkillsJson);
  Future<void> saveSubSkillsForSkill(String employeeId, String skillName, String subSkillsJson);
  Future<void> updateEmployeeProjectAssignments(String employeeId, String assignmentsJson);
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
        throw const ServerException(message: ProfileApiConstants.errProfileDataNotFound);
      }
      return ProfileModel.fromJson(Map<String, dynamic>.from(dataList.first));
    } else {
      response = await dioClient.get(
        "${ProfileApiConstants.getUserDetails}/$identifier",
        queryParameters: {"fields": '["*"]'},
      );
      final userData = response.data['data'];
      if (userData == null)
        throw const ServerException(message: ProfileApiConstants.errProfileDataNotFound);
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
      return ProfileApiConstants.msgProfilePicUpdated;
    } else {
      throw const ServerException(message: ProfileApiConstants.errProfilePicUpdateFailed);
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
    String? emergencyContactName,
    String? nationality,
    required String currentAddress,
    required String permanentAddress,
    String? currentLocation,
    String? dateOfBirth,
  }) async {
    final response = await dioClient.put(
      "${ProfileApiConstants.getUserDetails}/$identifier",
      data: {
        "data": {
          "personal_email": personalEmail,
          "cell_number": phone,
          "emergency_phone_number": emergencyContact,
          if (emergencyContactName != null && emergencyContactName.isNotEmpty) "person_to_be_contacted": emergencyContactName,
          if (nationality != null && nationality.isNotEmpty) "custom_nationality": nationality,
          "current_address": currentAddress,
          "permanent_address": permanentAddress,
          if (currentLocation != null) "custom_current_location": currentLocation,
          if (dateOfBirth != null) "date_of_birth": dateOfBirth,
        },
      },
    );
    return response.statusCode == 200 || response.statusCode == 202;
  }

  @override
  Future<ResumeModel> getEmployeeResume(String employeeId) async {
    final response = await dioClient.get(
      ProfileApiConstants.getEmployeeResume,
      queryParameters: {"employee": employeeId},
    );
    final data = response.data['message'];
    if (data == null) throw const ServerException(message: ProfileApiConstants.errResumeDataNotFound);
    return ResumeModel.fromJson(Map<String, dynamic>.from(data));
  }

  @override
  Future<List<String>> searchSkills(String query) async {
    final response = await dioClient.get(
      ProfileApiConstants.searchSkill,
      queryParameters: {
        "filters": '[["skill_name","like","%$query%"]]',
        "fields": '["skill_name"]',
        "limit_page_length": 50,
      },
    );
    final data = response.data['data'] as List?;
    if (data == null) return [];
    return data.map((e) => e['skill_name'] as String).toList();
  }

  @override
  Future<List<String>> searchDesignations(String query) async {
    final response = await dioClient.get(
      ProfileApiConstants.searchDesignation,
      queryParameters: {
        "filters": '[["name","like","%$query%"]]',
        "fields": '["name"]',
        "limit_page_length": 50,
      },
    );
    final data = response.data['data'] as List?;
    if (data == null) return [];
    return data.map((e) => e['name'] as String).toList();
  }

  @override
  Future<List<String>> searchProjects(String query) async {
    final response = await dioClient.get(
      ProfileApiConstants.searchProject,
      queryParameters: {
        "filters": '[["project_name","like","%$query%"]]',
        "fields": '["project_name"]',
        "limit_page_length": 10,
      },
    );
    final data = response.data['data'] as List?;
    if (data == null) return [];
    return data.map((e) => e['project_name'] as String).toList();
  }

  @override
  Future<List<SearchEmployeeModel>> searchEmployees(String query) async {
    final response = await dioClient.get(
      ProfileApiConstants.searchEmployees,
      queryParameters: {
        "query": query,
        "limit": 20,
      },
    );
    final data = response.data['message'] as List?;
    if (data == null) return [];
    return data.map((e) => SearchEmployeeModel.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  @override
  Future<List<SubSkillModel>> getSubSkills(String skillName) async {
    final response = await dioClient.post(
      ProfileApiConstants.getCustomSubSkills,
      data: {"skill_name": skillName},
    );
    final data = response.data['message'] as List?;
    if (data == null) return [];
    return data.map((e) {
      final map = Map<String, dynamic>.from(e);
      if (map.containsKey('sub_skill')) {
        map['name'] = map['sub_skill'];
      }
      return SubSkillModel.fromJson(map);
    }).toList();
  }

  @override
  Future<void> upsertResumeRow(String employeeId, String section, String rowDataJson, {String? rowName}) async {
    final data = {
      "employee": employeeId,
      "section": section,
      "row_data": rowDataJson,
    };
    if (rowName != null && rowName.isNotEmpty) {
      data["row_name"] = rowName;
    }
    
    final response = await dioClient.post(
      ProfileApiConstants.upsertChildRow,
      data: data,
    );
    if (response.data['message']?['status'] != 'ok') {
      throw const ServerException(message: ProfileApiConstants.errFailedToSaveRow);
    }
  }

  @override
  Future<void> deleteResumeRow(String employeeId, String section, String rowName) async {
    final response = await dioClient.post(
      ProfileApiConstants.deleteChildRow,
      data: {
        "employee": employeeId,
        "section": section,
        "row_name": rowName,
      },
    );
    if (response.data['message']?['status'] != 'ok') {
      throw const ServerException(message: ProfileApiConstants.errFailedToDeleteRow);
    }
  }

  @override
  Future<void> updateEmployeeResume(String employeeId, String resumeDataJson) async {
    final response = await dioClient.post(
      ProfileApiConstants.updateEmployeeResume,
      data: {
        "employee": employeeId,
        "data": resumeDataJson,
      },
    );
    if (response.data['message']?['status'] != 'ok') {
      throw const ServerException(message: ProfileApiConstants.errFailedToUpdateResume);
    }
  }

  @override
  Future<void> updateEmployeeSubSkills(String employeeId, String subSkillsJson) async {
    final response = await dioClient.put(
      "${ProfileApiConstants.getUserDetails}/$employeeId",
      data: {
        "data": {
          "custom_sub_skill": jsonDecode(subSkillsJson),
        }
      },
    );
    if (response.statusCode != 200 && response.statusCode != 202) {
      throw const ServerException(message: ProfileApiConstants.errFailedToUpdateSubSkills);
    }
  }

  @override
  Future<void> saveSubSkillsForSkill(String employeeId, String skillName, String subSkillsJson) async {
    final response = await dioClient.post(
      ProfileApiConstants.saveSubSkillsForSkill,
      data: {
        "employee": employeeId,
        "skill_name": skillName,
        "sub_skills": subSkillsJson,
      },
    );
    if (response.data['message']?['status'] != 'ok') {
      throw const ServerException(message: ProfileApiConstants.errFailedToSaveSubSkills);
    }
  }
  @override
  Future<void> updateEmployeeProjectAssignments(String employeeId, String assignmentsJson) async {
    final response = await dioClient.put(
      "${ProfileApiConstants.getUserDetails}/$employeeId",
      data: {
        "data": {
          "custom_employee_assignment": jsonDecode(assignmentsJson),
        }
      },
    );
    if (response.statusCode != 200 && response.statusCode != 202) {
      throw const ServerException(message: ProfileApiConstants.errFailedToUpdateProjectAssignments);
    }
  }
}
