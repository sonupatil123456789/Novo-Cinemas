import 'package:novocinema/core/resources/DataResult.dart';
import 'package:novocinema/src/GiftCard/data/dto/AllGiftCardDto.dart';
import 'package:novocinema/src/GiftCard/data/dto/GetCardBalanceDto.dart';
import 'package:novocinema/src/GiftCard/data/remote/RemoteDatasource.dart';
import 'package:novocinema/src/GiftCard/domain/models/AllGiftCardModel.dart';
import 'package:novocinema/src/GiftCard/domain/models/GetCardBalanceModel.dart';
import 'package:novocinema/src/GiftCard/domain/models/SendReceivedGiftCardModel.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/enums.dart';
import '../../../../core/utils/Logger.dart';
import '../../domain/Repository/Repository.dart';
import '../dto/SendReceivedGiftCardDto.dart';

class GiftCardRepositoryImpl implements GiftCardRepository {
  late final GiftCardRemoteDatasource remoteDatasource;

  GiftCardRepositoryImpl(this.remoteDatasource);

  @override
  Future<DataResult<AllGiftCardModel>> getAllGiftCards() async {
    try {
      final allGiftCardResponse = await remoteDatasource.getAllGiftCard();

      if (allGiftCardResponse.success == true) {
        AllGiftCardModel domainData =
            AllGiftCardDto.toDomainModel(allGiftCardResponse.data);
        return DataResult.success(domainData);
      }
      throw Exception(allGiftCardResponse.message);
    } on AppException catch (error, stack) {
      Logger.customLogError("getAllBanners", error, stack);
      return DataResult.error(error, null);
    }
  }

  @override
  Future<DataResult<String>> buyGiftCard(Map<String, dynamic> data) async {
    try {
      final reservationResponse = await remoteDatasource.buyGiftCard(data);

      if (reservationResponse.success == true) {
        return DataResult.success(reservationResponse.data['reservationId']);
      }

      throw AppException(
          message: reservationResponse.message,
          errorCode: ErrorCode.UNKNOWN_ERROR);
    } on AppException catch (error, stack) {
      Logger.customLogError("bookSelectedSeats", error, stack);
      return DataResult.error(error, null);
    }
  }

  @override
  Future<DataResult<GetCardBalanceModel>> getGiftCardBalance(
      String cardNumber) async {
    try {
      final getGiftCardBalanceResponse =
          await remoteDatasource.getGiftCardBalance(cardNumber);

      if (getGiftCardBalanceResponse.success == true) {
        GetCardBalanceModel domainData =
            GetCardBalanceDto.toDomainModel(getGiftCardBalanceResponse.data);
        return DataResult.success(domainData);
      }
      throw Exception(getGiftCardBalanceResponse.message);
    } on AppException catch (error, stack) {
      Logger.customLogError("getAllBanners", error, stack);
      return DataResult.error(error, null);
    }
  }

  @override
  Future<DataResult<SendReceivedGiftCardModel>> sendReceivedGiftCard() async {
    try {
      final sendReceivedGiftCardResponse =
          await remoteDatasource.sendReceivedGiftCard();
      if (sendReceivedGiftCardResponse.success == true) {
        SendReceivedGiftCardModel domainData =
            SendReceivedGiftCardDto.toDomainModel(
                sendReceivedGiftCardResponse.data);
        return DataResult.success(domainData);
      }
      throw Exception(sendReceivedGiftCardResponse.message);
    } on AppException catch (error, stack) {
      Logger.customLogError("sendReceivedGiftCardResponse", error, stack);
      return DataResult.error(error, null);
    }
  }

  @override
  Future<DataResult<String>> topUpGiftCard(Map<String, dynamic> data) async {
    try {
      final reservationResponse = await remoteDatasource.topUpGiftCard(data);

      if (reservationResponse.success == true) {
        return DataResult.success(reservationResponse.data['reservationId']);
      }

      throw AppException(
          message: reservationResponse.message,
          errorCode: ErrorCode.UNKNOWN_ERROR);
    } on AppException catch (error, stack) {
      Logger.customLogError("bookSelectedSeats", error, stack);
      return DataResult.error(error, null);
    }
  }
}
