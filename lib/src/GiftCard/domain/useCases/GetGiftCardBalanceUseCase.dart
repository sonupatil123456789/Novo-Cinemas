import 'package:novocinema/src/GiftCard/domain/models/GetCardBalanceModel.dart';

import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';

class GetGiftCardBalanceUseCase implements UseCase<DataResult<GetCardBalanceModel>, String> {
  final GiftCardRepository repository;

  GetGiftCardBalanceUseCase(this.repository);

  @override
  Future<DataResult<GetCardBalanceModel>> call(String params) async {
    return await repository.getGiftCardBalance(params);
  }
}