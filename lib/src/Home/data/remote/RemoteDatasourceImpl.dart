
import 'package:novocinema/core/resources/ResponseData.dart';
import 'package:novocinema/core/utils/Logger.dart';
import 'package:novocinema/src/Home/data/dto/BannerDto.dart';
import 'package:novocinema/src/Home/data/dto/QuickBookDto.dart';
import '../../../../core/constants/ApiUrlConstants.dart';
import '../../../../core/restServices/BaseApi.dart';
import '../../../../entities/dto/GetAllMoviesDto.dart';
import 'RemoteDatasource.dart';


class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  late final BaseApi responseData;

  HomeRemoteDatasourceImpl(this.responseData);

  @override
  Future<ResponseData<List<BannerDto>>> getAllBanners() async{
    try{
      final response = await responseData.get(ApiUrlConstants.getAllBanners,  null, null);

      ResponseData<List<BannerDto>> dtoResponse = ResponseData<List<BannerDto>>.fromJson(response.data, (value) {
        return (value as List<dynamic>).map((toElement)=>BannerDto.fromJson(toElement)).toList();
      });

      Logger.customLogData("getAllBanners", dtoResponse.toString());
      return dtoResponse;

    } on Exception catch(error){
      rethrow;
    }
  }



  @override
  Future<ResponseData<QuickBookDto>> quickBook(Map<String, dynamic> query) async {

    try{
      final response = await responseData.get(ApiUrlConstants.quickBook, query, null);

      ResponseData<QuickBookDto> dtoResponse = ResponseData<QuickBookDto>.fromJson(response.data, (value) {
        return QuickBookDto.fromJson(value);
      });

      Logger.customLogData("quickBook", dtoResponse.toString());
      return dtoResponse;

    } on Exception catch(error){
      rethrow;
    }

  }





}
