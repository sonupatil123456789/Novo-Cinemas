


import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';

class FacebookLogInUseCase implements UseCase<DataResult<Map<String,dynamic>>, EmptyParams> {
  final AuthRepository repository;
  FacebookLogInUseCase(this.repository);

  @override
  Future<DataResult<Map<String,dynamic>>> call(EmptyParams params) async {
    return await repository.facebookLogIn();
  }
}


