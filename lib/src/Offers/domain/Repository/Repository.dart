

import 'package:novocinema/src/Offers/domain/models/OffersModel.dart';
import '../../../../core/resources/DataResult.dart';

abstract interface class OffersRepository{

  Future<DataResult<Map<String,dynamic>>> cancelBookedSelectedSeats(String reservationId);

  Future<DataResult<OffersModel>> getAllOffers(String reservationId);

  Future<DataResult<bool>> validateBankOffer(Map<String,dynamic> data);

  Future<DataResult<Map<String,dynamic>>> applyBankOffer(Map<String,dynamic> data);

  Future<DataResult<Map<String,dynamic>>> removeAppliedBankOffers(String reservationId);

  Future<DataResult<Map<String,dynamic>>> applyDiscountCodeOffers(Map<String,dynamic> data);

  Future<DataResult<Map<String,dynamic>>> removeDiscountCodeOffers(String reservationId);

}
