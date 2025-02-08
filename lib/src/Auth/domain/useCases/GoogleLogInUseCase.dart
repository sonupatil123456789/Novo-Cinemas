


import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';

class GoogleLogInUseCase implements UseCase<DataResult<Map<String,dynamic>>, EmptyParams> {
  final AuthRepository repository;
  GoogleLogInUseCase(this.repository);

  @override
  Future<DataResult<Map<String,dynamic>>> call(EmptyParams params) async {
    return await repository.googleLogIn();
  }
}


