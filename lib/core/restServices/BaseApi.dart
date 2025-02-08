



import 'package:dio/dio.dart';

abstract class BaseApi {

  Future<Response> get(String url,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      );

  Future<Response> post(String url,
      dynamic data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      );

  Future<Response> put(String url,
      dynamic data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      );

  Future<Response> delete(String url,
      dynamic data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      );

}
