import 'package:novocinema/src/Location/data/remote/RemoteDatasourceImpl.dart';
import 'package:novocinema/src/Location/data/repositoryImpl/RepositoryImpl.dart';
import 'package:novocinema/src/Location/domain/useCases/CityUseCase.dart';
import '../../../di.dart';
import '../data/remote/RemoteDatasource.dart';
import '../domain/Repository/Repository.dart';
import '../domain/useCases/CinemaLocationUseCase.dart';
import '../presentation/bloc/LocationBloc.dart';

Future<void> injectLocation() async {
  // BLoC
  getIt.registerLazySingleton(
      () => LocationBloc(getIt(), getIt())); // Added CityBloc dependency

  // Use cases
  getIt.registerLazySingleton(() => GetAllCinemaLocationUseCase(getIt()));
  getIt.registerLazySingleton(
      () => GetAllCitiesUseCase(getIt())); // Register city use case

  // Repository
  getIt.registerLazySingleton<LocationRepository>(
      () => LocationRepositoryImpl(getIt<LocationRemoteDatasource>()));

  // Data sources
  getIt.registerLazySingleton<LocationRemoteDatasource>(
    () => LocationRemoteDatasourceImpl(getIt()),
  );
}
