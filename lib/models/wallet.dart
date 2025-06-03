import 'package:freezed_annotation/freezed_annotation.dart';
part 'wallet.freezed.dart';
part 'wallet.g.dart';

@freezed
abstract class Wallet with _$Wallet {
  const Wallet._();
  factory Wallet({
    required int id,
    required int userId,
    @Default(0) double balance,
    @Default('USD') String currency,
    required DateTime createdAt,
  }) = _Wallet;

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);
}
