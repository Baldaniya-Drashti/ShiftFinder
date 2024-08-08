// ignore_for_file: avoid_print

import 'package:intl/intl.dart';

class CustomDateTimeFormat {
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;

    final formattedHours = hours.toString().padLeft(2, '0');
    final formattedMinutes = minutes.toString().padLeft(2, '0');

    final totalDuration =
        '${formattedHours}h ${formattedMinutes}min'.replaceAll('-', '');
    print("timeDifference ---> $totalDuration");

    return totalDuration;
  }

  static DateTime parseTime(String hour, String minute, {DateTime? dateTime}) {
    final now = dateTime ?? DateTime.now();
    final hourInt = exttractHour(hour);
    final minuteInt = extractMinutes(minute);

    return DateTime(now.year, now.month, now.day, hourInt, minuteInt);
  }

  static int exttractHour(String timeStr) {
    final formatter = DateFormat('hh a');
    return formatter.parse(timeStr).hour;
  }

  static int extractMinutes(String timeStr) {
    final match = RegExp(r'(\d+) Min').firstMatch(timeStr);
    return match != null ? int.parse(match.group(1)!) : 0;
  }

  static int extractUnpaidBreak(String timeStr) {
    final match = RegExp(r'(\d+) Minutes').firstMatch(timeStr);
    return match != null ? int.parse(match.group(1)!) : 0;
  }
}
