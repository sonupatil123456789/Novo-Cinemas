
import '../../../../core/resources/ResponseData.dart';
import '../../../Tickets/data/dto/ReservationDetailsDto.dart';


abstract interface class DirectFAndBDatasource {

   Future<ResponseData<List<ReservationDetailsDto>>> getAllUpcomingBookings();

   Future<ResponseData<ReservationDetailsDto>> getUpcomingBookingsDetails(String bookingId);

}






