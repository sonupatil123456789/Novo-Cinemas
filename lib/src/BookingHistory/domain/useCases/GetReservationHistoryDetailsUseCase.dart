

import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../../../Tickets/domain/models/ReservationDetailsModel.dart';
import '../Repository/Repository.dart';

class GetReservationHistoryDetailsUseCase implements UseCase<DataResult<List<ReservationDetailsModel>>, EmptyParams>{

  final BookingHistoryRepository repository ;
  GetReservationHistoryDetailsUseCase(this.repository);

  @override
  Future<DataResult<List<ReservationDetailsModel>>> call(EmptyParams params)async  {
    return await repository.getReservationHistoryDetails();
  }




}


