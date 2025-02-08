//
// import 'dart:core';
//
// import 'package:novocinema/core/resources/AppException.dart';
//
// sealed class DataResult<T> {
//   const DataResult._();
//
//   factory DataResult.success(T data) = Success;
//   factory DataResult.error(AppException exception, T data) = Error;
// }
//
// // Define a subclass for the Success case
// class Success<T> extends DataResult<T> {
//   final T data;
//   const Success(this.data) : super._();
// }
//
// // Define a subclass for the Error case
// class Error<T> extends DataResult<T> {
//   final AppException exception;
//   final T? data;
//   const Error(this.exception , this.data) : super._();
// }
//
//




import 'dart:core';

import 'package:novocinema/core/resources/AppException.dart';

sealed class DataResult<T> {
  const DataResult._();

  factory DataResult.success(T data) = Success;
  factory DataResult.error(AppException exception, T? data) = Error;
}

// Define a subclass for the Success case
class Success<T> extends DataResult<T> {
  final T data;
  const Success(this.data) : super._();
}

// Define a subclass for the Error case
class Error<T> extends DataResult<T> {
  final AppException exception;
  final T? data;
  const Error(this.exception , this.data) : super._();
}


