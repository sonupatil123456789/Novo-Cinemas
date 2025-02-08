
import 'package:novocinema/core/resources/DataResult.dart';
import 'package:novocinema/src/Home/data/dto/BannerDto.dart';
import 'package:novocinema/entities/dto/GetAllMoviesDto.dart';
import 'package:novocinema/src/Home/data/dto/QuickBookDto.dart';
import 'package:novocinema/src/Home/domain/Repository/Repository.dart';
import 'package:novocinema/src/Home/domain/models/BannerModel.dart';
import 'package:novocinema/entities/models/GetAllMoviesModel.dart';
import 'package:novocinema/src/Home/domain/models/QuickBookModel.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/utils/Logger.dart';
import '../../domain/Repository/Repository.dart';
import '../remote/RemoteDatasource.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  late final MoviesRemoteDatasource remoteDatasource;



  MoviesRepositoryImpl(this.remoteDatasource);



  @override
  Future<DataResult<GetAllMoviesModel>> getAllFilterMovies(String url, Map<String, dynamic> query) async{

    try {
      final moviesResponse = await remoteDatasource.getAllFilterMovies(url , query);

      if(moviesResponse.success == true){
        return DataResult.success(GetAllMoviesDto.toDomainModel(moviesResponse.data));
      }

      throw Exception(moviesResponse.message);

    } on AppException catch (error,stack) {
      Logger.customLogError("getAllFilterMovies", error, stack);
      return DataResult.error(error, null);
    }

  }










}
