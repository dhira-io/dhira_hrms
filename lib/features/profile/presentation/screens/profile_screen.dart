import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/storage_constants.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/utils/toast_utils.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../widgets/profile_info_section.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  String? _email;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    _email = prefs.getString(StorageConstants.userEmail);
    if (_email != null) {
      if (mounted) {
        context.read<ProfileBloc>().add(ProfileEvent.started(_email!));
      }
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source, imageQuality: 50);
    if (image != null && _email != null) {
      if (mounted) {
        context.read<ProfileBloc>().add(ProfileEvent.avatarUpdateRequested(
          filePath: image.path,
          email: _email!,
        ));
      }
    }
  }

  void _showImageSourceSheet() {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(l10n.gallery, style: AppTextStyle.bodyMedium),
              onTap: () {
                context.pop();
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(l10n.camera, style: AppTextStyle.bodyMedium),
              onTap: () {
                context.pop();
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider<ProfileBloc>.value(
      value: Get.find<ProfileBloc>(),
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.myProfile)),
        body: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (message) => ToastUtils.showSuccess(message),
              error: (message) => ToastUtils.showError(message),
            );
          },
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (message) => Center(child: Text(message, style: AppTextStyle.error)),
                orElse: () => SingleChildScrollView(
                  padding: const EdgeInsets.all(AppConstants.p20),
                  child: ProfileInfoSection(onPickImage: _showImageSourceSheet),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

