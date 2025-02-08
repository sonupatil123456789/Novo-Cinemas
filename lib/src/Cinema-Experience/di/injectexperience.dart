import 'package:novocinema/di.dart';
import 'package:novocinema/src/Cinema-Experience/data/remote/remoteDataSource.dart';
import 'package:novocinema/src/Cinema-Experience/data/remote/remoteDataSourceImpl.dart';
import 'package:novocinema/src/Cinema-Experience/data/repositoryImpl/repositoryimpl.dart';
import 'package:novocinema/src/Cinema-Experience/domain/Usecases/GetCinemaExperiencesUseCase.dart';
import 'package:novocinema/src/Cinema-Experience/domain/repository/repository.dart';
import 'package:novocinema/src/Cinema-Experience/presentation/bloc/cinema_experience_bloc.dart';

Future<void> injectCinemaExperience() async {
  // BLoC
  getIt.registerLazySingleton(() => CinemaExperienceBloc(getIt()));

  // Use cases
  getIt.registerLazySingleton(() => GetCinemaExperiencesUseCase(getIt()));

  // Repository
  getIt.registerLazySingleton<CinemaExperienceRepository>(() =>
      CinemaExperienceRepositoryImpl(
          getIt<CinemaExperienceRemoteDatasource>()));

  // Data sources
  getIt.registerLazySingleton<CinemaExperienceRemoteDatasource>(
    () => CinemaExperienceRemoteDatasourceImpl(getIt()),
  );
}
