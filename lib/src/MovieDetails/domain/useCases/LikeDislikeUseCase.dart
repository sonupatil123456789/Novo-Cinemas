


import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';

class LikeDislikeUseCase implements UseCase<DataResult<Map<String,dynamic>>, LikeDislikeParams> {
  final MovieDetailsRepository repository ;
  LikeDislikeUseCase(this.repository);

  @override
  Future<DataResult<Map<String, dynamic>>> call(LikeDislikeParams params) async{
    return await repository.likeDislike(params.data, params.url);
  }

}



class LikeDislikeParams{

  String url;
  Map<String,dynamic>data ;
  LikeDislikeParams(this.data,this.url);

}