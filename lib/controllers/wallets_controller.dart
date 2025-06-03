import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoozitest/models/wallet.dart';
import 'package:zoozitest/repositories/wallet_repository.dart';

final walletsController =
    StateNotifierProvider.autoDispose<
      WalletsController,
      AsyncValue<List<Wallet>>
    >((ref) => WalletsController(ref));

class WalletsController extends StateNotifier<AsyncValue<List<Wallet>>> {
  final Ref _ref;

  WalletsController(this._ref) : super(const AsyncLoading()) {
    getWallets();
  }

  Future<void> getWallets() async {
    try {
      final posts = await _ref
          .read(walletsRepositoryProvider)
          .service
          .getWallets();
      if (mounted) {
        state = AsyncData(posts);
      }
    } catch (e, st) {
      if (mounted) {
        state = AsyncError(e, st);
      }
    }
  }

  void updateWallet(Wallet updatedWallet) {
    if (state is AsyncData<List<Wallet>>) {
      final wallets = (state as AsyncData<List<Wallet>>).value;
      final updatedWallets = wallets.map((wallet) {
        return wallet.id == updatedWallet.id ? updatedWallet : wallet;
      }).toList();
      state = AsyncData(updatedWallets);
    }
  }
}
