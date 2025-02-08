
import 'package:novocinema/core/resources/ResponseData.dart';
import 'package:novocinema/src/SeatLayout/data/dto/SeatLayoutDto.dart';
import '../../../../core/constants/ApiUrlConstants.dart';
import '../../../../core/restServices/BaseApi.dart';
import '../../../../core/utils/Logger.dart';
import 'RemoteDatasource.dart';


class SeatLayoutRemoteDatasourceImpl implements SeatLayoutRemoteDatasource {
  late final BaseApi responseData;

  SeatLayoutRemoteDatasourceImpl(this.responseData);

  @override
  Future<ResponseData<SeatLayoutDto>> getSeatLayout(String cinemaId, String sessionId) async {
    try{
       String url = "${ApiUrlConstants.getSeatLayout}/cinemas/$cinemaId/sessions/$sessionId";

      final response = await responseData.get(url,  null, null);

      ResponseData<SeatLayoutDto> dtoResponse = ResponseData<SeatLayoutDto>.fromJson(response.data, (value) {
        return SeatLayoutDto.fromJson(value);
      });

      Logger.customLogData("getSeatLayout", dtoResponse.toString());
      return dtoResponse;

    } on Exception catch(error){
      rethrow;
    }
  }

  @override
  Future<ResponseData<Map<String,dynamic>>> bookSelectedSeats(Map<String, dynamic> seatData) async {
    try{
      final query = Map.of(seatData);
      query.remove('selectedMovieSeatsMap');
      final response = await responseData.post(ApiUrlConstants.bookSelectedSeat,seatData,  null, null);

      ResponseData<Map<String,dynamic>> dtoResponse = ResponseData<Map<String,dynamic>>.fromJson(response.data, (value) {
        return value;
      });

      Logger.customLogData("bookSelectedSeats", dtoResponse.toString());
      return dtoResponse;

    } on Exception catch(error){
      rethrow;
    }
  }

  @override
  Future<ResponseData<Map<String, dynamic>>> extendSeatBookingTimer(String reservationId) async{
    try{

      final response = await responseData.post('${ApiUrlConstants.extendSeatBookingTimer}/$reservationId',null,  null, null);

      ResponseData<Map<String,dynamic>> dtoResponse = ResponseData<Map<String,dynamic>>.fromJson(response.data, (value) {
        return value ?? <String,dynamic>{};
      });

      Logger.customLogData("extendSeatBookingTimer", dtoResponse.toString());
      return dtoResponse;

    } on Exception catch(error){
      rethrow;
    }
  }



}
