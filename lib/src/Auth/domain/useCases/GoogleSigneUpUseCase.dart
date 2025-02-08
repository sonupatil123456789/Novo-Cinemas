


import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';

class GoogleSigneUpUseCase implements UseCase<DataResult<Map<String,dynamic>>, Map<String,dynamic>> {
  final AuthRepository repository;
  GoogleSigneUpUseCase(this.repository);

  @override
  Future<DataResult<Map<String,dynamic>>> call(Map<String, dynamic> data) async {
   return await repository.googleSigneUp(data);
  }



}


