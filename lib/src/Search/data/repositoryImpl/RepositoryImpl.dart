

import 'package:novocinema/core/resources/DataResult.dart';
import 'package:novocinema/src/Search/data/dto/SearchDto.dart';
import 'package:novocinema/src/Search/data/remote/RemoteDatasource.dart';

import 'package:novocinema/src/Search/domain/models/SearchModel.dart';

import '../../../../core/resources/AppException.dart';
import '../../../../core/utils/Logger.dart';
import '../../domain/Repository/Repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  late final SearchRemoteDatasource remoteDatasource;

  SearchRepositoryImpl(this.remoteDatasource);

  @override
  Future<DataResult<SearchModel>> search(String search) async {

    try {
      final searchResponse = await remoteDatasource.search(search);

      if(searchResponse.success == true){
        return DataResult.success(SearchDto.toDomainModel(searchResponse.data));
      }

      throw Exception(searchResponse.message);

    } on AppException catch (error,stack) {
      Logger.customLogError("search", error, stack);
      return DataResult.error(error, null);
    }

  }







}
