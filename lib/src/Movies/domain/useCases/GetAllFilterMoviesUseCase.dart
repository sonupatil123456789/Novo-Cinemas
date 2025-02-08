
import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../../../../entities/models/GetAllMoviesModel.dart';
import '../Repository/Repository.dart';


class GetAllFilterMoviesUseCase implements UseCase<DataResult<GetAllMoviesModel>, GetAllFilterMoviesParams> {
  final MoviesRepository repository ;
  GetAllFilterMoviesUseCase(this.repository);

  @override
  Future<DataResult<GetAllMoviesModel>> call(GetAllFilterMoviesParams params) async {
    return await repository.getAllFilterMovies(params.url, params.query);
  }




}

class GetAllFilterMoviesParams{
  String url ;
  Map<String,dynamic> query ;

  GetAllFilterMoviesParams(this.url,this.query);
}

