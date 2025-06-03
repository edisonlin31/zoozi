import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoozitest/base/extensions/double_extensions.dart';
import 'package:zoozitest/base/utils/app_text_styles.dart';
import 'package:zoozitest/base/utils/colors.dart';
import 'package:zoozitest/base/widgets/app_button.dart';
import 'package:zoozitest/base/widgets/decorations.dart/form_decorations.dart';
import 'package:zoozitest/controllers/transactions_controller.dart';
import 'package:zoozitest/controllers/wallet_detail_controller.dart';
import 'package:zoozitest/l10n/app_localizations.dart';
import 'package:zoozitest/models/enums/transaction_type.dart';
import 'package:zoozitest/models/requests/transaction_request.dart';
import 'package:zoozitest/repositories/wallet_repository.dart';

@RoutePage()
class CreateTransactionPage extends ConsumerStatefulWidget {
  final int walletId;
  final double balance;
  final TransactionType transactionType;

  const CreateTransactionPage({
    super.key,
    required this.walletId,
    required this.balance,
    required this.transactionType,
  });

  @override
  ConsumerState<CreateTransactionPage> createState() =>
      _CreateTransactionPageState();
}

class _CreateTransactionPageState extends ConsumerState<CreateTransactionPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;

  _onSubmit() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;
      final amount = double.tryParse(values['amount'] ?? '0') ?? 0;
      final description = values['description'];
      final referenceId = values['referenceId'];

      setState(() {
        _isLoading = true;
      });

      try {
        final walletRepository = ref.read(walletsRepositoryProvider);
        final transactionRequest = TransactionRequest(
          amount: amount,
          description: description,
          referenceId: referenceId,
        );

        if (widget.transactionType == TransactionType.deposit) {
          await walletRepository.createDepositTransaction(
            widget.walletId,
            transactionRequest,
          );
        } else {
          await walletRepository.createWithdrawalTransaction(
            widget.walletId,
            transactionRequest,
          );
        }
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.transactionType == TransactionType.deposit
                  ? AppLocalizations.of(context)!.depositSuccess
                  : AppLocalizations.of(context)!.withdrawalSuccess,
            ),
            duration: const Duration(seconds: 3),
          ),
        );
        // Refresh transactions, if manually insert transaction from response will break the pagination index
        ref
            .read(transactionsController(widget.walletId).notifier)
            .getTransactions(refresh: true, showLoading: true);
        ref
            .read(walletDetailController(widget.walletId).notifier)
            .getWalletDetail();
        context.router.back();
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            duration: const Duration(seconds: 3),
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.transactionType == TransactionType.deposit
              ? AppLocalizations.of(context)!.createDeposit
              : AppLocalizations.of(context)!.createWithdrawal,
        ),
      ),
      body: PopScope(
        canPop: !_isLoading,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.background(context),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: FormBuilder(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.transactionType ==
                              TransactionType.withdrawal) ...[
                            Text(
                              '${AppLocalizations.of(context)!.availableBalance}: ${widget.balance.toPriceFormat()}',
                              style: AppTextStyles.medium(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                          Text(AppLocalizations.of(context)!.amount),
                          const SizedBox(height: 8),
                          FormBuilderTextField(
                            name: 'amount',
                            decoration:
                                FormDecorations.defaultDecoration(
                                  context: context,
                                ).copyWith(
                                  prefixIcon: const Icon(Icons.attach_money),
                                ),
                            keyboardType: TextInputType.number,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                errorText: AppLocalizations.of(
                                  context,
                                )!.amountRequired,
                              ),
                              FormBuilderValidators.min(
                                0.01,
                                errorText: AppLocalizations.of(
                                  context,
                                )!.amountPositive,
                              ),
                              (value) {
                                final amount =
                                    double.tryParse(value ?? '0') ?? 0;
                                if (widget.transactionType ==
                                        TransactionType.withdrawal &&
                                    amount > widget.balance) {
                                  return AppLocalizations.of(
                                    context,
                                  )!.insufficientFunds;
                                }
                                return null;
                              },
                            ]),
                          ),
                          const SizedBox(height: 16),
                          Text(AppLocalizations.of(context)!.description),
                          const SizedBox(height: 8),
                          FormBuilderTextField(
                            name: 'description',
                            decoration:
                                FormDecorations.defaultDecoration(
                                  context: context,
                                ).copyWith(
                                  prefixIcon: const Icon(Icons.description),
                                ),
                          ),
                          const SizedBox(height: 16),
                          Text(AppLocalizations.of(context)!.referenceId),
                          const SizedBox(height: 8),
                          FormBuilderTextField(
                            name: 'referenceId',
                            decoration: FormDecorations.defaultDecoration(
                              context: context,
                            ).copyWith(prefixIcon: const Icon(Icons.tag)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppButton(
                    onPressed: _onSubmit,
                    text: widget.transactionType == TransactionType.deposit
                        ? AppLocalizations.of(context)!.createDeposit
                        : AppLocalizations.of(context)!.createWithdrawal,
                    isLoading: _isLoading,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
