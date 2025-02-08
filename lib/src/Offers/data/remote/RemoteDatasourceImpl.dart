

import 'package:novocinema/core/resources/ResponseData.dart';
import 'package:novocinema/src/Offers/data/dto/OffersDto.dart';

import '../../../../core/constants/ApiUrlConstants.dart';
import '../../../../core/restServices/BaseApi.dart';
import '../../../../core/utils/Logger.dart';
import 'RemoteDatasource.dart';


class OffersRemoteDatasourceImpl implements OffersRemoteDatasource {
  late final BaseApi responseData;

  OffersRemoteDatasourceImpl(this.responseData);



  @override
  Future<ResponseData<Map<String, dynamic>>> cancelBookedSelectedSeats(String reservationId) async{
    try{

      final response = await responseData.delete("${ApiUrlConstants.cancelBookedSelectedSeat}$reservationId",null,  null, null);
      ResponseData<Map<String,dynamic>> dtoResponse = ResponseData<Map<String,dynamic>>.fromJson(response.data, (value) {
        return value ?? <String,dynamic>{};
      });

      Logger.customLogData("cancelBookedSelectedSeats", dtoResponse.toString());
      return dtoResponse;

    } on Exception catch(error){
      rethrow;
    }
  }

  @override
  Future<ResponseData<OffersDto>> getAllOffers(String reservationId) async{

    try{
      final response = await responseData.get("${ApiUrlConstants.getAllOffers}$reservationId",null, null);

      ResponseData<OffersDto> dtoResponse = ResponseData<OffersDto>.fromJson(response.data, (value) {
        return OffersDto.fromJson(value);
      });

      Logger.customLogData("getAllOffers", dtoResponse.toString());
      return dtoResponse;

    } on Exception catch(error){
      rethrow;
    }

  }

  @override
  Future<ResponseData<Map<String, dynamic>>> validateBankOffer(Map<String, dynamic> data) async{
    try{

      final response = await responseData.post(ApiUrlConstants.validateBankOffers,data,  null, null);
      ResponseData<Map<String,dynamic>> dtoResponse = ResponseData<Map<String,dynamic>>.fromJson(response.data, (value) {
        return value ?? <String,dynamic>{};
      });

      Logger.customLogData("validateBankOffer", dtoResponse.toString());
      return dtoResponse;

    } on Exception catch(error){
      rethrow;
    }

  }

  @override
  Future<ResponseData<Map<String, dynamic>>> applyBankOffer(Map<String, dynamic> data)async {
    try{

      final response = await responseData.post(ApiUrlConstants.applyBankOffers,data,  null, null);
      ResponseData<Map<String,dynamic>> dtoResponse = ResponseData<Map<String,dynamic>>.fromJson(response.data, (value) {
        return value ?? <String,dynamic>{};
      });

      Logger.customLogData("applyBankOffer", dtoResponse.toString());
      return dtoResponse;

    } on Exception catch(error){
      rethrow;
    }

  }

  @override
  Future<ResponseData<Map<String,dynamic>>> removeAppliedBankOffers(String reservationId) async {
    try{

      final response = await responseData.post(ApiUrlConstants.removeAppliedBankOffers,<String,dynamic>{
        'reservationId' :reservationId
      },  null, null);
      ResponseData<Map<String,dynamic>> dtoResponse = ResponseData<Map<String,dynamic>>.fromJson(response.data, (value) {
        return value ?? <String,dynamic>{};
      });

      Logger.customLogData("removeAppliedBankOffers", dtoResponse.toString());
      return dtoResponse;

    } on Exception catch(error){
      rethrow;
    }
  }

  @override
  Future<ResponseData<Map<String, dynamic>>> applyDiscountCodeOffers(Map<String, dynamic> data) async {
    try{

      final response = await responseData.post(ApiUrlConstants.applyDiscountCode,data,  null, null);
      ResponseData<Map<String,dynamic>> dtoResponse = ResponseData<Map<String,dynamic>>.fromJson(response.data, (value) {
        return value ?? <String,dynamic>{};
      });

      Logger.customLogData("applyDiscountCodeOffers", dtoResponse.toString());
      return dtoResponse;

    } on Exception catch(error){
      rethrow;
    }
  }

  @override
  Future<ResponseData<Map<String, dynamic>>> removeDiscountCodeOffers(String reservationId) async  {
    try{

      final response = await responseData.post(ApiUrlConstants.removeDiscountCode,<String,dynamic>{
        'reservationId' :reservationId
      },  null, null);
      ResponseData<Map<String,dynamic>> dtoResponse = ResponseData<Map<String,dynamic>>.fromJson(response.data, (value) {
        return value ?? <String,dynamic>{};
      });

      Logger.customLogData("removeDiscountCodeOffers", dtoResponse.toString());
      return dtoResponse;

    } on Exception catch(error){
      rethrow;
    }
  }



}
