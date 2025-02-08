
import 'package:novocinema/core/resources/ResponseData.dart';
import 'package:novocinema/src/Home/data/dto/BannerDto.dart';
import 'package:novocinema/entities/dto/GetAllMoviesDto.dart';

import '../dto/SearchDto.dart';


abstract interface class SearchRemoteDatasource {

   Future<ResponseData<SearchDto>> search(String search);

}