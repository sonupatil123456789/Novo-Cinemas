import 'package:novocinema/core/resources/DataResult.dart';
import 'package:novocinema/src/Cinema-Experience/domain/models/cinemaexperience.dart';

abstract interface class CinemaExperienceRepository {
  Future<DataResult<List<CinemaExperienceModel>>> getCinemaExperiences(
      int? cinemaId);
}
