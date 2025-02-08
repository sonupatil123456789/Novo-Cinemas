
import 'package:novocinema/src/Movies/domain/models/MovieModel.dart';
import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';
import '../models/OffersModel.dart';
import 'CancelBookedSelectedSeatsUseCase.dart';


class RemoveAppliedBankOffersUseCase implements UseCase<DataResult<Map<String,dynamic>>, String> {
  final OffersRepository repository ;
  RemoveAppliedBankOffersUseCase(this.repository);

  @override
  Future<DataResult<Map<String, dynamic>>> call(String reservationId) async {
    return await repository.removeAppliedBankOffers(reservationId);
  }




}

