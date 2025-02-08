import 'package:novocinema/src/Payment/data/repositories/repo.dart';

import '../models/payment_response.dart';

class CreatePayment {
  final PaymentRepository repository;

  CreatePayment(this.repository);

  Future<PaymentResponse> call(String reservationId) {
    return repository.createPayment(reservationId);
  }
}
