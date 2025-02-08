import 'package:novocinema/src/Payment/data/data_sources/payment_datasource.dart';
import 'package:novocinema/src/Payment/data/repositories/repo.dart';

import '../models/payment_response.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource remoteDataSource;

  PaymentRepositoryImpl(this.remoteDataSource);

  @override
  Future<PaymentResponse> createPayment(String reservationId) {
    return remoteDataSource.createPayment(reservationId);
  }
}
