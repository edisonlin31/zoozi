// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionResponse _$TransactionResponseFromJson(Map json) =>
    _TransactionResponse(
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) => Transaction.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      total: (json['total'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$TransactionResponseToJson(
  _TransactionResponse instance,
) => <String, dynamic>{
  'transactions': instance.transactions.map((e) => e.toJson()).toList(),
  'total': instance.total,
  'page': instance.page,
  'limit': instance.limit,
};
