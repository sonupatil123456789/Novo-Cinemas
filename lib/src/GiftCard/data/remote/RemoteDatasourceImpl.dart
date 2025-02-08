import 'package:novocinema/src/GiftCard/data/dto/AllGiftCardDto.dart';
import 'package:novocinema/src/GiftCard/data/dto/GetCardBalanceDto.dart';
import 'package:novocinema/src/GiftCard/data/dto/SendReceivedGiftCardDto.dart';

import '../../../../core/constants/ApiUrlConstants.dart';
import '../../../../core/resources/ResponseData.dart';
import '../../../../core/restServices/BaseApi.dart';
import '../../../../core/utils/Logger.dart';
import 'RemoteDatasource.dart';

class GiftCardRemoteDatasourceImpl implements GiftCardRemoteDatasource {
  late final BaseApi responseData;

  GiftCardRemoteDatasourceImpl(this.responseData);

  @override
  Future<ResponseData<AllGiftCardDto>> getAllGiftCard() async {
    try {
      final response =
          await responseData.get(ApiUrlConstants.getAllGiftCard, null, null);

      ResponseData<AllGiftCardDto> dtoResponse =
          ResponseData<AllGiftCardDto>.fromJson(response.data, (value) {
        return value != null
            ? AllGiftCardDto.fromJson(value)
            : AllGiftCardDto.fromJson(const <String, dynamic>{});
      });

      Logger.customLogData("getAllGiftCardDto", dtoResponse.toString());
      return dtoResponse;
    } on Exception catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResponseData<Map<String, dynamic>>> buyGiftCard(
      Map<String, dynamic> data) async {
    try {
      final response = await responseData.post(
          ApiUrlConstants.buyGiftCard, data, null, null);

      ResponseData<Map<String, dynamic>> dtoResponse =
          ResponseData<Map<String, dynamic>>.fromJson(response.data, (value) {
        return value;
      });

      Logger.customLogData("bookSelectedSeats", dtoResponse.toString());
      return dtoResponse;
    } on Exception catch (error) {
      rethrow;
    }
  }

  @override
  Future<ResponseData<GetCardBalanceDto>> getGiftCardBalance(
      String cardNumber) async {
    try {
      final response = await responseData.get(
          ApiUrlConstants.getBalanceGiftCard + cardNumber, null, null);

      ResponseData<GetCardBalanceDto> dtoResponse =
          ResponseData<GetCardBalanceDto>.fromJson(response.data, (value) {
        return value != null
            ? GetCardBalanceDto.fromJson(value)
            : GetCardBalanceDto.fromJson(const <String, dynamic>{});
      });

      Logger.customLogData("GetCardBalanceDto", dtoResponse.toString());
      return dtoResponse;
    } on Exception catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResponseData<SendReceivedGiftCardDto>> sendReceivedGiftCard() async {
    try {
      final response = await responseData.get(
          ApiUrlConstants.sendReceivedGiftCard, null, null);

      ResponseData<SendReceivedGiftCardDto> dtoResponse =
          ResponseData<SendReceivedGiftCardDto>.fromJson(response.data,
              (value) {
        return value != null
            ? SendReceivedGiftCardDto.fromJson(value)
            : SendReceivedGiftCardDto.fromJson(const <String, dynamic>{});
      });

      Logger.customLogData("SendReceivedGiftCardDto", dtoResponse.toString());
      return dtoResponse;
    } on Exception catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResponseData<Map<String, dynamic>>> topUpGiftCard(
      Map<String, dynamic> data) async {
    try {
      final response = await responseData.post(
          ApiUrlConstants.topUpGiftCard, data, null, null);

      ResponseData<Map<String, dynamic>> dtoResponse =
      ResponseData<Map<String, dynamic>>.fromJson(response.data, (value) {
        return value;
      });

      Logger.customLogData("topUpGiftCard", dtoResponse.toString());
      return dtoResponse;
    } on Exception catch (error) {
      rethrow;
    }
  }
}
