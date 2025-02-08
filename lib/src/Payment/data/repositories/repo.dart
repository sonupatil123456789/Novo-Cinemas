import 'package:novocinema/src/Payment/data/models/payment_response.dart';

abstract class PaymentRepository {
  Future<PaymentResponse> createPayment(String reservationId);
}
