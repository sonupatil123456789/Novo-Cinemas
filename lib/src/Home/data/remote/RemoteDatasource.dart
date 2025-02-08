
import 'package:novocinema/core/resources/ResponseData.dart';
import 'package:novocinema/src/Home/data/dto/BannerDto.dart';
import 'package:novocinema/entities/dto/GetAllMoviesDto.dart';
import 'package:novocinema/src/Home/data/dto/QuickBookDto.dart';


abstract interface class HomeRemoteDatasource {


   Future<ResponseData<List<BannerDto>>> getAllBanners();


   Future<ResponseData<QuickBookDto>> quickBook(Map<String,dynamic> query);


}