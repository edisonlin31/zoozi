// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionRequest _$TransactionRequestFromJson(Map json) =>
    _TransactionRequest(
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String?,
      referenceId: json['referenceId'] as String?,
    );

Map<String, dynamic> _$TransactionRequestToJson(_TransactionRequest instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'description': instance.description,
      'referenceId': instance.referenceId,
    };
