

import '../../../di.dart';
import '../data/remote/RemoteDatasource.dart';
import '../data/remote/RemoteDatasourceImpl.dart';
import '../data/repositoryImpl/RepositoryImpl.dart';
import '../domain/Repository/Repository.dart';
import '../domain/useCases/BookSelectedSeatsUseCase.dart';
import '../domain/useCases/ExtendSeatBookingTimerUseCase.dart';
import '../domain/useCases/GetSeatLayoutUseCase.dart';
import '../presentation/bloc/SeatLayoutBloc.dart';

Future<void> injectSeatLayout() async {
  // BLoC
  getIt.registerLazySingleton(() => SeatLayoutBloc(getIt(),getIt(),getIt()));

  // // Use cases
  getIt.registerLazySingleton(() => GetSeatLayoutUseCase(getIt()));
  getIt.registerLazySingleton(() => BookSelectedSeatsUseCase(getIt()));
  getIt.registerLazySingleton(() => ExtendSeatBookingTimerUseCase(getIt()));



  //
  // // Repository
  getIt.registerLazySingleton<SeatLayoutRepository>(
    () => SeatLayoutRepositoryImpl(getIt<SeatLayoutRemoteDatasource>()),
  );
  //
  // // Data sources
  getIt.registerLazySingleton<SeatLayoutRemoteDatasource>( () => SeatLayoutRemoteDatasourceImpl(getIt()),);

}
