






import '../../../di.dart';
import '../data/remote/RemoteDatasource.dart';
import '../data/remote/RemoteDatasourceImpl.dart';
import '../data/repositoryImpl/RepositoryImpl.dart';
import '../domain/Repository/Repository.dart';
import '../domain/useCases/GetAllUpcomingBookingsUseCase.dart';
import '../domain/useCases/GetUpcomingBookingsDetailsUseCase.dart';
import '../presentation/bloc/DirectF&BBloc.dart';

Future<void> injectDirectFAndB() async {
  // // BLoC
  getIt.registerLazySingleton(() => DirectFAndBBloc(getIt(),getIt()));
  //
  // Use cases
  getIt.registerLazySingleton(() => GetAllUpcomingBookingsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetUpcomingBookingsDetailsUseCase(getIt()));


  // Repository
  getIt.registerLazySingleton<DirectFAndBRepository>(
    () => DirectFAndBRepositoryImpl(getIt<DirectFAndBDatasource>()),
  );

  // Data sources
  getIt.registerLazySingleton<DirectFAndBDatasource>( () => DirectFAndBDatasourceImpl(getIt()),);

}
