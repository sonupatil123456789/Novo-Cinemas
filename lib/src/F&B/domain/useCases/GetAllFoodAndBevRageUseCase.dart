
import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';
import '../models/ConcessionCategoryModel.dart';



class GetAllFoodAndBevRageUseCase implements UseCase<DataResult<List<ConcessionCategoryModel>>, String>{

  final FAndBRepository repository ;
  GetAllFoodAndBevRageUseCase(this.repository);

  @override
  Future<DataResult<List<ConcessionCategoryModel>>> call(String cinemaId) async {
   return  await repository.getAllFoodAndBevRage(cinemaId);
  }




}


