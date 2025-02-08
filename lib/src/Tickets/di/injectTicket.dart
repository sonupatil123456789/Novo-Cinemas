






import 'package:novocinema/src/Tickets/data/remote/RemoteDatasourceImpl.dart';
import 'package:novocinema/src/Tickets/data/repositoryImpl/RepositoryImpl.dart';

import '../../../di.dart';
import '../data/remote/RemoteDatasource.dart';
import '../domain/Repository/Repository.dart';
import '../domain/useCases/GetReservationDetailsUseCase.dart';
import '../presentation/bloc/TicketBloc.dart';

Future<void> injectTicket() async {
  // BLoC
  getIt.registerLazySingleton(() => TicketBloc(getIt()));

  // Use cases
  getIt.registerLazySingleton(() => GetReservationDetailsUseCase(getIt()));


  // Repository
  getIt.registerLazySingleton<TicketRepository>(
    () => TicketRepositoryImpl(getIt<TicketRemoteDatasource>()),
  );

  // Data sources
  getIt.registerLazySingleton<TicketRemoteDatasource>( () => TicketRemoteDatasourceImpl(getIt()),);

}
