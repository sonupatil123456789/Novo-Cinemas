
import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';
import '../models/ConcessionCategoryModel.dart';



class CompleteFoodAndBevRageUseCase implements UseCase<DataResult<Map<String,dynamic>>,CompleteFoodAndBevRageParams> {

  final FAndBRepository repository ;
  CompleteFoodAndBevRageUseCase(this.repository);

  @override
  Future<DataResult<Map<String, dynamic>>> call(CompleteFoodAndBevRageParams params) async {
    return await repository.completeFoodAndBevRageOrder(params.fnb,params.url);
  }



}


class CompleteFoodAndBevRageParams{
  final Map<String,dynamic> fnb ;
  final String url ;

  CompleteFoodAndBevRageParams(this.fnb,this.url);

}

