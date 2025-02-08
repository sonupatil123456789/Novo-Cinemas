
import 'package:novocinema/core/resources/ResponseData.dart';
import 'package:novocinema/src/Home/data/dto/BannerDto.dart';
import 'package:novocinema/entities/dto/GetAllMoviesDto.dart';
import 'package:novocinema/src/Home/data/dto/QuickBookDto.dart';


abstract interface class MoviesRemoteDatasource {

   Future<ResponseData<GetAllMoviesDto>> getAllFilterMovies(String url, Map<String,dynamic> query);

}