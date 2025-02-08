
import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';
import '../models/ReservationDetailsModel.dart';

class GetReservationDetailsUseCase implements UseCase<DataResult<ReservationDetailsModel>, String>{

  final TicketRepository repository ;
  GetReservationDetailsUseCase(this.repository);

  @override
  Future<DataResult<ReservationDetailsModel>> call(String reservationId) async{
    return await repository.getReservationDetails(reservationId);
  }


}


