import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:novocinema/core/resources/enums.dart';
import 'AppException.dart';

class ExceptionHandler {
  static AppException handleDatabaseException(Exception error, StackTrace stackTrace) {
    return AppException(
        message: 'An unexpected error occurred with the local database.',
        errorCode: ErrorCode.DATABASE_ERROR,
        error: error,
        stack: stackTrace);
  }

  static AppException handleNetworkException(Exception error, StackTrace stackTrace) {
    if (error is DioException) {
      final statusCode = error.response?.statusCode;

      String? respMessage = error.response?.data != null? error.response?.data['message'].toString()  : null;


      // String message = error.message != null
      //     ? error.message!
      //     : 'An unexpected error occurred. Please try again.';

      return AppException(
          message: _getDisplayMessageForStatusCode(statusCode, respMessage),
          errorCode: _getErrorCodeForStatusCode(statusCode),
          error: error,
          stack: stackTrace);
    }
    if (error is SocketException) {
      return AppException(
          message:
              'The connection timed out. Please check your internet and try again.',
          errorCode: ErrorCode.NO_INTERNET_CONNECTION,
          error: error,
          stack: stackTrace);
    } else {
      return AppException(
          message: error.toString(),
          errorCode: ErrorCode.UNKNOWN_ERROR,
          error: error,
          stack: stackTrace);
    }
  }

  static AppException handleFirebaseAuthException(
      FirebaseAuthException error, StackTrace stackTrace) {
    return AppException(
        message:error.message ?? 'An unexpected error occurred. Please try again.',
        errorCode: ErrorCode.FIREBASE_ERROR,
        error: error,
        stack: stackTrace);
  }

  static String _getDisplayMessageForStatusCode(
      int? statusCode, String? message) {
    switch (statusCode) {
      case 400:
        return  message ?? "[$statusCode] Invalid data. Please enter correct data";
      case 401:
        return  message ?? "[$statusCode] Authentication failed. Unauthorized user";
      case 403:
        return message ?? "[$statusCode] You don't have permission to access this resource.";
      case 404:
        return  message  ?? "[$statusCode] The requested resource was not found.";
      case 409:
        return message ?? "[$statusCode] A conflict occurred with the current state of the resource.";
      case 500:
      case 501:
      case 502:
      case 503:
      case 504:
      case 505:
        return message?? "[$statusCode] A server error occurred. Please try again later.";
      default:
        return message ??"[$statusCode] ${'An unexpected error occurred. Please try again.'}";
      // return "[$statusCode] ${kDebugMode == true ? message : 'An unexpected error occurred. Please try again.'}";
    }
  }

  static ErrorCode _getErrorCodeForStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return ErrorCode.BAD_REQUEST;
      case 401:
        return ErrorCode.UNAUTORISED_ERROR;
      case 403:
        return ErrorCode.FORBIDDEN_ERROR;
      case 404:
        return ErrorCode.NOT_FOUND_ERROR;
      case 409:
        return ErrorCode.CONFLICT_ERROR;
      case 500:
      case 501:
      case 502:
      case 503:
      case 504:
      case 505:
        return ErrorCode.INTERNAL_SERVER_ERROR;
      default:
        return ErrorCode.API_ERROR;
    }
  }

  static String removeStatusCode(String input) {
    final regex = RegExp(r"\[\d+\]\s*");
    return input.replaceAll(regex, "").trim();
  }
}
