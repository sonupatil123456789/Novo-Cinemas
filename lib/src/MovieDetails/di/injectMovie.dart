
import '../../../di.dart';
import '../data/remote/RemoteDatasource.dart';
import '../data/remote/RemoteDatasourceImpl.dart';
import '../data/repositoryImpl/RepositoryImpl.dart';
import '../domain/Repository/Repository.dart';
import '../domain/useCases/CreateSessionUseCase.dart';
import '../domain/useCases/GetAvailableDatesUseCase.dart';
import '../domain/useCases/GetMovieDetailsUseCase.dart';
import '../domain/useCases/LikeDislikeUseCase.dart';
import '../presentation/bloc/MovieDetailsBloc.dart';

Future<void> injectMovieDetails() async {
  // BLoC
  getIt.registerLazySingleton(() => MovieDetailsBloc(getIt(),getIt(),getIt(),getIt()));

  // // Use cases
  getIt.registerLazySingleton(() => GetMovieDetailsUseCase(getIt()));
  getIt.registerLazySingleton(() => CreateSessionUseCase(getIt()));
  getIt.registerLazySingleton(() => LikeDislikeUseCase(getIt()));
  getIt.registerLazySingleton(() => GetAvailableDatesUseCase(getIt()));



  //
  // // Repository
  getIt.registerLazySingleton<MovieDetailsRepository>(
    () => MovieDetailsRepositoryImpl(getIt<MovieDetailsRemoteDatasource>()),
  );
  //
  // // Data sources
  getIt.registerLazySingleton<MovieDetailsRemoteDatasource>(
        () => MovieDetailsRemoteDatasourceImpl(getIt()),
  );

}


