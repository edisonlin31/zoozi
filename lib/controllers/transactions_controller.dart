import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoozitest/models/responses/transaction_response.dart';
import 'package:zoozitest/repositories/wallet_repository.dart';

final transactionsController = StateNotifierProvider.family
    .autoDispose<TransactionsController, AsyncValue<TransactionResponse>, int>(
      (ref, walletId) => TransactionsController(ref, walletId),
    );

class TransactionsController
    extends StateNotifier<AsyncValue<TransactionResponse>> {
  final Ref _ref;
  final int _walletId;

  int _currentPage = 1;
  bool _isLoadingMore = false;
  bool hasMore = true;
  final int _limit = 10;

  TransactionsController(this._ref, this._walletId)
    : super(const AsyncLoading()) {
    getTransactions();
  }

  Future<void> getTransactions({
    bool isLoadMore = false,
    bool refresh = false,
    bool showLoading = false,
  }) async {
    if (showLoading) {
      state = const AsyncLoading();
    }
    if (refresh) {
      _currentPage = 1;
      _isLoadingMore = false;
      hasMore = true;
    }
    if (_isLoadingMore || !hasMore) return;
    if (isLoadMore) _isLoadingMore = true;

    try {
      final response = await _ref
          .read(walletsRepositoryProvider)
          .service
          .getWalletTransactions(
            walletId: _walletId,
            page: _currentPage,
            limit: _limit,
          );

      if (isLoadMore) {
        hasMore = response.transactions.length >= _limit;

        final currentPagination = state.value;
        final updatedData = [
          ...?currentPagination?.transactions,
          ...response.transactions,
        ];
        state = AsyncData(
          TransactionResponse(
            transactions: updatedData,
            total: response.total,
            page: response.page,
            limit: response.limit,
          ),
        );
      } else {
        hasMore = response.transactions.length >= _limit;
        if (mounted) {
          state = AsyncData(response);
        }
      }
      _currentPage++;
    } catch (e, st) {
      if (mounted) {
        state = AsyncError(e, st);
      }
    } finally {
      _isLoadingMore = false;
    }
  }
}
