
import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';

class CompleteOrderUseCase implements UseCase<DataResult<Map<String,dynamic>>, String>{

  final OrderConfirmationRepository repository ;
  CompleteOrderUseCase(this.repository);

  @override
  Future<DataResult<Map<String, dynamic>>> call(String reservationId)async  {
     return await repository.completeOrder(reservationId);
  }

}


