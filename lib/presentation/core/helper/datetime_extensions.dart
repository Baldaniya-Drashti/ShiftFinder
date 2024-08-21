import 'package:intl/intl.dart';

extension DatetimeExtensions on DateTime {
  String get formattedString {
    return DateFormat('dd MMM, yyyy').format(this);
  }
}
