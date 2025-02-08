


import '../../../../core/resources/DataResult.dart';
import '../../../Tickets/domain/models/ReservationDetailsModel.dart';

abstract interface class BookingHistoryRepository{


  Future<DataResult<List<ReservationDetailsModel>>> getReservationHistoryDetails();


}
