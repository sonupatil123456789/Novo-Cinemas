import 'package:novocinema/src/Auth/domain/Repository/Repository.dart';
import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';

class LoginUseCase implements UseCase<DataResult<bool>, LoginParams> {
  final AuthRepository repository;
  LoginUseCase(this.repository);

  @override
  Future<DataResult<bool>> call(LoginParams params) async {
    final data = await repository.logIn(params.email, params.password);
    return data;
  }
}

class LoginParams {
  final String email;
  final String password;
  LoginParams(this.password, this.email);
}
