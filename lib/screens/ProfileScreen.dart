// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/profile_provider.dart';
import '../services/api_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userfullname = "";
  String useremail = "";

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getdata();
    });
  }

  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userfullname = prefs.getString('userfullname') ?? "";
    useremail = prefs.getString('useremail') ?? "";

    if (useremail.isNotEmpty) {
      Provider.of<ProfileProvider>(context, listen: false).fetchProfile(useremail);
    }
    setState(() {});
  }

  // --- Image Selection and Delegation ---
  Future<void> _pickAndUploadImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source, imageQuality: 50);

    if (pickedFile != null && useremail.isNotEmpty) {
      if (mounted) Navigator.pop(context);
      _showLoadingDialog(context, 'Uploading image...');

      final provider = Provider.of<ProfileProvider>(context, listen: false);

      // Delegate API call to the provider
      bool success = await provider.uploadImageAndRefresh(
          pickedFile.path,
          useremail
      );

      if (mounted) Navigator.pop(context);

      if (!success && mounted) {
        // Show detailed error from the provider if available, or a generic message
        final errorMessage = provider.errorMessage.isNotEmpty
            ? provider.errorMessage
            : 'Image upload failed.';
        _showSnackbar(context, errorMessage);
      }
    }
  }

  // --- UI Helpers ---

  void _showLoadingDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 20),
              Text(message),
            ],
          ),
        );
      },
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Gallery'),
                onTap: () => _pickAndUploadImage(ImageSource.gallery),
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () => _pickAndUploadImage(ImageSource.camera),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileTile(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 18, color: Colors.black87),
          ),
          const Divider(thickness: 1, height: 16),
        ],
      ),
    );
  }

  // --- Widget Build Method ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        // actions: [
        //   Consumer<ProfileProvider>(
        //     builder: (context, provider, child) {
        //       // Disable edit button during any loading state
        //       return IconButton(
        //         icon: const Icon(Icons.edit),
        //         onPressed: provider.isUploading || provider.state == ProfileState.loading
        //             ? null
        //             : () => _showImageSourceActionSheet(context),
        //       );
        //     },
        //   ),
        // ],
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, provider, child) {

          if (provider.isUploading || provider.state == ProfileState.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          switch (provider.state) {
            case ProfileState.error:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error: ${provider.errorMessage}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => provider.fetchProfile(useremail),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );

            case ProfileState.loaded:
              final profile = provider.profile!;
              print("profile-baseurl = ${ApiService.baseUrl}");
              print("profile-userImage = ${profile.userImage}");

              return SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Image
                    Center(
                      child: GestureDetector(
                        onTap: () => _showImageSourceActionSheet(context),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: profile.userImage != null
                                  ? NetworkImage(ApiService.baseUrl + profile.userImage!)
                                  : const AssetImage('assets/profile.png'),
                              backgroundColor: Colors.blueGrey,
                              // child: profile.userImage == null
                              //     ? AssetImage('assets/profile.png')//const Icon(Icons.person, size: 60, color: Colors.white)
                              //     : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                                child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Full Name
                    Center(
                      child: Text(
                        profile.fullName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const Divider(thickness: 2, height: 40),

                    // Display details
                    _buildProfileTile('First Name', profile.firstName),
                    _buildProfileTile('Last Name', profile.lastName),
                    _buildProfileTile('Birth Date', profile.birthdate ?? 'N/A'),
                    _buildProfileTile('Gender', profile.gender ?? 'N/A'),
                    _buildProfileTile('Email', profile.email),
                    _buildProfileTile('Desk Theme', profile.deskTheme ?? 'Default'),
                  ],
                ),
              );

            case ProfileState.initial:
            default:
              return const Center(child: Text('Initializing...'));
          }
        },
      ),
    );
  }
}