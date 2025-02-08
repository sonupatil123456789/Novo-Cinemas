
import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';
import '../models/BannerModel.dart';

class GetAllBannersUseCase implements UseCase<DataResult<List<BannerModel>>, EmptyParams>{

  final HomeRepository repository ;
  GetAllBannersUseCase(this.repository);

  @override
  Future<DataResult<List<BannerModel>>> call(EmptyParams params) async {
    return await repository.getAllBanners();
  }



}


