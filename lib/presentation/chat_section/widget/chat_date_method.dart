import 'package:intl/intl.dart';

class ChatDateMethod {
  bool isSameDay(DateTime date1, DateTime date2) {
    return DateFormat('dd MMMM, yyyy').format(date1) ==
        DateFormat('dd MMMM, yyyy').format(date2);
  }

  bool isToday(DateTime date) {
    return DateFormat('dd MMMM, yyyy').format(date) ==
        DateFormat('dd MMMM, yyyy').format(DateTime.now());
  }

  String formatAsYesterday(DateTime date) {
    DateTime currentDate = DateTime.now();
    DateTime previousDate = currentDate.subtract(Duration(days: 1));
    DateTime dateToCheck = date;
    if (dateToCheck.year == previousDate.year &&
        dateToCheck.month == previousDate.month &&
        dateToCheck.day == previousDate.day) {
      return 'Yesterday';
    }
    return DateFormat('dd MMMM, yyyy').format(date);
  }
}
