import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeFormatter {
  static String formatTimeOfDay(TimeOfDay timeOfDay, BuildContext context) {
    final now = DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
    
    final format = MediaQuery.of(context).alwaysUse24HourFormat 
        ? DateFormat.Hm() 
        : DateFormat.jm();
        
    return format.format(dateTime);
  }
}
