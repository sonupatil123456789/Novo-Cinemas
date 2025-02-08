
import '../../../../core/resources/DataResult.dart';

abstract interface class OrderConfirmationRepository{


  Future<DataResult<Map<String,dynamic>>> completeOrder(String reservationId);


  Future<DataResult<dynamic>> cancelFAndB(String reservationId);


}
