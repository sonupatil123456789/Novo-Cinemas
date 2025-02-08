
import 'package:novocinema/src/Movies/domain/models/MovieModel.dart';
import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';
import '../models/ShowTimeSessionModel.dart';


class GetAllMoviesWithSessionUseCase implements UseCase<DataResult<ShowTimeSessionModel>, EmptyParams>{


  final ShowTimeRepository repository ;
  GetAllMoviesWithSessionUseCase(this.repository);

  @override
  Future<DataResult<ShowTimeSessionModel>> call(EmptyParams params) async {
   return await repository.getAllMoviesWithSession();
  }



}


