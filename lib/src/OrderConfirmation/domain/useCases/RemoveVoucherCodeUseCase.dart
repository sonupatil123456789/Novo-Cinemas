
import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';



class RemoveVoucherCodeUseCase implements UseCase<DataResult<Map<String,dynamic>>, String> {
  final OrderConfirmationRepository repository ;
  RemoveVoucherCodeUseCase(this.repository);

  @override
  Future<DataResult<Map<String, dynamic>>> call(String reservationId) async {
    return await repository.removeVoucherCode(reservationId);
  }




}