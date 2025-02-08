
import 'package:novocinema/src/F&B/domain/models/ConcessionCategoryModel.dart';

import '../../../../core/resources/DataResult.dart';

abstract interface class FAndBRepository{


  Future<DataResult<List<ConcessionCategoryModel>>> getAllFoodAndBevRage(String cinemaId);

  Future<DataResult<Map<String,dynamic>>> completeFoodAndBevRageOrder(Map<String,dynamic> fnb, String url);


}
