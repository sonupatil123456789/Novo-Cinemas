

import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';
import '../models/SearchModel.dart';

class SearchUseCase implements UseCase<DataResult<SearchModel>, String>{

  final SearchRepository repository ;
  SearchUseCase(this.repository);

  @override
  Future<DataResult<SearchModel>> call(String search) async {
    return await repository.search(search);
  }





}


