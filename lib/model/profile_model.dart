// lib/models/profile_model.dart

class Profile {
  final String fullName;
  final String firstName;
  final String lastName;
  final String email;
  final String? deskTheme;
  final String? userImage;
  final String? birthdate;
  final String? gender;

  Profile({
    required this.fullName,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.deskTheme,
    this.userImage,
    this.birthdate,
    this.gender,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      fullName: json['full_name'] ?? 'N/A',
      firstName: json['first_name'] ?? 'N/A',
      lastName: json['last_name'] ?? 'N/A',
      email: json['email'] ?? 'N/A',
      deskTheme: json['desk_theme'],
      userImage: json['user_image'],
      gender: json['gender'],
      birthdate: json['birth_date'],
    );
  }
}