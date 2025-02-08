
import 'package:novocinema/src/ShowTime/domain/models/ShowTimeSessionModel.dart';
import '../../../../core/resources/DataResult.dart';



abstract interface class ShowTimeRepository{


  Future<DataResult<ShowTimeSessionModel>> getAllMoviesWithSession();



}
