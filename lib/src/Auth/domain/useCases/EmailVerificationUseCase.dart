


import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';

class EmailVerificationUseCase implements UseCase<DataResult<bool>, String> {
  final AuthRepository repository;
  EmailVerificationUseCase(this.repository);

  @override
  Future<DataResult<bool>> call(String emailId) async {
    return  await repository.emailVerification(emailId);
  }
}