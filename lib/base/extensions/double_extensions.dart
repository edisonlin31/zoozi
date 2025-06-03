import 'package:intl/intl.dart';

extension DoubleExtensions on double {
  String toPriceFormat({String currencySymbol = '\$'}) {
    final formatter = NumberFormat.currency(
      symbol: currencySymbol,
      decimalDigits: 2,
    );
    return formatter.format(this);
  }
}
