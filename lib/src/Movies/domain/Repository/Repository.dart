
import '../../../../core/resources/DataResult.dart';
import '../../../../entities/models/GetAllMoviesModel.dart';



abstract interface class MoviesRepository{



  Future<DataResult<GetAllMoviesModel>> getAllFilterMovies(String url, Map<String,dynamic> query);



}
