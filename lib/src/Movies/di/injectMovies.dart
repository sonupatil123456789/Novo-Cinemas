
import 'package:novocinema/src/Movies/domain/useCases/GetAllFilterMoviesUseCase.dart';
import 'package:novocinema/src/Movies/presentation/bloc/MoviesBloc.dart';
import '../../../di.dart';
import '../data/remote/RemoteDatasource.dart';
import '../data/remote/RemoteDatasourceImpl.dart';
import '../data/repositoryImpl/RepositoryImpl.dart';
import '../domain/Repository/Repository.dart';

Future<void> injectMovies() async {
  // BLoC
  getIt.registerLazySingleton(() => MoviesBloc(getIt()));

  // // Use cases
  getIt.registerLazySingleton(() => GetAllFilterMoviesUseCase(getIt()));

  //
  // // Repository
  getIt.registerLazySingleton<MoviesRepository>(
    () => MoviesRepositoryImpl(getIt<MoviesRemoteDatasource>()),
  );
  //
  // // Data sources
  getIt.registerLazySingleton<MoviesRemoteDatasource>(
        () => MoviesRemoteDatasourceImpl(getIt()),
  );

}
