// ignore_for_file: avoid_print

import 'package:flutter/services.dart';

class CountryCodeRemovingFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Process the new input value
    String cleanedValue = removeCountryCode(newValue.text);

    // Return the new text value with the custom formatting applied
    return newValue.copyWith(
      text: cleanedValue,
      selection: (newValue.text.length > 10)
          ? TextSelection.collapsed(offset: cleanedValue.length)
          : null,
    );
  }

  String removeCountryCode(String phoneNumber) {
    // Remove any leading or trailing spaces
    String trimmedPhoneNumber = phoneNumber.trim();

    // Remove any non-digit characters
    String digitsOnly = trimmedPhoneNumber.replaceAll(RegExp(r'\D'), '');

    // If the phone number starts with a country code indicator
    if (digitsOnly.length > 10 && digitsOnly.startsWith("1")) {
      // Remove the country code by extracting the local part
      // For simplicity, assuming that local part starts after the first 1 or 2 digits (common for country codes)
      return digitsOnly.substring(digitsOnly.length - 10);
    }

    // Return the original digits only phone number if no country code is detected
    return digitsOnly;
  }
}
