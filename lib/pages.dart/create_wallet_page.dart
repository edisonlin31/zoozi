import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoozitest/base/utils/colors.dart';
import 'package:zoozitest/base/widgets/app_button.dart';
import 'package:zoozitest/base/widgets/decorations.dart/form_decorations.dart';
import 'package:zoozitest/controllers/wallets_controller.dart';
import 'package:zoozitest/l10n/app_localizations.dart';
import 'package:zoozitest/models/requests/wallet_request.dart';
import 'package:zoozitest/repositories/wallet_repository.dart';

@RoutePage()
class CreateWalletPage extends ConsumerStatefulWidget {
  const CreateWalletPage({super.key});

  @override
  ConsumerState<CreateWalletPage> createState() => _CreateWalletPageState();
}

class _CreateWalletPageState extends ConsumerState<CreateWalletPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;

  final List<String> _currencies = ['USD', 'EUR', 'GBP'];

  _onSubmit() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;
      final currency = values['currency'] ?? 'USD';
      final initialBalance =
          double.tryParse(values['initialBalance'] ?? '0') ?? 0;

      setState(() {
        _isLoading = true;
      });

      try {
        final walletRepository = ref.read(walletsRepositoryProvider);
        await walletRepository.createWallet(
          WalletRequest(currency: currency, initialBalance: initialBalance),
        );
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.walletCreatedSuccess),
            duration: const Duration(seconds: 3),
          ),
        );
        ref.read(walletsController.notifier).getWallets();
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
          _isLoading = false; // Stop loading
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.createWallet)),
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
                          Text(AppLocalizations.of(context)!.currency),
                          const SizedBox(height: 8),
                          FormBuilderDropdown(
                            name: 'currency',
                            decoration: FormDecorations.defaultDecoration(
                              context: context,
                            ).copyWith(prefixIcon: const Icon(Icons.money)),
                            items: _currencies
                                .map(
                                  (currency) => DropdownMenuItem(
                                    value: currency,
                                    child: Text(currency),
                                  ),
                                )
                                .toList(),
                            validator: FormBuilderValidators.required(
                              errorText: AppLocalizations.of(
                                context,
                              )!.currencyRequired,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(AppLocalizations.of(context)!.initialBalance),
                          const SizedBox(height: 8),
                          FormBuilderTextField(
                            name: 'initialBalance',
                            decoration:
                                FormDecorations.defaultDecoration(
                                  context: context,
                                ).copyWith(
                                  prefixIcon: const Icon(
                                    Icons.account_balance_wallet,
                                  ),
                                ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {
                                final parsedValue = double.tryParse(value);
                                if (parsedValue == null) {
                                  return AppLocalizations.of(
                                    context,
                                  )!.balanceNumberValidation;
                                }
                              }
                              return null; // No error if blank
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppButton(
                    onPressed: _onSubmit,
                    text: AppLocalizations.of(context)!.createWallet,
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
