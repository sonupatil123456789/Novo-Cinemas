import 'package:novocinema/core/resources/ResponseData.dart';

import 'package:novocinema/src/F&B/data/dto/ConcessionCategoryDto.dart';

import '../../../../core/constants/ApiUrlConstants.dart';
import '../../../../core/restServices/BaseApi.dart';
import '../../../../core/utils/Logger.dart';
import 'RemoteDatasource.dart';

class FAndBRemoteDatasourceImpl implements FAndBRemoteDatasource {
  late final BaseApi responseData;

  FAndBRemoteDatasourceImpl(this.responseData);

  @override
  Future<ResponseData<List<ConcessionCategoryDto>>> getAllFoodAndBevRage(
    String cinemaId,
  ) async {
    try {

      // final String url = "${ApiUrlConstants.getAllFoodAndBevRage}/cinema/$cinemaId";

      final String url = "${ApiUrlConstants.getAllFoodAndBevRage}/cinema/3";

      final response = await responseData.get(url, null, null);

      ResponseData<List<ConcessionCategoryDto>> dtoResponse =
          ResponseData<List<ConcessionCategoryDto>>.fromJson(response.data,
              (value) {
        return value != null
            ? (value as List<dynamic>)
                .map((toElement) => ConcessionCategoryDto.fromJson(toElement))
                .toList()
            : [];
      });

      Logger.customLogData("getAllFoodAndBevRage", dtoResponse.toString());
      return dtoResponse;
    } on Exception catch (error) {
      rethrow;
    }
  }

  @override
  Future<ResponseData<Map<String, dynamic>>> completeFoodAndBevRageOrder(
      Map<String, dynamic> fnb, String url) async {
    try {
      final response = await responseData.post(url, fnb, null, null);

      ResponseData<Map<String, dynamic>> dtoResponse =
          ResponseData<Map<String, dynamic>>.fromJson(response.data, (value) {
        return (value as Map<String, dynamic>?) ?? <String, dynamic>{};
      });

      Logger.customLogData(
          "completeFoodAndBevRageOrder", dtoResponse.toString());
      return dtoResponse;
    } on Exception catch (error) {
      rethrow;
    }
  }
}
