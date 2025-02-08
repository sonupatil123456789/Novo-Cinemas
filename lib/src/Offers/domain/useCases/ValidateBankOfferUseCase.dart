

import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';

class ValidateBankOfferUseCase implements UseCase<DataResult<bool>, Map<String,dynamic>> {
  final OffersRepository repository ;
  ValidateBankOfferUseCase(this.repository);

  @override
  Future<DataResult<bool>> call(Map<String,dynamic> data)async  {
   return await repository.validateBankOffer(data);
  }




}
