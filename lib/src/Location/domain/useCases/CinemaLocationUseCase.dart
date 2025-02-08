import 'package:novocinema/src/Location/domain/Repository/Repository.dart';
import 'package:novocinema/src/Location/domain/models/CinemaLocationModel.dart';

import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';

class GetAllCinemaLocationUseCase
    implements UseCase<DataResult<List<CinemaLocationModel>>, String?> {
  final LocationRepository repository;

  GetAllCinemaLocationUseCase(this.repository);

  @override
  Future<DataResult<List<CinemaLocationModel>>> call(String? cityId) async {
    return await repository.getCinemaLocations(cityId: cityId);
  }
}
