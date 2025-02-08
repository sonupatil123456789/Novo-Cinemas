
import 'package:novocinema/src/SeatLayout/domain/models/SeatLayoutModel.dart';
import '../../../../core/resources/DataResult.dart';


abstract interface class SeatLayoutRepository{


  Future<DataResult<SeatLayoutModel>> getSeatLayout(String cinemaId ,String sessionId);

  Future<DataResult<String>> bookSelectedSeats(Map<String,dynamic> seatData);

  Future<DataResult<Map<String, dynamic>>> extendSeatBookingTimer(String reservationId);


}
