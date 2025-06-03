import 'package:intl/intl.dart';

extension DoubleExtensions on double {
  String toPriceFormat({required String currency}) {
    final formatter = NumberFormat.currency(
      locale: _getLocaleForCurrency(currency),
      symbol: _getSymbolForCurrency(currency),
      decimalDigits: 2,
    );
    return formatter.format(this);
  }

  String _getLocaleForCurrency(String currency) {
    switch (currency) {
      case 'USD':
        return 'en_US';
      case 'EUR':
        return 'de_DE';
      case 'GBP':
        return 'en_GB';
      default:
        return 'en_US';
    }
  }

  String _getSymbolForCurrency(String currency) {
    switch (currency) {
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      case 'GBP':
        return '£';
      default:
        return '\$';
    }
  }
}
