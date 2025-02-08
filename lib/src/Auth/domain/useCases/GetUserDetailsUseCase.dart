


import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';
import '../models/UserAuthModel.dart';

class GetUserDetailsUseCase implements UseCase<DataResult<UserAuthModel>, EmptyParams>{

  final AuthRepository repository ;
  GetUserDetailsUseCase(this.repository);

  @override
  Future<DataResult<UserAuthModel>> call(EmptyParams params) async{
    return await repository.getUserDetails();
  }



}
