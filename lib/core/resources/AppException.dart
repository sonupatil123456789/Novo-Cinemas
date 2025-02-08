import 'package:novocinema/core/resources/enums.dart';

class AppException implements Exception {
  final String message;
  final Exception? error;
  final ErrorCode errorCode;
  final StackTrace? stack ;

  AppException({
    required this.message,
     this.error,
    required this.errorCode,
    this.stack
  });

  @override
  String toString() {
    return 'AppException: ( message : $message , exceptionDetail : ${error.toString()} , exceptionType : ${error.runtimeType.toString()} , errorCode : $errorCode , stackTrace : $stack ) ';
  }
}
