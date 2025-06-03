import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:zoozitest/models/transaction.dart';

part 'transaction_response.freezed.dart';
part 'transaction_response.g.dart';

@freezed
abstract class TransactionResponse with _$TransactionResponse {
  const TransactionResponse._();
  factory TransactionResponse({
    required List<Transaction> transactions,
    required int total,
    required int page,
    required int limit,
  }) = _TransactionResponse;

  factory TransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionResponseFromJson(json);
}
