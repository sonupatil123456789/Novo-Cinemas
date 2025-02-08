


import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';

class CancelFAndBUseCase implements UseCase<DataResult<dynamic>, String>{

  final OrderConfirmationRepository repository ;
  CancelFAndBUseCase(this.repository);

  @override
  Future<DataResult<dynamic>> call(String reservationId)async  {
    return await repository.cancelFAndB(reservationId);
  }

}


