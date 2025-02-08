
import 'package:novocinema/core/resources/DataResult.dart';
import 'package:novocinema/core/resources/enums.dart';
import 'package:novocinema/src/Offers/data/dto/OffersDto.dart';
import 'package:novocinema/src/Offers/domain/models/OffersModel.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/utils/Logger.dart';
import '../../domain/Repository/Repository.dart';
import '../remote/RemoteDatasource.dart';


class OffersRepositoryImpl implements OffersRepository {
  late final OffersRemoteDatasource remoteDatasource;

  OffersRepositoryImpl(this.remoteDatasource);

  @override
  Future<DataResult<Map<String, dynamic>>> cancelBookedSelectedSeats(String reservationId) async{
    try {
      final reservationResponse = await remoteDatasource.cancelBookedSelectedSeats(reservationId);

      if(reservationResponse.success == true){
        return DataResult.success(reservationResponse.data);
      }

      throw AppException(message: reservationResponse.message, errorCode: ErrorCode.UNKNOWN_ERROR);

    } on AppException catch (error,stack) {
      Logger.customLogError("cancelBookedSelectedSeats", error, stack);
      return DataResult.error(error, null);
    }
  }

  @override
  Future<DataResult<OffersModel>> getAllOffers(String reservationId) async {

    try {
      final reservationResponse = await remoteDatasource.getAllOffers(reservationId);

      if(reservationResponse.success == true){
        return DataResult.success(OffersDto.toDomainModel(reservationResponse.data));
      }

      throw AppException(message: reservationResponse.message, errorCode: ErrorCode.UNKNOWN_ERROR);

    } on AppException catch (error,stack) {
      Logger.customLogError("getAllOffers", error, stack);
      return DataResult.error(error, null);
    }

  }

  @override
  Future<DataResult<Map<String, dynamic>>> applyBankOffer(Map<String, dynamic> data) async{
    try {
      final bankOfferResponse = await remoteDatasource.applyBankOffer(data);

      if(bankOfferResponse.success == true){
        return DataResult.success(bankOfferResponse.data);
      }

      throw AppException(message: bankOfferResponse.message, errorCode: ErrorCode.UNKNOWN_ERROR);

    } on AppException catch (error,stack) {
      Logger.customLogError("applyBankOffer", error, stack);
      return DataResult.error(error, null);
    }

  }

  @override
  Future<DataResult<bool>> validateBankOffer(Map<String, dynamic> data) async{
    try {
      final bankOfferResponse = await remoteDatasource.validateBankOffer(data);

      if(bankOfferResponse.success == true){
        if(bankOfferResponse.data['isBinValid'] as bool == true){
          return DataResult.success(bankOfferResponse.data['isBinValid']);
        }
        return DataResult.error(AppException(message: 'Invalid card details', errorCode: ErrorCode.INVALID_DATA_ERROE), false);
      }
      throw AppException(message: bankOfferResponse.message, errorCode: ErrorCode.UNKNOWN_ERROR);

    } on AppException catch (error,stack) {
      Logger.customLogError("validateBankOffer", error, stack);
      return DataResult.error(error, null);
    }
  }

  @override
  Future<DataResult<Map<String, dynamic>>> removeAppliedBankOffers(String reservationId) async {
    try {
      final bankOfferResponse = await remoteDatasource.removeAppliedBankOffers(reservationId);

      if(bankOfferResponse.success == true){
        return DataResult.success(bankOfferResponse.data);
      }

      throw AppException(message: bankOfferResponse.message, errorCode: ErrorCode.UNKNOWN_ERROR);

    } on AppException catch (error,stack) {
      Logger.customLogError("removeAppliedBankOffers", error, stack);
      return DataResult.error(error, null);
    }

  }

  @override
  Future<DataResult<Map<String, dynamic>>> applyDiscountCodeOffers(Map<String, dynamic> data) async {
    try {
      final discountOfferResponse = await remoteDatasource.applyDiscountCodeOffers(data);

      if(discountOfferResponse.success == true){
        return DataResult.success(discountOfferResponse.data);
      }

      throw AppException(message: discountOfferResponse.message, errorCode: ErrorCode.UNKNOWN_ERROR);

    } on AppException catch (error,stack) {
      Logger.customLogError("applyDiscountCodeOffers", error, stack);
      return DataResult.error(error, null);
    }
  }

  @override
  Future<DataResult<Map<String, dynamic>>> removeDiscountCodeOffers(String reservationId) async {
    try {
      final discountOfferResponse = await remoteDatasource.removeDiscountCodeOffers(reservationId);

      if(discountOfferResponse.success == true){
        return DataResult.success(discountOfferResponse.data);
      }

      throw AppException(message: discountOfferResponse.message, errorCode: ErrorCode.UNKNOWN_ERROR);

    } on AppException catch (error,stack) {
      Logger.customLogError("removeDiscountCodeOffers", error, stack);
      return DataResult.error(error, null);
    }
  }



}
