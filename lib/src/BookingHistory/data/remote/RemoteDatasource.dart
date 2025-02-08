
import '../../../../core/resources/ResponseData.dart';
import '../../../Tickets/data/dto/ReservationDetailsDto.dart';

abstract interface class BookingHistoryDatasource {

  Future<ResponseData<List<ReservationDetailsDto>>> getReservationHistoryDetails();

}






