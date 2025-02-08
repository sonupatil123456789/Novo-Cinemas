
import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';



class RemoveDiscountCodeOffersUseCase implements UseCase<DataResult<Map<String,dynamic>>, String> {
  final OffersRepository repository ;
  RemoveDiscountCodeOffersUseCase(this.repository);

  @override
  Future<DataResult<Map<String, dynamic>>> call(String reservationId) async {
    return await repository.removeDiscountCodeOffers(reservationId);
  }




}