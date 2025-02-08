
import 'package:novocinema/src/SeatLayout/domain/models/SeatLayoutModel.dart';
import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';

class GetSeatLayoutUseCase implements UseCase<DataResult<SeatLayoutModel>, GetSeatLayoutParams> {
  final SeatLayoutRepository repository;
  GetSeatLayoutUseCase(this.repository);

  @override
  Future<DataResult<SeatLayoutModel>> call(GetSeatLayoutParams params) async {
   return await repository.getSeatLayout(params.cinemaId, params.sessionId);
  }
}

class GetSeatLayoutParams {
  String cinemaId;
  String sessionId;

  GetSeatLayoutParams(this.sessionId, this.cinemaId);
}
