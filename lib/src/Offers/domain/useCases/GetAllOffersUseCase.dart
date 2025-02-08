
import 'package:novocinema/src/Movies/domain/models/MovieModel.dart';
import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';
import '../models/OffersModel.dart';
import 'CancelBookedSelectedSeatsUseCase.dart';


class GetAllOffersUseCase implements UseCase<DataResult<OffersModel>, String> {
  final OffersRepository repository ;
  GetAllOffersUseCase(this.repository);

  @override
  Future<DataResult<OffersModel>> call(String reservationId) async {
    return await repository.getAllOffers(reservationId);
  }


}

