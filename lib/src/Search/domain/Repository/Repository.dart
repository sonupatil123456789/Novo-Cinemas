
import 'package:novocinema/src/Search/domain/models/SearchModel.dart';
import '../../../../core/resources/DataResult.dart';


abstract interface class SearchRepository{

  Future<DataResult<SearchModel>> search(String search);

}
