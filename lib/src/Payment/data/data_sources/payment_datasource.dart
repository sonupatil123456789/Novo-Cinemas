import 'package:novocinema/src/Payment/data/models/payment_response.dart';

abstract interface class PaymentRemoteDataSource {
  Future<PaymentResponse> createPayment(String reservationId);
}
