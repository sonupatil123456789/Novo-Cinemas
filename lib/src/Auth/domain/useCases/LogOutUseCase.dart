import 'package:novocinema/src/Auth/domain/Repository/Repository.dart';
import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';

class LogOutUseCase implements UseCase<DataResult<bool>, EmptyParams> {
  final AuthRepository repository;
  LogOutUseCase(this.repository);

  @override
  Future<DataResult<bool>> call(EmptyParams params) async {
    return await repository.logOut();
  }

}

