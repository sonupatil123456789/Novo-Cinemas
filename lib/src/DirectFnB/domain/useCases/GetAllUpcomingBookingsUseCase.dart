
import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../../../Tickets/domain/models/ReservationDetailsModel.dart';
import '../Repository/Repository.dart';

class GetAllUpcomingBookingsUseCase implements UseCase<DataResult<List<ReservationDetailsModel>>, EmptyParams>{

  final DirectFAndBRepository repository ;
  GetAllUpcomingBookingsUseCase(this.repository);

  @override
  Future<DataResult<List<ReservationDetailsModel>>> call(EmptyParams params) async{
  return await repository.getAllUpcomingBookings();
  }




}


