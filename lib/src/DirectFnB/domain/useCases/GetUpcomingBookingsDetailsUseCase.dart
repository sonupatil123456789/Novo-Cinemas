
import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../../../Tickets/domain/models/ReservationDetailsModel.dart';
import '../Repository/Repository.dart';

class GetUpcomingBookingsDetailsUseCase implements UseCase<DataResult<ReservationDetailsModel>, String>{

  final DirectFAndBRepository repository ;
  GetUpcomingBookingsDetailsUseCase(this.repository);

  @override
  Future<DataResult<ReservationDetailsModel>> call(String reservationId) async{
    return await repository.getUpcomingBookingsDetails(reservationId);
  }


}


