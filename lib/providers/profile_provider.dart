// lib/providers/profile_provider.dart
import 'package:dhira_hrms/model/profile_model.dart';
import 'package:flutter/foundation.dart';
import '../services/api_service.dart';

enum ProfileState { initial, loading, loaded, error }

class ProfileProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  Profile? _profile;
  ProfileState _state = ProfileState.initial;
  String _errorMessage = '';
  bool _isUploading = false;

  Profile? get profile => _profile;
  ProfileState get state => _state;
  String get errorMessage => _errorMessage;
  bool get isUploading => _isUploading;

  Future<void> fetchProfile(String userEmail) async {
    if (userEmail.isEmpty) {
      _state = ProfileState.error;
      _errorMessage = 'User email is required to fetch profile.';
      notifyListeners();
      return;
    }

    if (_state != ProfileState.loading) {
      _state = ProfileState.loading;
      notifyListeners();
    }

    try {
      // 💡 FIX: Call the method designed to return the full profile
      final fetchedResponse = await _apiService.fetchProfileData(userEmail);

      // FIX: Extract the nested 'data' map before parsing
      final userData = fetchedResponse['data'] as Map<String, dynamic>?;

      if (userData == null) {
        throw Exception('Profile data not found in the response.');
      }

      _profile = Profile.fromJson(userData);
      _state = ProfileState.loaded;
      _errorMessage = '';

    } catch (e) {
      _state = ProfileState.error;
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
    }

    notifyListeners();
  }

  Future<bool> uploadImageAndRefresh(String filePath, String userEmail) async {
    if (userEmail.isEmpty) return false;

    _isUploading = true;
    notifyListeners();

    bool success = false;
    try {
      success = await _apiService.uploadProfileImage(filePath, userEmail);

      if (success) {
        // Refresh the profile data to show the newly uploaded image
        await Future.delayed(const Duration(milliseconds: 500));
        // Use the primary fetch method to refresh
        await fetchProfile(userEmail);
      }

    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      _state = ProfileState.error;
    } finally {
      _isUploading = false;
      notifyListeners();
    }
    return success;
  }
}