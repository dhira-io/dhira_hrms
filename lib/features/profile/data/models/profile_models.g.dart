// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) =>
    _ProfileModel(
      fullName: json['full_name'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      deskTheme: json['desk_theme'] as String?,
      userImage: json['user_image'] as String?,
      birthDate: json['birth_date'] as String?,
      gender: json['gender'] as String?,
    );

Map<String, dynamic> _$ProfileModelToJson(_ProfileModel instance) =>
    <String, dynamic>{
      'full_name': instance.fullName,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'desk_theme': instance.deskTheme,
      'user_image': instance.userImage,
      'birth_date': instance.birthDate,
      'gender': instance.gender,
    };
