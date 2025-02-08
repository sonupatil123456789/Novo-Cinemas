


import 'package:novocinema/src/F&B/data/dto/ConcessionCategoryDto.dart';
import '../../../../core/resources/ResponseData.dart';

abstract interface class FAndBRemoteDatasource {

   Future<ResponseData<List<ConcessionCategoryDto>>> getAllFoodAndBevRage(String cinemaId);

   Future<ResponseData<Map<String,dynamic>>> completeFoodAndBevRageOrder(Map<String,dynamic> fnb, String url);


}






