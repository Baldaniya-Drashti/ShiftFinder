import 'package:intl/intl.dart';

extension DatetimeExtensions on DateTime {
  String get formattedString {
    return DateFormat('d MMM, yyyy').format(this);
  }
}
