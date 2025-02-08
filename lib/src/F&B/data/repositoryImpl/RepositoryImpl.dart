

import 'package:novocinema/core/resources/DataResult.dart';
import 'package:novocinema/src/F&B/data/dto/ConcessionCategoryDto.dart';
import 'package:novocinema/src/F&B/domain/models/ConcessionCategoryModel.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/utils/Logger.dart';
import '../../domain/Repository/Repository.dart';
import '../remote/RemoteDatasource.dart';

class FAndBRepositoryImpl implements FAndBRepository {
  late final FAndBRemoteDatasource remoteDatasource;

  FAndBRepositoryImpl(this.remoteDatasource);



  @override
  Future<DataResult<List<ConcessionCategoryModel>>> getAllFoodAndBevRage(String cinemaId) async {

    try {
      final fAndBResponse = await remoteDatasource.getAllFoodAndBevRage(cinemaId);

      if(fAndBResponse.success == true){
        return DataResult.success(fAndBResponse.data.map((toElement)=> ConcessionCategoryDto.toDomainModel(toElement)).toList());
      }

      throw Exception(fAndBResponse.message);

    } on AppException catch (error,stack) {
      Logger.customLogError("getAllFoodAndBevRage", error, stack);
      return DataResult.error(error, null);
    }

  }

  @override
  Future<DataResult<Map<String, dynamic>>> completeFoodAndBevRageOrder(Map<String, dynamic> fnb ,  String url)async {

    try {
      final fAndBResponse = await remoteDatasource.completeFoodAndBevRageOrder(fnb, url);

      if(fAndBResponse.success == true){
        return DataResult.success(fAndBResponse.data);
      }

      throw Exception(fAndBResponse.message);

    } on AppException catch (error,stack) {
      Logger.customLogError("completeFoodAndBevRageOrder", error, stack);
      return DataResult.error(error, null);
    }

  }


}
