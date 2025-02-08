


import '../../../../core/resources/ResponseData.dart';

abstract interface class OrderConfirmationRemoteDatasource {

   Future<ResponseData<Map<String,dynamic>>> completeOrder(String reservationId);

   Future<ResponseData<dynamic>> cancelFAndB(String reservationId);

   Future<ResponseData<Map<String, dynamic>>> applyVoucherCode(Map<String, dynamic> data);

   Future<ResponseData<Map<String, dynamic>>> removeVoucherCode(String reservationId);

}






