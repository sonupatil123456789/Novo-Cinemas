
import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';



class BookSelectedSeatsUseCase implements UseCase<DataResult<String>, Map<String,dynamic>>{

  final SeatLayoutRepository repository;
  BookSelectedSeatsUseCase(this.repository);

  @override
  Future<DataResult<String>> call(Map<String, dynamic> seatData) async {
    return  await repository.bookSelectedSeats(seatData);
  }




}


