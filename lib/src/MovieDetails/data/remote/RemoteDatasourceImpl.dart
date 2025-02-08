import 'package:novocinema/core/resources/ResponseData.dart';
import 'package:novocinema/src/Movies/data/dto/MovieDto.dart';
import '../../../../core/constants/ApiUrlConstants.dart';
import '../../../../core/restServices/BaseApi.dart';
import '../../../../core/utils/Logger.dart';
import '../../presentation/bloc/MovieDetailsBloc.dart';
import '../dto/GetSessionDto.dart';
import 'RemoteDatasource.dart';

class MovieDetailsRemoteDatasourceImpl implements MovieDetailsRemoteDatasource {
  late final BaseApi responseData;

  MovieDetailsRemoteDatasourceImpl(this.responseData);

    @override
  Future<ResponseData<GetSessionDto>> createSession(String movieId,String sessionDate , DetailPageType pageType) async {
    try{
      // const response = showTimeData;

      String? url;

      switch(pageType) {
        case DetailPageType.BOOKING_FLOW:
          url = '${ApiUrlConstants.createSession}$movieId/date/$sessionDate';
        case DetailPageType.PRIVATE_BOOKING:
          // TODO: Handle this case.
          throw UnimplementedError();
      }


      final response = await responseData.get(url,  null, null);


      ResponseData<GetSessionDto> dtoResponse = ResponseData<GetSessionDto>.fromJson(response.data, (value) {
        return GetSessionDto.fromJson(value);
      });

      Logger.customLogData("createSession", dtoResponse.toString());
      return dtoResponse;

    } on Exception catch(error){
      rethrow;
    }
  }



  @override
  Future<ResponseData<MovieDto>> getMovieDetails(String movieId) async {
    try {
      final response = await responseData.get(ApiUrlConstants.getMovieDetails + movieId, null, null);

      ResponseData<MovieDto> dtoResponse = ResponseData<MovieDto>.fromJson(response.data, (value) {
        return MovieDto.fromJson(value);
      });

      Logger.customLogData("getMovieDetails", dtoResponse.toString());
      return dtoResponse;
    } on Exception catch (error) {
      rethrow;
    }
  }

  @override
  Future<ResponseData<Map<String, dynamic>>> likeDislike(
      Map<String, dynamic> data, url) async {
    try {
      final response = await responseData.post(url, data, null, null);

      ResponseData<Map<String, dynamic>> dtoResponse =
          ResponseData<Map<String, dynamic>>.fromJson(response.data, (value) {
        return value ?? <String, dynamic>{};
      });

      Logger.customLogData("likeDislike", dtoResponse.toString());
      return dtoResponse;
    } on Exception catch (error) {
      rethrow;
    }
  }

  @override
  Future<ResponseData<Map<String,dynamic>>> getAvailableDates(String movieId) async {
    try {
      final response = await responseData.get(ApiUrlConstants.getSessionDates + movieId, null, null);

      ResponseData<Map<String,dynamic>> dtoResponse = ResponseData<Map<String,dynamic>>.fromJson(response.data, (value) {
        return value != null ? Map.of(value) : <String,dynamic>{};
      });

      Logger.customLogData("getAvailableDates", dtoResponse.toString());
      return dtoResponse;
    } on Exception catch (error) {
      rethrow;
    }
  }
}
