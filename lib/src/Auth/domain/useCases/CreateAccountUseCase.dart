
import 'package:novocinema/src/Auth/domain/Repository/Repository.dart';
import 'package:novocinema/src/Auth/domain/models/UserAuthModel.dart';
import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';

class CreateAccountUseCase implements UseCase<DataResult<bool>, Map<String,dynamic>>{

  final AuthRepository repository ;
  CreateAccountUseCase(this.repository);

  @override
  Future<DataResult<bool>> call(Map<String,dynamic> user) async {
    return await repository.signeUp(user);
  }

}


