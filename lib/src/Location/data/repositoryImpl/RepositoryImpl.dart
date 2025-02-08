import 'package:novocinema/core/resources/DataResult.dart';
import 'package:novocinema/src/Location/data/dto/CinemaLocationDto.dart';
import 'package:novocinema/src/Location/data/dto/cityDto.dart';
import 'package:novocinema/src/Location/data/remote/RemoteDatasource.dart';
import 'package:novocinema/src/Location/domain/Repository/Repository.dart';
import 'package:novocinema/src/Location/domain/models/CinemaLocationModel.dart';
import 'package:novocinema/src/Location/domain/models/cityModel.dart';

import '../../../../core/resources/AppException.dart';
import '../../../../core/utils/Logger.dart';

class LocationRepositoryImpl implements LocationRepository {
  late final LocationRemoteDatasource remoteDatasource;

  LocationRepositoryImpl(this.remoteDatasource);

  @override
  Future<DataResult<List<CinemaLocationModel>>> getCinemaLocations(
      {String? cityId}) async {
    try {
      final cinemaLocationResponse = await remoteDatasource.getCinemaLocations({
        "cityId": cityId,
      });

      if (cinemaLocationResponse.success == true) {
        List<CinemaLocationModel> domainData = cinemaLocationResponse.data
            .map((toElement) => CinemaLocationDto.toDomainModel(toElement))
            .toList();
        return DataResult.success(domainData);
      }

      throw Exception(cinemaLocationResponse.message);
    } on AppException catch (error, stack) {
      Logger.customLogError("getCinemaLocations", error, stack);
      return DataResult.error(error, null);
    }
  }

  Future<DataResult<List<CityModel>>> getCities() async {
    try {
      final cityResponse = await remoteDatasource.getCities();

      if (cityResponse.success == true) {
        List<CityModel> domainData = cityResponse.data
            .map((toElement) => CityDto.toDomainModel(toElement))
            .toList();
        return DataResult.success(domainData);
      }

      throw Exception(cityResponse.message);
    } on AppException catch (error, stack) {
      Logger.customLogError("getCities", error, stack);
      return DataResult.error(error, null);
    }
  }
}
