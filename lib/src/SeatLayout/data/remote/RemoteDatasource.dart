
import 'package:novocinema/core/resources/ResponseData.dart';
import '../dto/SeatLayoutDto.dart';


abstract interface class SeatLayoutRemoteDatasource {

   Future<ResponseData<SeatLayoutDto>> getSeatLayout(String cinemaId ,String sessionId);

   Future<ResponseData<Map<String,dynamic>>> bookSelectedSeats(Map<String,dynamic> seatData);

   Future<ResponseData<Map<String,dynamic>>> extendSeatBookingTimer(String reservationId);



}






