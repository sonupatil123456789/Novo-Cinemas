import 'package:novocinema/core/resources/DataResult.dart';
import 'package:novocinema/core/resources/UseCase.dart';
import 'package:novocinema/src/Location/domain/Repository/Repository.dart';
import 'package:novocinema/src/Location/domain/models/cityModel.dart';

class GetAllCitiesUseCase
    implements UseCase<DataResult<List<CityModel>>, EmptyParams> {
  final LocationRepository repository;

  GetAllCitiesUseCase(this.repository);

  @override
  Future<DataResult<List<CityModel>>> call(EmptyParams params) async {
    return await repository.getCities();
  }
}
