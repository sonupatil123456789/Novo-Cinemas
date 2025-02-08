


import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';

class GetAllNationalityUseCase implements UseCase<DataResult<List<Map<String,dynamic>>>, EmptyParams>{

  final AuthRepository repository ;
  GetAllNationalityUseCase(this.repository);

  @override
  Future<DataResult<List<Map<String,dynamic>>>> call(EmptyParams params)async {
    return await repository.getAllNationality();
  }





}