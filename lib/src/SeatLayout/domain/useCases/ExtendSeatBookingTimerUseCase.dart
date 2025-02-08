



import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';



class ExtendSeatBookingTimerUseCase implements UseCase<DataResult<Map<String,dynamic>>, String>{

  final SeatLayoutRepository repository;
  ExtendSeatBookingTimerUseCase(this.repository);

  @override
  Future<DataResult<Map<String, dynamic>>> call(String reservationId) async{
    return await repository.extendSeatBookingTimer(reservationId);
  }






}
