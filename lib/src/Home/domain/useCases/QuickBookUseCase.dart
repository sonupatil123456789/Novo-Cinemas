
import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';
import '../../../../entities/models/GetAllMoviesModel.dart';
import '../models/QuickBookModel.dart';

class QuickBookUseCase implements UseCase<DataResult<QuickBookModel>, Map<String,dynamic>> {
  final HomeRepository repository ;
  QuickBookUseCase(this.repository);

  @override
  Future<DataResult<QuickBookModel>> call(Map<String, dynamic> query) async {
    return await repository.quickBook(query);
  }




}

