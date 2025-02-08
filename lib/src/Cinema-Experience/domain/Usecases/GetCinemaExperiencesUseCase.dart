import 'package:novocinema/core/resources/DataResult.dart';
import 'package:novocinema/src/Cinema-Experience/domain/models/cinemaexperience.dart';
import 'package:novocinema/src/Cinema-Experience/domain/repository/repository.dart';

class GetCinemaExperiencesUseCase {
  final CinemaExperienceRepository repository;

  GetCinemaExperiencesUseCase(this.repository);

  Future<DataResult<List<CinemaExperienceModel>>> call(int? cinemaId) async {
    return await repository.getCinemaExperiences(cinemaId);
  }
}
