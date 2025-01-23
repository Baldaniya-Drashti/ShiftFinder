import 'package:flutter/material.dart';

extension TimeExtension on TimeOfDay {
  String get formatTimeOfDay {
    String hours = hour.toString().padLeft(2, '0');
    String minutes = minute.toString().padLeft(2, '0');
    return '${hours}h ${minutes}min';
  }
}
