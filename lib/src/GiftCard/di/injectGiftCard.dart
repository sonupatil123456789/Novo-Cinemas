import 'package:novocinema/src/GiftCard/data/remote/RemoteDatasource.dart';
import 'package:novocinema/src/GiftCard/data/remote/RemoteDatasourceImpl.dart';
import 'package:novocinema/src/GiftCard/data/repositoryImpl/RepositoryImpl.dart';
import 'package:novocinema/src/GiftCard/domain/Repository/Repository.dart';
import 'package:novocinema/src/GiftCard/domain/useCases/BuyGiftCardUseCase.dart';
import 'package:novocinema/src/GiftCard/domain/useCases/GetAllGiftCardUseCase.dart';
import 'package:novocinema/src/GiftCard/domain/useCases/SendReceivedGiftCardUseCase.dart';
import 'package:novocinema/src/GiftCard/domain/useCases/TopUpGiftCardUseCase.dart';
import 'package:novocinema/src/GiftCard/presentation/bloc/GiftCardBloc.dart';

import '../../../di.dart';
import '../domain/useCases/GetGiftCardBalanceUseCase.dart';

Future<void> injectGiftCard() async {
  // BLoC
  getIt.registerLazySingleton(() {
    return GiftCardBloc(getIt(), getIt(), getIt(), getIt(), getIt());
  });

  // Use cases
  getIt.registerLazySingleton(() => GetAllGiftCardUseCase(getIt()));
  getIt.registerLazySingleton(() => BuyGiftCardUseCase(getIt()));
  getIt.registerLazySingleton(() => GetGiftCardBalanceUseCase(getIt()));
  getIt.registerLazySingleton(() => SendReceivedGiftCardUseCase(getIt()));
  getIt.registerLazySingleton(() => TopUpGiftCardUseCase(getIt()));

  // Repository
  getIt.registerLazySingleton<GiftCardRepository>(
    () => GiftCardRepositoryImpl(getIt<GiftCardRemoteDatasource>()),
  );

  // Data sources
  getIt.registerLazySingleton<GiftCardRemoteDatasource>(
    () => GiftCardRemoteDatasourceImpl(getIt()),
  );
}
