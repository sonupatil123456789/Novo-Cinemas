


import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';

class LoginAsGuestUseCase implements UseCase<DataResult<bool>, Map<String,dynamic>>{

  final AuthRepository repository ;
  LoginAsGuestUseCase(this.repository);

  @override
  Future<DataResult<bool>> call(Map<String,dynamic> user) async {
    return await  repository.loginAsGuest(user);
  }

}