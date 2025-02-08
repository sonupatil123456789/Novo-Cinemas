


import '../../../../core/resources/ResponseData.dart';
import '../dto/OffersDto.dart';

abstract interface class OffersRemoteDatasource {

   Future<ResponseData<Map<String,dynamic>>> cancelBookedSelectedSeats(String reservationId);

   Future<ResponseData<OffersDto>> getAllOffers(String reservationId);

   Future<ResponseData<Map<String,dynamic>>> validateBankOffer(Map<String,dynamic> data);

   Future<ResponseData<Map<String,dynamic>>> applyBankOffer(Map<String,dynamic> data);

   Future<ResponseData<Map<String,dynamic>>> removeAppliedBankOffers(String reservationId);

   Future<ResponseData<Map<String,dynamic>>> applyDiscountCodeOffers(Map<String,dynamic> data);

   Future<ResponseData<Map<String,dynamic>>> removeDiscountCodeOffers(String reservationId);





}






