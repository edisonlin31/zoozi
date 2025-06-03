// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Wallet _$WalletFromJson(Map json) => _Wallet(
  id: (json['id'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  balance: (json['balance'] as num?)?.toDouble() ?? 0,
  currency: json['currency'] as String? ?? 'USD',
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$WalletToJson(_Wallet instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'balance': instance.balance,
  'currency': instance.currency,
  'createdAt': instance.createdAt.toIso8601String(),
};
