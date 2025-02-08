import 'package:novocinema/src/Movies/domain/models/MovieModel.dart';
import '../../../../core/resources/DataResult.dart';
import '../../presentation/bloc/MovieDetailsBloc.dart';
import '../models/GetSessionModel.dart';

abstract interface class MovieDetailsRepository {
  Future<DataResult<MovieModel>> getMovieDetails(String movieId);

  Future<DataResult<Map<String,dynamic>>> getAvailableDates(String movieId);

  Future<DataResult<GetSessionModel>> createSession(String movieId , String sessionDate, DetailPageType pageType);

  Future<DataResult<Map<String, dynamic>>> likeDislike(
      Map<String, dynamic> data, url);
}
