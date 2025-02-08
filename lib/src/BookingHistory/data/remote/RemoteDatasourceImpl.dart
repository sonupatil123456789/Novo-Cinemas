

import '../../../../core/constants/ApiUrlConstants.dart';
import '../../../../core/resources/ResponseData.dart';
import '../../../../core/restServices/BaseApi.dart';
import '../../../../core/utils/Logger.dart';
import '../../../Tickets/data/dto/ReservationDetailsDto.dart';
import 'RemoteDatasource.dart';

class BookingHistoryDatasourceImpl implements BookingHistoryDatasource {
  late final BaseApi responseData;

  BookingHistoryDatasourceImpl(this.responseData);

  @override
  Future<ResponseData<List<ReservationDetailsDto>>> getReservationHistoryDetails()async  {
    try{

      final response = await responseData.get(ApiUrlConstants.getUserBookingHistoryDetails, null, null);

      ResponseData<List<ReservationDetailsDto>> dtoResponse = ResponseData<List<ReservationDetailsDto>>.fromJson(response.data, (value) {
        return value != null ? (value  as List<dynamic>).map((toElement)=> ReservationDetailsDto.fromJson(toElement)).toList() :[];
      });

      Logger.customLogData("getReservationHistoryDetails", dtoResponse.toString());
      return dtoResponse;

    } on Exception catch(error){
      rethrow;
    }
  }






}
