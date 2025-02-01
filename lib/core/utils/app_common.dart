import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppCommon{
  static Future<dynamic> selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Default to current date
      firstDate: DateTime(1900),   // Earliest date selectable
      lastDate: DateTime(2101),    // Latest date selectable
    );

    return selectedDate;
  }

  static String formatDate(DateTime date) {

    return DateFormat('dd-MMM-yyyy').format(date);
  }
}