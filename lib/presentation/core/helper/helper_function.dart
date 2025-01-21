import 'package:flutter/material.dart';

String getIndustryText(int type) {
  switch (type) {
    case 1:
      return "Healthcare";
    case 2:
      return "Pharmacy";
    case 3:
      return "Dental";
    case 4:
      return "Hospitality";
    case 5:
      return "Ophthalmology";
    default:
  }
  return "";
}

String formatTimeOfDay(TimeOfDay timeOfDay) {
  String hours = timeOfDay.hour.toString().padLeft(2, '0');
  String minutes = timeOfDay.minute.toString().padLeft(2, '0');
  return '$hours h $minutes min';
}