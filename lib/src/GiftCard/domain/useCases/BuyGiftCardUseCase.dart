import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';
import '../models/AllGiftCardModel.dart';

class BuyGiftCardUseCase implements UseCase<DataResult<String>, Map<String, dynamic>> {
  final GiftCardRepository repository;

  BuyGiftCardUseCase(this.repository);

  @override
  Future<DataResult<String>> call(Map<String, dynamic> data) async {
    return await repository.buyGiftCard(data);
  }
}