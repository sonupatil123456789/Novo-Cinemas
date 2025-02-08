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
import '../remote/RemoteDatasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  late final HomeRemoteDatasource remoteDatasource;

  HomeRepositoryImpl(this.remoteDatasource);

  @override
  Future<DataResult<List<BannerModel>>> getAllBanners() async {
    try {
      final bannerResponse = await remoteDatasource.getAllBanners();

      if (bannerResponse.success == true) {
        List<BannerModel> domainData = bannerResponse.data
            .map((toElement) => BannerDto.toDomainModel(toElement))
            .toList();
        return DataResult.success(domainData);
      }

      throw Exception(bannerResponse.message);
    } on AppException catch (error, stack) {
      Logger.customLogError("getAllBanners", error, stack);
      return DataResult.error(error, null);
    }
  }

  @override
  Future<DataResult<QuickBookModel>> quickBook(
      Map<String, dynamic> query) async {
    try {
      final quickBookResponse = await remoteDatasource.quickBook(query);

      if (quickBookResponse.success == true) {
        return DataResult.success(
            QuickBookDto.toDomainModel(quickBookResponse.data));
      }

      throw Exception(quickBookResponse.message);
    } on AppException catch (error, stack) {
      Logger.customLogError("quickBook", error, stack);
      return DataResult.error(error, null);
    }
  }
}
