import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../core/network/dio_client.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_state.dart';

class ProfileInfoSection extends StatelessWidget {
  final VoidCallback onPickImage;

  const ProfileInfoSection({
    super.key,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    final baseUrl = Get.find<DioClient>().baseUrl;

    return BlocSelector<ProfileBloc, ProfileState, dynamic>(
      selector: (state) {
        return state.maybeWhen(
          loaded: (profile) => profile,
          orElse: () => null,
        );
      },
      builder: (context, profile) {
        if (profile == null) return const SizedBox.shrink();

        return Column(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: profile.userImage != null
                        ? NetworkImage('$baseUrl${profile.userImage}')
                        : const AssetImage('assets/profile.png') as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: FloatingActionButton.small(
                      onPressed: onPickImage,
                      child: const Icon(Icons.camera_alt),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              profile.fullName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 40),
            _InfoTile(label: 'Email', value: profile.email, icon: Icons.email),
            _InfoTile(label: 'First Name', value: profile.firstName, icon: Icons.person),
            _InfoTile(label: 'Last Name', value: profile.lastName, icon: Icons.person_outline),
            _InfoTile(label: 'Birth Date', value: profile.birthDate ?? 'N/A', icon: Icons.cake),
            _InfoTile(label: 'Gender', value: profile.gender ?? 'N/A', icon: Icons.wc),
            _InfoTile(label: 'Desk Theme', value: profile.deskTheme ?? 'Default', icon: Icons.palette),
          ],
        );
      },
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _InfoTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xff1100CC)),
      title: Text(
        label,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
