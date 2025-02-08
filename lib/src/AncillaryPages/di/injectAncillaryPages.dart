import 'package:novocinema/src/AncillaryPages/domain/Repository/Repository.dart';
import 'package:novocinema/src/AncillaryPages/domain/useCases/AncillarPagesUseCase.dart';
import 'package:novocinema/src/AncillaryPages/presentation/bloc/AncillaryPagesBloc.dart';
import 'package:novocinema/src/GiftCard/data/remote/RemoteDatasource.dart';
import 'package:novocinema/src/GiftCard/data/remote/RemoteDatasourceImpl.dart';
import 'package:novocinema/src/GiftCard/data/repositoryImpl/RepositoryImpl.dart';
import 'package:novocinema/src/GiftCard/domain/Repository/Repository.dart';
import 'package:novocinema/src/GiftCard/domain/useCases/BuyGiftCardUseCase.dart';
import 'package:novocinema/src/GiftCard/domain/useCases/GetAllGiftCardUseCase.dart';
import 'package:novocinema/src/GiftCard/domain/useCases/SendReceivedGiftCardUseCase.dart';
import 'package:novocinema/src/GiftCard/presentation/bloc/GiftCardBloc.dart';

import '../../../di.dart';
import '../data/remote/RemoteDatasource.dart';
import '../data/remote/RemoteDatasourceImpl.dart';
import '../data/repositoryImpl/RepositoryImpl.dart';

Future<void> injectAncillaryPages() async {
  // BLoC
  getIt.registerLazySingleton(() {
    return AncillaryPagesBloc(getIt());
  });

  // Use cases
  getIt.registerLazySingleton(() => AncillaryPagesUseCase(getIt()));

  // Repository
  getIt.registerLazySingleton<AncillaryPagesRepository>(
        () => AncillaryPagesRepositoryImpl(getIt<AncillaryPagesRemoteDatasource>()),
  );

  // Data sources
  getIt.registerLazySingleton<AncillaryPagesRemoteDatasource>(
        () => AncillaryPagesRemoteDatasourceImpl(getIt()),
  );
}
