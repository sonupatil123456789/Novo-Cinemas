
//
import 'package:novocinema/src/F&B/data/remote/RemoteDatasourceImpl.dart';
import 'package:novocinema/src/F&B/data/repositoryImpl/RepositoryImpl.dart';
import 'package:novocinema/src/F&B/domain/useCases/CompleteFoodAndBevRageUseCase.dart';
import 'package:novocinema/src/F&B/presentation/bloc/F&BBloc.dart';

import '../../../di.dart';
import '../../Offers/presentation/bloc/OffersBloc.dart';
import '../data/remote/RemoteDatasource.dart';
import '../domain/Repository/Repository.dart';
import '../domain/useCases/GetAllFoodAndBevRageUseCase.dart';

Future<void> injectFAndB() async {
  // BLoC
  getIt.registerLazySingleton(() {
    return FAndBBloc(getIt(),getIt());
  });

  // Use cases
  getIt.registerLazySingleton(() => GetAllFoodAndBevRageUseCase(getIt()));
  getIt.registerLazySingleton(() => CompleteFoodAndBevRageUseCase(getIt()));



  // Repository
  getIt.registerLazySingleton<FAndBRepository>(
    () => FAndBRepositoryImpl(getIt<FAndBRemoteDatasource>()),
  );

  // Data sources
  getIt.registerLazySingleton<FAndBRemoteDatasource>( () => FAndBRemoteDatasourceImpl(getIt()),);

}
