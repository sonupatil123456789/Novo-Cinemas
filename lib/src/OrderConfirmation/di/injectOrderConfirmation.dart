





import 'package:novocinema/src/OrderConfirmation/data/remote/RemoteDatasourceImpl.dart';
import 'package:novocinema/src/OrderConfirmation/data/repositoryImpl/RepositoryImpl.dart';
import 'package:novocinema/src/OrderConfirmation/domain/useCases/CancelFAndBUseCase.dart';

import '../../../di.dart';
import '../data/remote/RemoteDatasource.dart';
import '../domain/Repository/Repository.dart';
import '../domain/useCases/ApplyVoucherCodeUseCase.dart';
import '../domain/useCases/CompleteOrderUseCase.dart';
import '../domain/useCases/RemoveVoucherCodeUseCase.dart';
import '../presentation/bloc/OrderConfirmationBloc.dart';

Future<void> injectOrderConfirmation() async {
  // BLoC
  getIt.registerLazySingleton(() => OrderConfirmationBloc(getIt(),getIt(), getIt(),getIt()));

  // Use cases
  getIt.registerLazySingleton(() => CompleteOrderUseCase(getIt()));
  getIt.registerLazySingleton(() => CancelFAndBUseCase(getIt()));
  getIt.registerLazySingleton(() => ApplyVoucherCodeUseCase(getIt()));
  getIt.registerLazySingleton(() => RemoveVoucherCodeUseCase(getIt()));


  // Repository
  getIt.registerLazySingleton<OrderConfirmationRepository>(
    () => OrderConfirmationRepositoryImpl(getIt<OrderConfirmationRemoteDatasource>()),
  );

  // Data sources
  getIt.registerLazySingleton<OrderConfirmationRemoteDatasource>( () => OrderConfirmationRemoteDatasourceImpl(getIt()),);

}
