

import '../../../../core/constants/ApiUrlConstants.dart';
import '../../../../core/resources/ResponseData.dart';
import '../../../../core/restServices/BaseApi.dart';
import '../../../../core/utils/Logger.dart';
import '../../../../entities/dto/GetAllMoviesDto.dart';
import 'RemoteDatasource.dart';

class MoviesRemoteDatasourceImpl implements MoviesRemoteDatasource {
  late final BaseApi responseData;

  MoviesRemoteDatasourceImpl(this.responseData);



  @override
  Future<ResponseData<GetAllMoviesDto>> getAllFilterMovies(String url, Map<String,dynamic> query) async{
    try{
      final response = await responseData.get(ApiUrlConstants.getAllMovies, query, null);

      ResponseData<GetAllMoviesDto> dtoResponse = ResponseData<GetAllMoviesDto>.fromJson(response.data, (value) {
        return GetAllMoviesDto.fromJson(value);
      });

      // Logger.customLogData("getAllFilterMovies", dtoResponse.toString());
      return dtoResponse;

    } on Exception catch(error){
      rethrow;
    }
  }







}
