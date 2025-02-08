import 'package:novocinema/src/Home/domain/models/BannerModel.dart';
import 'package:novocinema/src/Home/domain/models/QuickBookModel.dart';

import '../../../../core/resources/DataResult.dart';
import '../../../../entities/models/GetAllMoviesModel.dart';


abstract interface class HomeRepository{

  Future<DataResult<List<BannerModel>>> getAllBanners();

  Future<DataResult<QuickBookModel>> quickBook(Map<String,dynamic> query);

}
