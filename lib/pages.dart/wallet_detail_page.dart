import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoozitest/base/utils/app_text_styles.dart';
import 'package:zoozitest/base/utils/colors.dart';
import 'package:zoozitest/base/widgets/app_button.dart';
import 'package:zoozitest/base/widgets/transaction_item.dart';
import 'package:zoozitest/base/widgets/wallet_card_view.dart';
import 'package:zoozitest/controllers/transactions_controller.dart';
import 'package:zoozitest/controllers/wallet_detail_controller.dart';
import 'package:zoozitest/l10n/app_localizations.dart';
import 'package:zoozitest/models/enums/transaction_type.dart';
import 'package:zoozitest/router/router/router.gr.dart';

@RoutePage()
@RoutePage()
class WalletDetailPage extends ConsumerStatefulWidget {
  final int walletId;
  const WalletDetailPage({super.key, required this.walletId});

  @override
  ConsumerState<WalletDetailPage> createState() => _WalletDetailPageState();
}

class _WalletDetailPageState extends ConsumerState<WalletDetailPage> {
  @override
  Widget build(BuildContext context) {
    final walletState = ref.watch(walletDetailController(widget.walletId));
    final transactionsState = ref.watch(
      transactionsController(widget.walletId),
    );
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.walletDetails)),
      body: walletState.when(
        data: (wallet) => RefreshIndicator(
          onRefresh: () async {
            await ref
                .read(walletDetailController(widget.walletId).notifier)
                .getWalletDetail();
            await ref
                .read(transactionsController(widget.walletId).notifier)
                .getTransactions(refresh: true);
          },
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    WalletCardView(
                      wallet: wallet,
                      child: Row(
                        children: [
                          Expanded(
                            child: AppButton(
                              text: AppLocalizations.of(context)!.withdraw,
                              icon: Icons.arrow_downward,
                              onPressed: () {
                                context.router.push(
                                  CreateTransactionRoute(
                                    walletId: wallet.id,
                                    balance: wallet.balance,
                                    transactionType: TransactionType.withdrawal,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: AppButton(
                              text: AppLocalizations.of(context)!.deposit,
                              icon: Icons.arrow_upward,
                              onPressed: () {
                                context.router.push(
                                  CreateTransactionRoute(
                                    walletId: wallet.id,
                                    balance: wallet.balance,
                                    transactionType: TransactionType.deposit,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.recentTransactions,
                            style: AppTextStyles.medium().copyWith(
                              fontSize: 16,
                            ),
                          ),
                          transactionsState.whenOrNull(
                                data: (pagination) {
                                  if (pagination.transactions.length <= 8) {
                                    return const SizedBox.shrink();
                                  }
                                  return TextButton(
                                    onPressed: () {
                                      context.router.push(
                                        TransactionsRoute(
                                          walletId: widget.walletId,
                                        ),
                                      );
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.viewAll,
                                      style: AppTextStyles.medium(fontSize: 12),
                                    ),
                                  );
                                },
                              ) ??
                              const SizedBox.shrink(),
                        ],
                      ),
                    ),
                    transactionsState.when(
                      data: (pagination) {
                        if (pagination.transactions.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                AppLocalizations.of(
                                  context,
                                )!.noTransactionsFound,
                                style: AppTextStyles.regular(
                                  color: AppColors.secondaryText(context),
                                ),
                              ),
                            ),
                          );
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: pagination.transactions.length > 8
                              ? 8
                              : pagination.transactions.length,
                          itemBuilder: (context, index) {
                            final transaction = pagination.transactions[index];
                            return TransactionItem(transaction: transaction);
                          },
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
                                  AppLocalizations.of(
                                    context,
                                  )!.failedToLoadTransactions,
                                  style: AppTextStyles.medium(),
                                ),
                                const SizedBox(height: 8),
                                AppButton(
                                  text: AppLocalizations.of(context)!.retry,
                                  onPressed: () {
                                    ref
                                        .read(
                                          transactionsController(
                                            widget.walletId,
                                          ).notifier,
                                        )
                                        .getTransactions(
                                          refresh: true,
                                          showLoading: true,
                                        );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      loading: () {
                        return Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text(
            '${AppLocalizations.of(context)!.failedToLoadWalletDetails}: $error',
          ),
        ),
      ),
    );
  }
}
