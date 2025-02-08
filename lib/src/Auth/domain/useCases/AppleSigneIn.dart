

import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';

class AppleSigneIn implements UseCase<DataResult<bool>, EmptyParams> {
  final AuthRepository repository;
  AppleSigneIn(this.repository);

  @override
  Future<DataResult<bool>> call(EmptyParams params) async {
    final data = await repository.logInWithApple();
    return data;
  }
}

