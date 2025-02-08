import 'package:novocinema/src/GiftCard/domain/Repository/Repository.dart';
import 'package:novocinema/src/GiftCard/domain/models/AllGiftCardModel.dart';
import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';

class GetAllGiftCardUseCase implements UseCase<DataResult<AllGiftCardModel>, EmptyParams> {
  final GiftCardRepository repository;

  GetAllGiftCardUseCase(this.repository);

  @override
  Future<DataResult<AllGiftCardModel>> call(EmptyParams params) async {
    return await repository.getAllGiftCards();
  }
}
