import 'package:novocinema/core/resources/AppException.dart';
import 'package:novocinema/core/resources/enums.dart';
import 'package:novocinema/src/Cinema-Experience/data/dto/cinemaexpdto.dart';
import 'package:novocinema/src/Cinema-Experience/data/remote/remoteDataSource.dart';
import 'package:novocinema/src/Cinema-Experience/domain/models/cinemaexperience.dart';
import 'package:novocinema/src/Cinema-Experience/domain/repository/repository.dart';

import '../../../../core/resources/DataResult.dart';
import '../../../../core/utils/Logger.dart';

class CinemaExperienceRepositoryImpl implements CinemaExperienceRepository {
  final CinemaExperienceRemoteDatasource remoteDatasource;

  CinemaExperienceRepositoryImpl(this.remoteDatasource);

  @override
  Future<DataResult<List<CinemaExperienceModel>>> getCinemaExperiences(
      int? cinemaId) async {
    try {
      final experienceResponse =
          await remoteDatasource.getCinemaExperiences(cinemaId);

      if (experienceResponse.success == true) {
        List<CinemaExperienceModel> domainData = experienceResponse.data
            .map((toElement) => CinemaExperienceDto.toDomainModel(toElement))
            .toList();
        return DataResult.success(domainData);
      }

      throw Exception(experienceResponse.message);
    } catch (error, stack) {
      Logger.customLogError("getCinemaExperiences", error, stack);
      return DataResult.error(
          AppException(message: "", errorCode: ErrorCode.API_ERROR), null);
    }
  }
}
