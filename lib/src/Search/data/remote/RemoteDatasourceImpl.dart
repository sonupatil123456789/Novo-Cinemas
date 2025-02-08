


import 'package:novocinema/core/resources/ResponseData.dart';
import 'package:novocinema/src/Search/data/dto/SearchDto.dart';
import '../../../../core/constants/ApiUrlConstants.dart';
import '../../../../core/restServices/BaseApi.dart';
import '../../../../core/utils/Logger.dart';
import 'RemoteDatasource.dart';

class SearchRemoteDatasourceImpl implements SearchRemoteDatasource {
  late final BaseApi responseData;

  SearchRemoteDatasourceImpl(this.responseData);

  @override
  Future<ResponseData<SearchDto>> search(String search) async {

    try{
      final response = await responseData.get(ApiUrlConstants.search,<String,dynamic>{'search':search}, null);

      ResponseData<SearchDto> dtoResponse = ResponseData<SearchDto>.fromJson(response.data, (value) {
        return SearchDto.fromJson(value);
      });

      Logger.customLogData("search", dtoResponse.toString());
      return dtoResponse;

    } on Exception catch(error){
      rethrow;
    }

  }









}
