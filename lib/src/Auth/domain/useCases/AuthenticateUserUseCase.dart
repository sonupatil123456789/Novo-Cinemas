


import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';
import '../models/UserAuthModel.dart';

class AuthenticateUserUseCase implements UseCase<DataResult<String?>, EmptyParams>{

  final AuthRepository repository ;
  AuthenticateUserUseCase(this.repository);

  @override
  Future<DataResult<String?>> call(EmptyParams params) async{
    return await repository.authenticateUser();
  }



}
