
import 'package:novocinema/src/Search/data/remote/RemoteDatasource.dart';
import 'package:novocinema/src/Search/data/remote/RemoteDatasourceImpl.dart';
import 'package:novocinema/src/Search/data/repositoryImpl/RepositoryImpl.dart';
import 'package:novocinema/src/Search/domain/Repository/Repository.dart';
import 'package:novocinema/src/Search/domain/useCases/SearchUseCase.dart';
import 'package:novocinema/src/Search/presentation/bloc/SearchBloc.dart';
import '../../../di.dart';

Future<void> injectSearch() async {
  // BLoC
  getIt.registerFactory(() => SearchBloc(getIt()));

  // // Use cases
  getIt.registerLazySingleton(() => SearchUseCase(getIt()));


  // Repository
  getIt.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(getIt<SearchRemoteDatasource>()),
  );

  // Data sources
  getIt.registerLazySingleton<SearchRemoteDatasource>(
        () => SearchRemoteDatasourceImpl(getIt()),
  );

}
