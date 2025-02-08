import 'package:novocinema/src/GiftCard/domain/models/SendReceivedGiftCardModel.dart';

import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';

class SendReceivedGiftCardUseCase
    implements UseCase<DataResult<SendReceivedGiftCardModel>, EmptyParams> {
  final GiftCardRepository repository;

  SendReceivedGiftCardUseCase(this.repository);

  @override
  Future<DataResult<SendReceivedGiftCardModel>> call(params) async {
    return await repository.sendReceivedGiftCard();
  }
}
