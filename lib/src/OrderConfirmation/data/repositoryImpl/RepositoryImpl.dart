


import 'package:novocinema/core/resources/DataResult.dart';

import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/enums.dart';
import '../../../../core/utils/Logger.dart';
import '../../domain/Repository/Repository.dart';
import '../remote/RemoteDatasource.dart';

class OrderConfirmationRepositoryImpl implements OrderConfirmationRepository {
  late final OrderConfirmationRemoteDatasource remoteDatasource;

  OrderConfirmationRepositoryImpl(this.remoteDatasource);

  @override
  Future<DataResult<Map<String, dynamic>>> completeOrder(String reservationId) async{
    try {
      final orderResponse = await remoteDatasource.completeOrder(reservationId);

      if(orderResponse.success == true){
        return DataResult.success(orderResponse.data);
      }

      throw AppException(message: orderResponse.message, errorCode: ErrorCode.UNKNOWN_ERROR);

    } on AppException catch (error,stack) {
      Logger.customLogError("completeOrder", error, stack);
      return DataResult.error(error, null);
    }
  }

  @override
  Future<DataResult> cancelFAndB(String reservationId) async{
    try {
      final cancelOrderResponse = await remoteDatasource.cancelFAndB(reservationId);

      if(cancelOrderResponse.success == true){
        return DataResult.success(cancelOrderResponse.data);
      }
      throw AppException(message: cancelOrderResponse.message, errorCode: ErrorCode.UNKNOWN_ERROR);

    } on AppException catch (error,stack) {
      Logger.customLogError("cancelFAndB", error, stack);
      return DataResult.error(error, null);
    }

  }

  @override
  Future<DataResult<Map<String, dynamic>>> applyVoucherCode(Map<String, dynamic> data) async {
    try {
      final discountOfferResponse = await remoteDatasource.applyVoucherCode(data);

      if(discountOfferResponse.success == true){
        return DataResult.success(discountOfferResponse.data);
      }

      throw AppException(message: discountOfferResponse.message, errorCode: ErrorCode.UNKNOWN_ERROR);

    } on AppException catch (error,stack) {
      Logger.customLogError("applyVoucherCode", error, stack);
      return DataResult.error(error, null);
    }
  }

  @override
  Future<DataResult<Map<String, dynamic>>> removeVoucherCode(String reservationId) async {
    try {
      final discountOfferResponse = await remoteDatasource.removeVoucherCode(reservationId);

      if(discountOfferResponse.success == true){
        return DataResult.success(discountOfferResponse.data);
      }

      throw AppException(message: discountOfferResponse.message, errorCode: ErrorCode.UNKNOWN_ERROR);

    } on AppException catch (error,stack) {
      Logger.customLogError("removeVoucherCode", error, stack);
      return DataResult.error(error, null);
    }
  }



}
