
import 'package:novocinema/src/Tickets/domain/models/ReservationDetailsModel.dart';

import '../../../../core/resources/DataResult.dart';


abstract interface class TicketRepository{


  Future<DataResult<ReservationDetailsModel>> getReservationDetails(String reservationId);


}
