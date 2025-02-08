

import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';

class GetAvailableDatesUseCase implements UseCase<DataResult<Map<String,dynamic>>, String> {
  final MovieDetailsRepository repository ;
  GetAvailableDatesUseCase(this.repository);

  @override
  Future<DataResult<Map<String, dynamic>>> call(String movieId)async {
    return await repository.getAvailableDates(movieId);
  }


}