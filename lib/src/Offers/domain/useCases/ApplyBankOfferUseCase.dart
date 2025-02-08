


import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';

class ApplyBankOfferUseCase implements UseCase<DataResult<Map<String,dynamic>>, Map<String,dynamic>> {
  final OffersRepository repository ;
  ApplyBankOfferUseCase(this.repository);

  @override
  Future<DataResult<Map<String, dynamic>>> call(Map<String, dynamic> data) async {
    return repository.applyBankOffer(data);
  }




}

