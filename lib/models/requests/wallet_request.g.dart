// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthRequest _$AuthRequestFromJson(Map json) => _AuthRequest(
  currency: json['currency'] as String,
  initialBalance: (json['initialBalance'] as num).toDouble(),
);

Map<String, dynamic> _$AuthRequestToJson(_AuthRequest instance) =>
    <String, dynamic>{
      'currency': instance.currency,
      'initialBalance': instance.initialBalance,
    };
