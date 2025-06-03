import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:zoozitest/models/enums/transaction_type.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

@freezed
abstract class Transaction with _$Transaction {
  const Transaction._();
  factory Transaction({
    required int id,
    required int walletId,
    required TransactionType type,
    required double amount,
    String? description,
    String? referenceId,
    required DateTime timestamp,
    int? relatedTransactionId,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
}
