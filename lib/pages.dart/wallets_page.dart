import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoozitest/base/utils/app_text_styles.dart';
import 'package:zoozitest/base/widgets/app_button.dart';
import 'package:zoozitest/base/widgets/wallet_card_view.dart';
import 'package:zoozitest/controllers/wallets_controller.dart';
import 'package:zoozitest/l10n/app_localizations.dart';
import 'package:zoozitest/router/router/router.gr.dart';

@RoutePage()
class WalletsPage extends ConsumerStatefulWidget {
  const WalletsPage({super.key});

  @override
  ConsumerState<WalletsPage> createState() => _WalletsPageState();
}

class _WalletsPageState extends ConsumerState<WalletsPage> {
  @override
  Widget build(BuildContext context) {
    final postState = ref.watch(walletsController);
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.wallets)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.push(CreateWalletRoute());
        },
        child: const Icon(Icons.add),
      ),
      body: postState.when(
        data: (data) {
          // ignore: unused_local_variable
          final brightness = Theme.of(context).brightness;
          return SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                await ref.read(walletsController.notifier).getWallets();
              },
              child: data.isEmpty
                  ? Center(
                      child: Text(AppLocalizations.of(context)!.noWalletsFound),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final wallet = data[index];
                        return GestureDetector(
                          onTap: () {
                            context.router.push(
                              WalletDetailRoute(walletId: wallet.id),
                            );
                          },
                          child: WalletCardView(wallet: wallet),
                        );
                      },
                    ),
            ),
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.failedToLoadWallets,
                    style: AppTextStyles.medium(),
                  ),
                  const SizedBox(height: 8),
                  AppButton(
                    text: AppLocalizations.of(context)!.retry,
                    onPressed: () {
                      ref.read(walletsController.notifier).getWallets();
                    },
                  ),
                ],
              ),
            ),
          );
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
