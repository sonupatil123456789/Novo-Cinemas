
import 'package:novocinema/core/constants/ApiUrlConstants.dart';
import 'package:novocinema/core/resources/DataResult.dart';
import 'package:novocinema/core/resources/enums.dart';
import 'package:novocinema/src/Movies/data/dto/MovieDto.dart';
import 'package:novocinema/src/Movies/domain/models/MovieModel.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/utils/Logger.dart';
import '../../domain/Repository/Repository.dart';
import '../../domain/models/GetSessionModel.dart';
import '../../presentation/bloc/MovieDetailsBloc.dart';
import '../dto/GetSessionDto.dart';
import '../remote/RemoteDatasource.dart';


class MovieDetailsRepositoryImpl implements MovieDetailsRepository {
  late final MovieDetailsRemoteDatasource remoteDatasource;

  MovieDetailsRepositoryImpl(this.remoteDatasource);

  @override
  Future<DataResult<GetSessionModel>> createSession(String movieId,String sessionDate ,  DetailPageType pageType,) async{

    try {
      final bannerResponse = await remoteDatasource.createSession(movieId,sessionDate ,pageType );

      if(bannerResponse.success == true){

        return DataResult.success(GetSessionDto.toDomainModel(bannerResponse.data));
      }

      throw AppException(message: bannerResponse.message, errorCode: ErrorCode.UNKNOWN_ERROR);

    } on AppException catch (error,stack) {
      Logger.customLogError("createSession", error, stack);
      return DataResult.error(error, null);
    }

  }

  @override
  Future<DataResult<MovieModel>> getMovieDetails(String movieId) async {
    try {
      final bannerResponse = await remoteDatasource.getMovieDetails(movieId);

      if (bannerResponse.success == true) {
        return DataResult.success(MovieDto.toDomainModel(bannerResponse.data));
      }

      throw AppException(message: bannerResponse.message, errorCode: ErrorCode.UNKNOWN_ERROR);
    } on AppException catch (error, stack) {
      Logger.customLogError("getMovieDetails", error, stack);
      return DataResult.error(error, null);
    }
  }

  @override
  Future<DataResult<Map<String, dynamic>>> likeDislike(Map<String, dynamic> data, url) async {
    try {
      final likeResponse = await remoteDatasource.likeDislike(data,url);

      if (likeResponse.success == true) {
        return DataResult.success(likeResponse.data);
      }

      throw AppException(message: likeResponse.message, errorCode: ErrorCode.UNKNOWN_ERROR);
    } on AppException catch (error, stack) {
      Logger.customLogError("likeDislike", error, stack);
      return DataResult.error(error, null);
    }

  }

  @override
  Future<DataResult<Map<String, dynamic>>> getAvailableDates(String movieId) async {
    try {
      final likeResponse = await remoteDatasource.getAvailableDates(movieId);

      if (likeResponse.success == true) {
        return DataResult.success(likeResponse.data);
      }

      throw AppException(message: likeResponse.message, errorCode: ErrorCode.UNKNOWN_ERROR);
    } on AppException catch (error, stack) {
      Logger.customLogError("getAvailableDates", error, stack);
      return DataResult.error(error, null);
    }
  }

}
