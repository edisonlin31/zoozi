// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Transaction _$TransactionFromJson(Map json) => _Transaction(
  id: (json['id'] as num).toInt(),
  walletId: (json['walletId'] as num).toInt(),
  type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
  amount: (json['amount'] as num).toDouble(),
  description: json['description'] as String?,
  referenceId: json['referenceId'] as String?,
  timestamp: DateTime.parse(json['timestamp'] as String),
  relatedTransactionId: (json['relatedTransactionId'] as num?)?.toInt(),
);

Map<String, dynamic> _$TransactionToJson(_Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'walletId': instance.walletId,
      'type': _$TransactionTypeEnumMap[instance.type]!,
      'amount': instance.amount,
      'description': instance.description,
      'referenceId': instance.referenceId,
      'timestamp': instance.timestamp.toIso8601String(),
      'relatedTransactionId': instance.relatedTransactionId,
    };

const _$TransactionTypeEnumMap = {
  TransactionType.deposit: 'DEPOSIT',
  TransactionType.withdrawal: 'WITHDRAWAL',
};
