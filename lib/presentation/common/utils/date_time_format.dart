// ignore_for_file: avoid_print

import 'package:intl/intl.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';

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

  // static DateTime parseTime(String hour, String minute, {DateTime? dateTime}) {
  //   final now = dateTime ?? DateTime.now();
  //   final hourInt = exttractHour(hour);
  //   final minuteInt = extractMinutes(minute);

  //   return DateTime(now.year, now.month, now.day, hourInt, minuteInt);
  // }

  static DateTime parseTime(String hour, String minute, {DateTime? dateTime}) {
    final now = dateTime ?? DateTime.now();
    final hourInt = extractHour(hour);
    final minuteInt = extractMinutes(minute);

    // If the hour is 12 PM, we need to ensure it is correctly treated as noon.
    // This means that if the hour is "12" and the period is "AM", we must adjust the hour.
    final isPm = hour.contains('PM');
    final adjustedHourInt = (hourInt == 12 && !isPm) ? 0 : hourInt;

    final finalHour =
        isPm && adjustedHourInt < 12 ? adjustedHourInt + 12 : adjustedHourInt;

    return DateTime(now.year, now.month, now.day, finalHour, minuteInt);
  }

  static int extractHour(String timeStr) {
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

  static getHour({required int timestamp}) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String formattedHour = DateFormat('hh a').format(dateTime);
    print("Formatted Hour: $formattedHour");

    return formattedHour;
  }

  static getMinute({required int timestamp}) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String formattedMinute = DateFormat('mm').format(dateTime);
    print("Formatted Minute: $formattedMinute");

    return "$formattedMinute Min";
  }

  static getShiftTime(InputEmptyOrNot startHour, InputEmptyOrNot startMin,
      InputEmptyOrNot endHour, InputEmptyOrNot endMin) {
    if (startHour.isValid() &&
        startMin.isValid() &&
        endHour.isValid() &&
        endMin.isValid()) {
      DateTime formattedStartTime = CustomDateTimeFormat.parseTime(
          startHour.getValue() ?? "", startMin.getValue() ?? "");
      DateTime formattedEndTime = CustomDateTimeFormat.parseTime(
          endHour.getValue() ?? "", endMin.getValue() ?? "");

      final format = DateFormat('hh:mm a');
      final startTime = format.format(formattedStartTime);
      final endTime = format.format(formattedEndTime);

      return "$startTime to $endTime";
    } else {
      return "";
    }
  }
}
