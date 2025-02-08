
import 'package:novocinema/src/Movies/domain/models/MovieModel.dart';
import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';


class GetMovieDetailsUseCase implements UseCase<DataResult<MovieModel>, String>{

  final MovieDetailsRepository repository ;
  GetMovieDetailsUseCase(this.repository);

  @override
  Future<DataResult<MovieModel>> call(String movieId) {
    return repository.getMovieDetails(movieId);
  }


}


