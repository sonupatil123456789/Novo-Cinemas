import 'package:novocinema/src/Location/domain/models/CinemaLocationModel.dart';
import 'package:novocinema/src/Location/domain/models/cityModel.dart';
import 'package:novocinema/src/Tickets/domain/models/ReservationDetailsModel.dart';

import '../../../../core/resources/DataResult.dart';

abstract interface class LocationRepository {
  Future<DataResult<List<CinemaLocationModel>>> getCinemaLocations(
      {String? cityId});

  Future<DataResult<List<CityModel>>> getCities();
}
