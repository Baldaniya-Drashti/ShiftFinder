import 'package:flutter/material.dart';

extension TimeExtension on TimeOfDay {
  String get formatTimeOfDay {
    // String hours = hour.toString().padLeft(2, '0');
    /// Converts 24-hour to 12-hour format
    String hours = hourOfPeriod.toString().padLeft(2, '0');
    String minutes = minute.toString().padLeft(2, '0');
    return '${hours}h ${minutes}min';
  }
}
