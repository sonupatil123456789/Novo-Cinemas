import 'package:novocinema/core/resources/ResponseData.dart';
import 'package:novocinema/src/Movies/data/dto/MovieDto.dart';

import '../../presentation/bloc/MovieDetailsBloc.dart';
import '../dto/GetSessionDto.dart';

abstract interface class MovieDetailsRemoteDatasource {

  Future<ResponseData<MovieDto>> getMovieDetails(String movieId);

  Future<ResponseData<Map<String,dynamic>>> getAvailableDates(String movieId);

  Future<ResponseData<GetSessionDto>> createSession(String movieId , String sessionDate, DetailPageType pageType);

  Future<ResponseData<Map<String, dynamic>>> likeDislike(
      Map<String, dynamic> data, String url);
}
