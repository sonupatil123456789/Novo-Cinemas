



import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';

class ApplyVoucherCodeUseCase implements UseCase<DataResult<Map<String,dynamic>>, Map<String,dynamic>> {
  final OrderConfirmationRepository repository ;
  ApplyVoucherCodeUseCase(this.repository);

  @override
  Future<DataResult<Map<String, dynamic>>> call(Map<String, dynamic> data) async {
    return repository.applyVoucherCode(data);
  }




}