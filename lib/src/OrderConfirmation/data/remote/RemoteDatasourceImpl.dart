


import 'package:novocinema/core/resources/ResponseData.dart';
import '../../../../core/constants/ApiUrlConstants.dart';
import '../../../../core/restServices/BaseApi.dart';
import '../../../../core/utils/Logger.dart';
import 'RemoteDatasource.dart';

class OrderConfirmationRemoteDatasourceImpl implements OrderConfirmationRemoteDatasource {
  late final BaseApi responseData;

  OrderConfirmationRemoteDatasourceImpl(this.responseData);

  @override
  Future<ResponseData<Map<String, dynamic>>> completeOrder(String reservationId) async{
    try{

      final response = await responseData.post(ApiUrlConstants.completeOrder, <String,dynamic>{'reservationId':reservationId}, null, null);

      ResponseData<Map<String, dynamic>> dtoResponse = ResponseData<Map<String, dynamic>>.fromJson(response.data, (value) {
        return  (value as Map<String,dynamic>?) ?? <String,dynamic>{};
      });

      Logger.customLogData("completeOrder", dtoResponse.toString());
      return dtoResponse;

    } on Exception catch(error){
      rethrow;
    }
  }

  @override
  Future<ResponseData<dynamic>> cancelFAndB(String reservationId) async  {
    try{

      final response = await responseData.delete('${ApiUrlConstants.getAllFoodAndBevRage}/$reservationId',null, null, null);

      ResponseData<dynamic> dtoResponse = ResponseData<dynamic>.fromJson(response.data, (value) {
        return value;
      });

      Logger.customLogData("cancelFAndB", dtoResponse.toString());
      return dtoResponse;

    } on Exception catch(error){
      rethrow;
    }

  }



  @override
  Future<ResponseData<Map<String, dynamic>>> applyVoucherCode(Map<String, dynamic> data) async {
    try{

      final response = await responseData.post(ApiUrlConstants.applyVoucherCode,data,  null, null);
      ResponseData<Map<String,dynamic>> dtoResponse = ResponseData<Map<String,dynamic>>.fromJson(response.data, (value) {
        return value ?? <String,dynamic>{};
      });

      Logger.customLogData("applyVoucherCode", dtoResponse.toString());
      return dtoResponse;

    } on Exception catch(error){
      rethrow;
    }
  }

  @override
  Future<ResponseData<Map<String, dynamic>>> removeVoucherCode(String reservationId) async  {
    try{

      final response = await responseData.post(ApiUrlConstants.removeVoucherCode,<String,dynamic>{
        'reservationId' :reservationId
      },  null, null);
      ResponseData<Map<String,dynamic>> dtoResponse = ResponseData<Map<String,dynamic>>.fromJson(response.data, (value) {
        return value ?? <String,dynamic>{};
      });

      Logger.customLogData("removeVoucherCode", dtoResponse.toString());
      return dtoResponse;

    } on Exception catch(error){
      rethrow;
    }
  }




}
