import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoozitest/base/api/api.dart';
import 'package:zoozitest/models/requests/transaction_request.dart';
import 'package:zoozitest/models/requests/wallet_request.dart';
import 'package:zoozitest/models/transaction.dart';
import 'package:zoozitest/services/wallet_service.dart';

final walletsRepositoryProvider = Provider((ref) => WalletRepository());

class WalletRepository {
  final WalletService service = WalletService(
    Api.client,
    baseUrl: '${Api.baseUrl}/wallets',
  );

  WalletRepository();

  Future<void> createWallet(WalletRequest walletRequest) async {
    try {
      await service.createWallet(body: walletRequest);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Transaction> createDepositTransaction(
    int walletId,
    TransactionRequest request,
  ) async {
    try {
      return await service.createDepositTransaction(
        walletId: walletId,
        body: request,
      );
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Transaction> createWithdrawalTransaction(
    int walletId,
    TransactionRequest request,
  ) async {
    try {
      return await service.createWithdrawalTransaction(
        walletId: walletId,
        body: request,
      );
    } catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _handleError(dynamic e) {
    if (e is DioException) {
      final response = e.response?.data;
      if (response is Map<String, dynamic> && response.containsKey('message')) {
        final message = response['message'];
        if (message is List && message.isNotEmpty) {
          return message[0];
        }
        return message;
      }
    }
    return Api.unkownErrorMsg;
  }
}
