import 'package:novocinema/di.dart';
import 'package:novocinema/src/Payment/data/data_sources/payment_datasource.dart';
import 'package:novocinema/src/Payment/data/repositories/payment_repository.dart';
import 'package:novocinema/src/Payment/data/repositories/paymentrepoimpl.dart';

import '../data/repositories/repo.dart';
import '../domain/usecases/create_payment.dart';
import '../presentation/blocs/payment_bloc.dart';

Future<void> injectPayment() async {
  // BLoC
  getIt.registerLazySingleton(() => PaymentBloc(getIt()));

  // Use cases
  getIt.registerLazySingleton(() => CreatePayment(getIt()));

  // Repository
  getIt.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryImpl(getIt<PaymentRemoteDataSource>()),
  );

  // Data sources
  getIt.registerLazySingleton<PaymentRemoteDataSource>(
    () => PaymentRemoteDataSourceImpl(getIt()),
  );
}
