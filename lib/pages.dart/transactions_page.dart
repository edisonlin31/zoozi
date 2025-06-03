import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoozitest/base/utils/app_text_styles.dart';
import 'package:zoozitest/base/utils/colors.dart';
import 'package:zoozitest/base/widgets/transaction_item.dart';
import 'package:zoozitest/controllers/transactions_controller.dart';
import 'package:zoozitest/controllers/wallet_detail_controller.dart';
import 'package:zoozitest/l10n/app_localizations.dart';

@RoutePage()
class TransactionsPage extends ConsumerStatefulWidget {
  final int walletId;
  const TransactionsPage({super.key, required this.walletId});

  @override
  ConsumerState<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends ConsumerState<TransactionsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      final controller = ref.read(
        transactionsController(widget.walletId).notifier,
      );
      if (!controller.hasMore || controller.state is AsyncLoading) {
        return;
      }
      controller.getTransactions(isLoadMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final transactionsState = ref.watch(
      transactionsController(widget.walletId),
    );
    final walletState = ref.watch(walletDetailController(widget.walletId));
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.transactions)),
      body: walletState.whenOrNull(
        data: (wallet) {
          return transactionsState.when(
            data: (pagination) {
              final controller = ref.read(
                transactionsController(widget.walletId).notifier,
              );
              final data = pagination.transactions;
              return RefreshIndicator(
                onRefresh: () async {
                  await controller.getTransactions(refresh: true);
                },
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  controller: _scrollController,
                  itemCount: data.length + 1,
                  itemBuilder: (context, index) {
                    if (index == data.length) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: controller.hasMore
                            ? const Center(child: CircularProgressIndicator())
                            : Center(
                                child: Text(
                                  data.length > 10
                                      ? AppLocalizations.of(
                                          context,
                                        )!.noMoreTransactions
                                      : '',
                                  style: AppTextStyles.regular(
                                    fontSize: 12,
                                    color: AppColors.secondaryText(context),
                                  ),
                                ),
                              ),
                      );
                    }
                    final transaction = data[index];
                    return TransactionItem(
                      transaction: transaction,
                      currency: wallet.currency,
                    );
                  },
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(
              child: Text(
                '${AppLocalizations.of(context)!.failedToLoadTransactions}: $error',
              ),
            ),
          );
        },
      ),
    );
  }
}
