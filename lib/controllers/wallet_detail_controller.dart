import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoozitest/controllers/wallets_controller.dart';
import 'package:zoozitest/models/wallet.dart';
import 'package:zoozitest/repositories/wallet_repository.dart';
import 'package:collection/collection.dart';

final walletDetailController = StateNotifierProvider.family
    .autoDispose<WalletDetailController, AsyncValue<Wallet>, int>(
      (ref, walletId) => WalletDetailController(ref, walletId),
    );

class WalletDetailController extends StateNotifier<AsyncValue<Wallet>> {
  final Ref _ref;
  final int _walletId;

  WalletDetailController(this._ref, this._walletId)
    : super(const AsyncLoading()) {
    _prefillWalletFromWalletsController();
    getWalletDetail();
  }

  void _prefillWalletFromWalletsController() {
    final walletsState = _ref.read(walletsController);
    if (walletsState is AsyncData<List<Wallet>>) {
      final wallet = walletsState.value.firstWhereOrNull(
        (w) => w.id == _walletId,
      );
      if (wallet != null) {
        state = AsyncData(wallet);
      }
    }
  }

  Future<void> getWalletDetail() async {
    try {
      final wallet = await _ref
          .read(walletsRepositoryProvider)
          .service
          .getWalletDetail(walletId: _walletId);
      if (mounted) {
        state = AsyncData(wallet);
        _ref.read(walletsController.notifier).updateWallet(wallet);
      }
    } catch (e, st) {
      if (mounted) {
        state = AsyncError(e, st);
      }
    }
  }
}
