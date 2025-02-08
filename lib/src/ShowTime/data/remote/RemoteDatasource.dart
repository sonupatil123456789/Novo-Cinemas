
import 'package:novocinema/core/resources/ResponseData.dart';
import 'package:novocinema/src/Movies/data/dto/MovieDto.dart';


import '../dto/ShowTimeSessionDto.dart';


abstract interface class ShowTimeRemoteDatasource {

   Future<ResponseData<ShowTimeSessionDto>> getAllMoviesWithSession();

}






