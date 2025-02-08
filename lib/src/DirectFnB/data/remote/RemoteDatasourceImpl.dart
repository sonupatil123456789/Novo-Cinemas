
import '../../../../core/constants/ApiUrlConstants.dart';
import '../../../../core/resources/ResponseData.dart';
import '../../../../core/restServices/BaseApi.dart';
import '../../../../core/utils/Logger.dart';
import '../../../Tickets/data/dto/ReservationDetailsDto.dart';
import 'RemoteDatasource.dart';

class DirectFAndBDatasourceImpl implements DirectFAndBDatasource {
  late final BaseApi responseData;

  DirectFAndBDatasourceImpl(this.responseData);

  @override
  Future<ResponseData<ReservationDetailsDto>> getUpcomingBookingsDetails(String bookingId)async  {
    try{

      final response = await responseData.get(ApiUrlConstants.getUserUpComingBookingDetails + bookingId,null, null);

      ResponseData<ReservationDetailsDto> dtoResponse = ResponseData<ReservationDetailsDto>.fromJson(response.data, (value) {
        return value != null ?  ReservationDetailsDto.fromJson(value) :ReservationDetailsDto.fromJson(const <String,dynamic>{}) ;
      });

      Logger.customLogData("getUpcomingBookingsDetails", dtoResponse.toString());
      return dtoResponse;

    } on Exception catch(error){
      rethrow;
    }
  }


  @override
  Future<ResponseData<List<ReservationDetailsDto>>> getAllUpcomingBookings()async  {
    try{

      final response = await responseData.get(ApiUrlConstants.getUserUpComingBooking, null, null);

      ResponseData<List<ReservationDetailsDto>> dtoResponse = ResponseData<List<ReservationDetailsDto>>.fromJson(response.data, (value) {
        return value != null ? (value  as List<dynamic>).map((toElement)=> ReservationDetailsDto.fromJson(toElement)).toList() :[];
      });

      Logger.customLogData("getAllUpcomingBookings", dtoResponse.toString());
      return dtoResponse;

    } on Exception catch(error){
      rethrow;
    }
  }






}
