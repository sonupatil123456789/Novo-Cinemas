import 'package:novocinema/src/Payment/data/models/payment_response.dart';
import 'package:novocinema/src/Payment/data/repositories/repo.dart';

class CreatePayment {
  final PaymentRepository repository;

  CreatePayment(this.repository);

  Future<PaymentResponse> call(String reservationId) {
    return repository.createPayment(reservationId);
  }
}
