import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:novocinema/core/constants/DatabaseKeyConstants.dart';
import 'package:novocinema/core/resources/SeassionManager.dart';
import 'package:novocinema/core/restServices/BaseApi.dart';
import 'package:novocinema/core/restServices/NetworkApi.dart';
import 'package:novocinema/di.dart';
import 'package:novocinema/src/Payment/data/data_sources/payment_datasource.dart';
import '../models/payment_response.dart';

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  late final BaseApi responseData;

  PaymentRemoteDataSourceImpl(this.responseData);

  @override
  Future<PaymentResponse> createPayment(String reservationId) async {
    final session = getIt<SeassionManager>();
    final token = await session.getAccessToken(TOKEN);
    Response response = await responseData.post(
        '/payment/cybersource/create-order-payment-request-unified-checkout-app',
        {'reservation_id': reservationId},
        null,
        null);

    if (response.statusCode == 200) {
      return PaymentResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to create payment');
    }
  }
}
