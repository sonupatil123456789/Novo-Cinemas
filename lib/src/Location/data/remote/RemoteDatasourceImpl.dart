import 'package:novocinema/src/Location/data/dto/CinemaLocationDto.dart';
import 'package:novocinema/src/Location/data/dto/cityDto.dart';

import '../../../../core/constants/ApiUrlConstants.dart';
import '../../../../core/resources/ResponseData.dart';
import '../../../../core/restServices/BaseApi.dart';
import '../../../../core/utils/Logger.dart';
import 'RemoteDatasource.dart';

class LocationRemoteDatasourceImpl implements LocationRemoteDatasource {
  late final BaseApi responseData;

  LocationRemoteDatasourceImpl(this.responseData);

  @override
  Future<ResponseData<List<CinemaLocationDto>>> getCinemaLocations(
      Map<String, dynamic> query) async {
    try {
      final response =
          await responseData.get(ApiUrlConstants.cinemas, query, null);
      ResponseData<List<CinemaLocationDto>> dtoResponse =
          ResponseData<List<CinemaLocationDto>>.fromJson(response.data,
              (value) {
        return (value as List<dynamic>)
            .map((toElement) => CinemaLocationDto.fromJson(toElement))
            .toList();
      });
      Logger.customLogData("getCinemaLocations", dtoResponse.toString());
      return dtoResponse;
    } on Exception catch (error) {
      rethrow;
    }
  }

  @override
  Future<ResponseData<List<CityDto>>> getCities() async {
    try {
      final response = await responseData.get(ApiUrlConstants.cities, null, null);
      ResponseData<List<CityDto>> dtoResponse =ResponseData<List<CityDto>>.fromJson(
        response.data,
        (value) {
          return (value as List<dynamic>).map((toElement) => CityDto.fromJson(toElement))
              .toList();
        },
      );
      Logger.customLogData("getAllCities", dtoResponse.toString());
      return dtoResponse;
    } on Exception catch (error) {
      rethrow;
    }
  }
}
