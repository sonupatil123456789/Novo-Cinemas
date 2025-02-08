
import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../../presentation/bloc/MovieDetailsBloc.dart';
import '../Repository/Repository.dart';
import '../models/GetSessionModel.dart';


class CreateSessionUseCase implements UseCase<DataResult<GetSessionModel>, GetSessionParams> {
  final MovieDetailsRepository repository ;
  CreateSessionUseCase(this.repository);

  @override
  Future<DataResult<GetSessionModel>> call(GetSessionParams params) async {
    return await repository.createSession(params.movieId,params.sessionDate,params.pageType);
  }
}

class GetSessionParams {
  final String movieId;
  final String sessionDate;
  final DetailPageType pageType;


  GetSessionParams(this.movieId,  this.sessionDate , this.pageType,);

}

