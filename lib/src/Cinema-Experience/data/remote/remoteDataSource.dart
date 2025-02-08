import 'package:novocinema/src/Cinema-Experience/data/dto/cinemaexpdto.dart';

import '../../../../core/resources/ResponseData.dart';

abstract interface class CinemaExperienceRemoteDatasource {
  Future<ResponseData<List<CinemaExperienceDto>>> getCinemaExperiences(
      int? cinemaId);
}
