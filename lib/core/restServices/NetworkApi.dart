import 'dart:async';
import 'package:dio/dio.dart';
import 'package:novocinema/core/constants/DatabaseKeyConstants.dart';
import 'package:novocinema/core/resources/SeassionManager.dart';
import 'package:novocinema/core/restServices/BaseApi.dart';
import '../../di.dart';
import '../../src/Auth/data/dto/UserAuthDto.dart';
import '../../src/Auth/data/local/LocalDatasource.dart';
import '../../src/Auth/domain/models/UserAuthModel.dart';
import '../resources/ExceptionHandler.dart';

class NetworkApi extends BaseApi{

  UserAuthModel user = const UserAuthModel();


  late  final Dio _dio;

  NetworkApi(this._dio);



  @override
  Future<Response> get(String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  ) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(headers: await _buildHeaders(headers ?? <String,dynamic>{})),
      );
      return _handleResponse(response);
    } on Exception catch (e , stack) {
      throw ExceptionHandler.handleNetworkException(e , stack);
    }
  }

  @override
  Future<Response> post(String url,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  ) async {
    try {
      final response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: await _buildHeaders(headers ?? <String,dynamic>{})),
      );
      return _handleResponse(response);
    } on Exception catch (e , stack) {
      throw ExceptionHandler.handleNetworkException(e , stack);
    }
  }


  @override
  Future<Response> put(String url,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  ) async {
    try {
      final response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: await _buildHeaders(headers ?? <String,dynamic>{})),
      );
      return _handleResponse(response);
    } on Exception catch (e , stack) {
      throw ExceptionHandler.handleNetworkException(e , stack);
    }
  }

  @override
  Future<Response> delete(String url,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  ) async {
    try {
      final response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: await _buildHeaders(headers ?? <String,dynamic>{})),
      );
      return _handleResponse(response);
    } on Exception catch (e , stack) {
      throw ExceptionHandler.handleNetworkException(e , stack);
    }
  }

  Future<Map<String, dynamic>> _buildHeaders(Map<String, dynamic> headers) async {
    final Map<String, dynamic> updatedHeaders = {};

    final session = getIt<SeassionManager>();
    final token = await session.getAccessToken(TOKEN);

    updatedHeaders.addAll(headers);

    if (token != null && token!.isNotEmpty) {
      updatedHeaders['Authorization'] = 'Bearer $token';
    }
    // print("============================$updatedHeaders========================");

    return updatedHeaders;
  }

  Response _handleResponse(Response? response) {

    if (response == null) {
      throw Exception('No response received from the server');
    }

    final statusCode = response.statusCode;
    final responseData = response.data;

    if (statusCode == null) {
      throw Exception('Response status code is null');
    }

    if (statusCode >= 200 && statusCode < 300 && responseData != null && responseData['success']==true ) {
      return response;
    }
    else {
      throw Exception(responseData['message'] ??'Some error occured during fetching data');
    }
  }
}

