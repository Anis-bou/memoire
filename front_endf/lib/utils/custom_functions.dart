import 'package:intl/intl.dart';

String formatCurrency(num amount, Set<String?> set, {int decimalCount = 0}) {
  final formatCurrency =
      new NumberFormat.simpleCurrency(decimalDigits: decimalCount);
  return formatCurrency.format(amount);
}
