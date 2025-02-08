import 'package:novocinema/src/Location/data/dto/CinemaLocationDto.dart';
import 'package:novocinema/src/Location/data/dto/cityDto.dart';

import '../../../../core/resources/ResponseData.dart';

abstract interface class LocationRemoteDatasource {
  Future<ResponseData<List<CinemaLocationDto>>> getCinemaLocations(
      Map<String, dynamic> query);
  Future<ResponseData<List<CityDto>>> getCities();
}
