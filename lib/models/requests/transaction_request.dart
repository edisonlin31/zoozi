import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_request.freezed.dart';
part 'transaction_request.g.dart';

@freezed
abstract class TransactionRequest with _$TransactionRequest {
  const TransactionRequest._();

  factory TransactionRequest({
    required double amount,
    String? description,
    String? referenceId,
  }) = _TransactionRequest;

  factory TransactionRequest.fromJson(Map<String, dynamic> json) =>
      _$TransactionRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => toJson();
}
