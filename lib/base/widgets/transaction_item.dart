import 'package:flutter/material.dart';
import 'package:zoozitest/base/extensions/double_extensions.dart';
import 'package:zoozitest/base/utils/app_text_styles.dart';
import 'package:zoozitest/base/utils/colors.dart';
import 'package:zoozitest/l10n/app_localizations.dart';
import 'package:zoozitest/models/enums/transaction_type.dart';
import 'package:zoozitest/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  const TransactionItem({required this.transaction, super.key});

  @override
  Widget build(BuildContext context) {
    final formattedTimestamp = DateFormat(
      'dd-MM-yyyy hh:mm a',
    ).format(transaction.timestamp.toLocal());
    final typeColor = transaction.type == TransactionType.deposit
        ? Colors.green
        : Colors.red;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background(context),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: transaction.type == TransactionType.deposit
                  ? Colors.green.withAlpha(20)
                  : Colors.red.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: Icon(
              transaction.type == TransactionType.deposit
                  ? Icons.arrow_upward
                  : Icons.arrow_downward,
              color: transaction.type == TransactionType.deposit
                  ? Colors.green
                  : Colors.red,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '#${transaction.id}',
                      style: AppTextStyles.semibold(
                        fontSize: 16,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(
                      formattedTimestamp,
                      style: AppTextStyles.regular(
                        fontSize: 12,
                        color: AppColors.secondaryText(context),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  transaction.amount.toPriceFormat(),
                  style: AppTextStyles.medium(fontSize: 16, color: typeColor),
                ),
                if (transaction.description != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    '${AppLocalizations.of(context)!.descriptionLabel}: ${transaction.description}',
                    style: AppTextStyles.regular(
                      fontSize: 12,
                      color: AppColors.secondaryText(context),
                    ),
                  ),
                ],
                if (transaction.referenceId != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    '${AppLocalizations.of(context)!.referenceLabel}: ${transaction.referenceId}',
                    style: AppTextStyles.regular(
                      fontSize: 12,
                      color: AppColors.secondaryText(context),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
