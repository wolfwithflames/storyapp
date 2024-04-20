// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['_id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      isProfileCompleted: json['isProfileCompleted'] as bool?,
      profileImage: json['profileImage'],
      email: json['email'],
      token: json['token'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'isProfileCompleted': instance.isProfileCompleted,
      'profileImage': instance.profileImage,
      'email': instance.email,
      'token': instance.token,
    };
