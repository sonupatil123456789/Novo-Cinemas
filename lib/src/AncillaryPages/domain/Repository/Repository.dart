import 'package:novocinema/src/AncillaryPages/domain/models/AncillaryPagesModel.dart';
import 'package:novocinema/src/GiftCard/domain/models/AllGiftCardModel.dart';
import 'package:novocinema/src/GiftCard/domain/models/GetCardBalanceModel.dart';
import 'package:novocinema/src/GiftCard/domain/models/SendReceivedGiftCardModel.dart';

import '../../../../core/resources/DataResult.dart';

abstract interface class AncillaryPagesRepository {

  Future<DataResult<AncillaryPagesModel>> getAncillaryData(String? key);

}
