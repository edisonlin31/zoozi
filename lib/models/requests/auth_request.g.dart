// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthRequest _$AuthRequestFromJson(Map json) => _AuthRequest(
  email: json['email'] as String,
  password: json['password'] as String,
  name: json['name'] as String?,
);

Map<String, dynamic> _$AuthRequestToJson(_AuthRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      if (instance.name case final value?) 'name': value,
    };
