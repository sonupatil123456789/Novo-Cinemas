
import '../../../di.dart';
import '../data/remote/RemoteDatasource.dart';
import '../data/remote/RemoteDatasourceImpl.dart';
import '../data/repositoryImpl/RepositoryImpl.dart';
import '../domain/Repository/Repository.dart';
import '../domain/useCases/GetAllMoviesWithSessionUseCase.dart';
import '../presentation/bloc/ShowTimeBloc.dart';

Future<void> injectShowTime() async {
  // BLoC
  getIt.registerLazySingleton(() => ShowTimeBloc(getIt()));

  // // Use cases
  getIt.registerLazySingleton(() => GetAllMoviesWithSessionUseCase(getIt()));

  //
  // // Repository
  getIt.registerLazySingleton<ShowTimeRepository>(
    () => ShowTimeRepositoryImpl(getIt<ShowTimeRemoteDatasource>()),
  );
  //
  // // Data sources
  getIt.registerLazySingleton<ShowTimeRemoteDatasource>(
        () => ShowTimeRemoteDatasourceImpl(getIt()),
  );

}


