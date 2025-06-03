import 'package:freezed_annotation/freezed_annotation.dart';
part 'wallet_request.freezed.dart';
part 'wallet_request.g.dart';

@freezed
abstract class WalletRequest with _$WalletRequest {
  const WalletRequest._();
  factory WalletRequest({
    required String currency,
    required double initialBalance,
  }) = _AuthRequest;

  factory WalletRequest.fromJson(Map<String, dynamic> json) =>
      _$WalletRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => toJson();
}
