import 'package:flutter/material.dart';
import 'package:zoozitest/base/extensions/double_extensions.dart';
import 'package:zoozitest/base/utils/app_text_styles.dart';
import 'package:zoozitest/base/utils/colors.dart';
import 'package:zoozitest/l10n/app_localizations.dart';
import 'package:zoozitest/models/wallet.dart';

class WalletCardView extends StatelessWidget {
  final Wallet wallet;
  final Widget? child;
  const WalletCardView({super.key, required this.wallet, this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.background(context),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.teal.shade100,
                  child: Text(
                    wallet.currency.substring(0, 1),
                    style: AppTextStyles.medium(
                      fontSize: 18,
                      color: Colors.teal.shade700,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        wallet.currency,
                        style: AppTextStyles.medium(fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${AppLocalizations.of(context)!.balanceLabel}: ${wallet.balance.toPriceFormat()}',
                        style: AppTextStyles.regular(
                          fontSize: 14,
                          color: AppColors.secondaryText(context),
                        ),
                      ),
                    ],
                  ),
                ),
                if (child == null) ...[
                  const SizedBox(width: 16),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey.shade400,
                  ),
                ],
              ],
            ),
            if (child != null) ...[const SizedBox(height: 16), child!],
          ],
        ),
      ),
    );
  }
}
