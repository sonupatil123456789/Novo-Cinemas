

import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';

class ResetPasswordUseCase implements UseCase<DataResult<bool>, Map<String,dynamic>> {
  final AuthRepository repository;
  ResetPasswordUseCase(this.repository);

  @override
  Future<DataResult<bool>> call(Map<String,dynamic> data) async {
    return  await repository.resetPassword(data);
  }
}
