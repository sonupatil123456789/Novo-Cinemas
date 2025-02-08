import 'package:novocinema/src/GiftCard/domain/models/AllGiftCardModel.dart';
import 'package:novocinema/src/GiftCard/domain/models/GetCardBalanceModel.dart';
import 'package:novocinema/src/GiftCard/domain/models/SendReceivedGiftCardModel.dart';

import '../../../../core/resources/DataResult.dart';

abstract interface class GiftCardRepository {
  Future<DataResult<AllGiftCardModel>> getAllGiftCards();

  Future<DataResult<String>> buyGiftCard(Map<String,dynamic> data);

  Future<DataResult<GetCardBalanceModel>> getGiftCardBalance(String cardNumber);

  Future<DataResult<SendReceivedGiftCardModel>> sendReceivedGiftCard();

  Future<DataResult<String>> topUpGiftCard(Map<String,dynamic> data);

}
