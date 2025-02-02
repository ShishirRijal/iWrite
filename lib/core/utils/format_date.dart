import 'package:intl/intl.dart';

String formatDateBydMMMYYYY(DateTime date) {
  // Jan 24, 2025
  return DateFormat.yMMMd().format(date);
}
