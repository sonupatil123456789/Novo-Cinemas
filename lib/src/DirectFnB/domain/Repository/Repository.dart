
import 'package:novocinema/src/Tickets/domain/models/ReservationDetailsModel.dart';

import '../../../../core/resources/DataResult.dart';


abstract interface class DirectFAndBRepository{



  Future<DataResult<List<ReservationDetailsModel>>> getAllUpcomingBookings();

  Future<DataResult<ReservationDetailsModel>> getUpcomingBookingsDetails(String bookingId);


}
