


import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class PaymentGatewayService {
  BuildContext context;
  GlobalKey<NavigatorState> navigatorKey;
  PaymentGatewayService(this.context, this.navigatorKey);

  StreamSubscription<Map>? _streamSubscription;

  static const MethodChannel _platformChannel = MethodChannel('com.novo.cinemas/payment_gateway_integration');

  Future<void> initPaymentGatewayService() async {
    try {
      final Map<String, dynamic> dataToSend = {
        'merchantId': '', // your merchant id
        'merchantName': '', // your merchant name
        'merchantUrl': '', // your merchant url
        'region': '', // your region
      };

      final result = await _platformChannel.invokeMethod('initPaymentGatewayService', dataToSend);

      print("Data ======>>>> ${result}");

    } on PlatformException catch (e) {
      throw PlatformException(message: e.message, code: e.code);
    }
  }

  Future<void> updateSession() async {
    try {
      final Map<String, dynamic> paymentDetails = {
        'nameOnCard': '', // Cardholder's name
        'number': '', // Card number
        'securityCode': '', // CVV code
        'month': '', // Expiry month
        'year': '', // Expiry year
        'sessionId': '', // Session ID
        'amount': '1.97', // Amount to be processed
        'currency': 'USD', // Currency code
        'orderId': 'your-order-id', // Order ID
        'apiVersion': 61, // API version
      };

      final result = await _platformChannel.invokeMethod('updateSession', paymentDetails);

      print("Data ======>>>> ${result}");

    } on PlatformException catch (e) {
      throw PlatformException(message: e.message, code: e.code ,details: e.details, stacktrace: e.stacktrace);
    }
  }






}