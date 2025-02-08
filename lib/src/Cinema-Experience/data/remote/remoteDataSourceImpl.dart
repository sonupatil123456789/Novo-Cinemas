import 'package:novocinema/src/Cinema-Experience/data/dto/cinemaexpdto.dart';
import 'package:novocinema/src/Cinema-Experience/data/remote/remoteDataSource.dart';

import '../../../../core/constants/ApiUrlConstants.dart';
import '../../../../core/resources/ResponseData.dart';
import '../../../../core/restServices/BaseApi.dart';
import '../../../../core/utils/Logger.dart';

class CinemaExperienceRemoteDatasourceImpl implements CinemaExperienceRemoteDatasource {
  final BaseApi responseData;

  CinemaExperienceRemoteDatasourceImpl(this.responseData);

  @override
  Future<ResponseData<List<CinemaExperienceDto>>> getCinemaExperiences(int? cinemaId) async {
    try {
      final response = await responseData.get(
        cinemaId == null
            ? ApiUrlConstants.cineexperiences
            : "${ApiUrlConstants.cineexperiences}?cinema_id=$cinemaId",
        null,
        null,
      );

      ResponseData<List<CinemaExperienceDto>> dtoResponse =
          ResponseData<List<CinemaExperienceDto>>.fromJson(
        response.data,
        (value) => (value as List<dynamic>)
            .map((toElement) => CinemaExperienceDto.fromJson(toElement))
            .toList(),
      );

      Logger.customLogData("getCinemaExperiences", dtoResponse.toString());
      return dtoResponse;
    } catch (error) {
      rethrow;
    }
  }
}
