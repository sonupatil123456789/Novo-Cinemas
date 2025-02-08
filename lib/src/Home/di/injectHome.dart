import 'package:novocinema/src/Home/data/remote/RemoteDatasource.dart';
import 'package:novocinema/src/Home/data/remote/RemoteDatasourceImpl.dart';
import 'package:novocinema/src/Home/data/repositoryImpl/RepositoryImpl.dart';
import 'package:novocinema/src/Home/domain/Repository/Repository.dart';
import 'package:novocinema/src/Home/domain/useCases/GetAllBannersUseCase.dart';
import 'package:novocinema/src/Home/domain/useCases/QuickBookUseCase.dart';
import 'package:novocinema/src/Home/presentation/bloc/HomeBloc.dart';
import '../../../di.dart';

Future<void> injectHome() async {
  // BLoC
  getIt.registerLazySingleton(() => HomeBloc(getIt(),getIt()));

  // // Use cases
  getIt.registerLazySingleton(() => GetAllBannersUseCase(getIt()));
  getIt.registerLazySingleton(() => QuickBookUseCase(getIt()));

  //
  // // Repository
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(getIt<HomeRemoteDatasource>()),
  );
  //
  // // Data sources
  getIt.registerLazySingleton<HomeRemoteDatasource>(
        () => HomeRemoteDatasourceImpl(getIt()),
  );

}
