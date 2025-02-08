import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:novocinema/core/resources/AppException.dart';
import 'package:novocinema/core/resources/enums.dart';

String convertMinutesToHours(int minutes) {
  int hours = minutes ~/ 60; // Get the integer division for hours
  int remainingMinutes = minutes % 60; // Get the remainder for minutes

  return '${hours}h ${remainingMinutes}m';
}

String getDay(String inputDate) {
  if (inputDate.isEmpty) {
    throw AppException(message: 'Invalid data send', errorCode: ErrorCode.UNKNOWN_ERROR);
  } else {
    DateTime parsedDate = DateTime.parse(inputDate);
    String day = DateFormat('dd').format(parsedDate);
    return day;
  }
}

String getMonth(String inputDate) {
  if (inputDate.isEmpty) {
    throw AppException(message: 'Invalid data send', errorCode: ErrorCode.UNKNOWN_ERROR);
  } else {
    DateTime parsedDate = DateTime.parse(inputDate);
    String month = DateFormat('MMMM').format(parsedDate);
    return month;
  }
}

String getYear(String inputDate) {
  if (inputDate.isEmpty) {
    throw AppException(message: 'Invalid data send', errorCode: ErrorCode.UNKNOWN_ERROR);
  } else {
    DateTime parsedDate = DateTime.parse(inputDate);
    String month = DateFormat('y').format(parsedDate);
    return month;
  }
}

String getWeek(String inputDate) {
  if (inputDate.isEmpty) {
    throw AppException(message: 'Invalid date send', errorCode: ErrorCode.UNKNOWN_ERROR);
  } else {
    DateTime parsedDate = DateTime.parse(inputDate);
    String weekday = DateFormat('EEEE').format(parsedDate);
    return weekday;
  }
}

String formatTime(String isoDateString) {
  try {
    // Parse the ISO8601 date string to a DateTime object
    DateTime dateTime = DateTime.parse(isoDateString);
    String formattedTime = DateFormat('h:mm a').format(dateTime);
    return formattedTime;
  } catch (e) {
    // Return a fallback or error message if parsing fails
    return "Invalid date";
  }
}

String formatDateTime(String isoDateString) {
  try {
    // Parse the ISO8601 date string to a DateTime object
    DateTime dateTime = DateTime.parse(isoDateString);
    String formattedDateTime = DateFormat('dd-MM-yyyy HH:mm').format(dateTime);
    return formattedDateTime;
  } catch (e) {
    // Return a fallback or error message if parsing fails
    return "Invalid date";
  }
}

bool isDateBeforeDays(String dateStr, int days) {
  // Parse the input date string
  DateTime inputDate = DateTime.parse(dateStr);

  // Get current date and subtract the specified days
  DateTime comparisonDate = DateTime.now().subtract(Duration(days: days));

  // Compare if input date is before the comparison date
  return inputDate.isBefore(comparisonDate);
}

bool isDateTimeBeforeToday(String dateTimeStr) {
  // Parse the input date string
  DateTime inputDateTime = DateTime.parse(dateTimeStr);
  // Get current date time
  DateTime comparisonDate = DateTime.now();

  // Compare if input date is before the comparison date
  return inputDateTime.isBefore(comparisonDate);
}
