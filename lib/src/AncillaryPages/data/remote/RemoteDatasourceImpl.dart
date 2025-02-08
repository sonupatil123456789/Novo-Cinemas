import 'package:novocinema/src/AncillaryPages/data/dto/AncillaryPagesDto.dart';
import 'package:novocinema/src/GiftCard/data/dto/AllGiftCardDto.dart';
import 'package:novocinema/src/GiftCard/data/dto/GetCardBalanceDto.dart';
import 'package:novocinema/src/GiftCard/data/dto/SendReceivedGiftCardDto.dart';

import '../../../../core/constants/ApiUrlConstants.dart';
import '../../../../core/resources/ResponseData.dart';
import '../../../../core/restServices/BaseApi.dart';
import '../../../../core/utils/Logger.dart';
import 'RemoteDatasource.dart';

class AncillaryPagesRemoteDatasourceImpl
    implements AncillaryPagesRemoteDatasource {
  late final BaseApi responseData;

  AncillaryPagesRemoteDatasourceImpl(this.responseData);

  @override
  Future<ResponseData<AncillaryPagesDto>> getAncillaryData(String? key) async {
    try {
      final String query = key != null ? '?key=$key' : '';
      final response =
          await responseData.get('${ApiUrlConstants.pages}$query', null, null);

      ResponseData<AncillaryPagesDto> dtoResponse =
          ResponseData<AncillaryPagesDto>.fromJson(response.data, (value) {
        return value != null
            ? AncillaryPagesDto.fromJson(value)
            : AncillaryPagesDto.fromJson(const <String, dynamic>{});
      });

      Logger.customLogData("AncillaryPagesDto", dtoResponse.toString());
      return dtoResponse;
    } on Exception catch (e) {
      rethrow;
    }
  }
}
