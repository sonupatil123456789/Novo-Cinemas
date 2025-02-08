

import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';

class ForgotPasswordUseCase implements UseCase<DataResult<bool>, String> {
  final AuthRepository repository;
  ForgotPasswordUseCase(this.repository);

  @override
  Future<DataResult<bool>> call(String emailId) async {
    return  await repository.forgotPassword(emailId);
  }
}
