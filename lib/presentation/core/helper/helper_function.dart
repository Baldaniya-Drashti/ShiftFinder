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
  return '${hours}h ${minutes}min';
}

String getShiftScheduleId(List<dynamic> list) {
  final listId = [];

  if (list.contains("Morning")) listId.add(1);
  if (list.contains("Evening")) listId.add(2);
  if (list.contains("Night")) listId.add(3);
  if (list.contains("Weekends")) listId.add(4);
  if (list.contains("Weekdays")) listId.add(5);

  return listId.join(",");
}

List<String> getShiftScheduleFromId(String string) {
  final list = string.split(",").toList();
  final List<String> newList = [];
  if (list.contains("1")) newList.add("Morning");
  if (list.contains("2")) newList.add("Evening");
  if (list.contains("3")) newList.add("Night");
  if (list.contains("4")) newList.add("Weekends");
  if (list.contains("5")) newList.add("Weekdays");
  return newList;
}
