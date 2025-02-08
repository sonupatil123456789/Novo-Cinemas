






import 'package:novocinema/src/Tickets/data/remote/RemoteDatasourceImpl.dart';
import 'package:novocinema/src/Tickets/data/repositoryImpl/RepositoryImpl.dart';

import '../../../di.dart';
import '../data/remote/RemoteDatasource.dart';
import '../data/remote/RemoteDatasourceImpl.dart';
import '../data/repositoryImpl/RepositoryImpl.dart';
import '../domain/Repository/Repository.dart';
import '../domain/useCases/GetReservationHistoryDetailsUseCase.dart';
import '../presentation/bloc/BookingHistoryBloc.dart';

Future<void> injectBookingHistory() async {
  // // BLoC
  getIt.registerLazySingleton(() => BookingHistoryBloc(getIt()));
  //
  // Use cases
  getIt.registerLazySingleton(() => GetReservationHistoryDetailsUseCase(getIt()));


  // Repository
  getIt.registerLazySingleton<BookingHistoryRepository>(
    () => BookingHistoryRepositoryImpl(getIt<BookingHistoryDatasource>()),
  );

  // Data sources
  getIt.registerLazySingleton<BookingHistoryDatasource>( () => BookingHistoryDatasourceImpl(getIt()),);

}
