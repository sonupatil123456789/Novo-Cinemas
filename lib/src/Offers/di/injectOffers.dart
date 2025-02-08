

import 'package:novocinema/src/Offers/domain/useCases/RemoveAppliedBankOffersUseCase.dart';
import 'package:novocinema/src/Offers/presentation/bloc/OffersBloc.dart';
import '../../../di.dart';
import '../../SeatLayout/presentation/bloc/SeatLayoutBloc.dart';
import '../data/remote/RemoteDatasource.dart';
import '../data/remote/RemoteDatasourceImpl.dart';
import '../data/repositoryImpl/RepositoryImpl.dart';
import '../domain/Repository/Repository.dart';
import '../../SeatLayout/domain/useCases/BookSelectedSeatsUseCase.dart';
import '../domain/useCases/ApplyBankOfferUseCase.dart';
import '../domain/useCases/ApplyDiscountCodeOffersUseCase.dart';
import '../domain/useCases/CancelBookedSelectedSeatsUseCase.dart';
import '../domain/useCases/GetAllOffersUseCase.dart';
import '../domain/useCases/RemoveDiscountCodeOffersUseCase.dart';
import '../domain/useCases/ValidateBankOfferUseCase.dart';

Future<void> injectOffers() async {
  // BLoC
  getIt.registerLazySingleton(() {
    return OffersBloc(getIt(),getIt(),getIt(),getIt(),getIt(),getIt(),getIt());
  });


  // Use cases
  getIt.registerLazySingleton(() => GetAllOffersUseCase(getIt()));
  getIt.registerLazySingleton(() => CancelBookedSelectedSeatsUseCase(getIt()));
  getIt.registerLazySingleton(() => ValidateBankOfferUseCase(getIt()));
  getIt.registerLazySingleton(() => ApplyBankOfferUseCase(getIt()));
  getIt.registerLazySingleton(() => RemoveAppliedBankOffersUseCase(getIt()));
  getIt.registerLazySingleton(() => ApplyDiscountCodeOffersUseCase(getIt()));
  getIt.registerLazySingleton(() => RemoveDiscountCodeOffersUseCase(getIt()));



  // Repository
  getIt.registerLazySingleton<OffersRepository>(
    () => OffersRepositoryImpl(getIt<OffersRemoteDatasource>()),
  );

  // Data sources
  getIt.registerLazySingleton<OffersRemoteDatasource>( () => OffersRemoteDatasourceImpl(getIt()),);

}