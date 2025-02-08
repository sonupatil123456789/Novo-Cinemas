
import 'package:novocinema/core/resources/DataResult.dart';
import 'package:novocinema/src/ShowTime/domain/models/ShowTimeSessionModel.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/enums.dart';
import '../../../../core/utils/Logger.dart';
import '../../domain/Repository/Repository.dart';
import '../dto/ShowTimeSessionDto.dart';
import '../remote/RemoteDatasource.dart';


class ShowTimeRepositoryImpl implements ShowTimeRepository {
  late final ShowTimeRemoteDatasource remoteDatasource;

  ShowTimeRepositoryImpl(this.remoteDatasource);

  @override
  Future<DataResult<ShowTimeSessionModel>> getAllMoviesWithSession() async {
    try {
      final showTimeResponse = await remoteDatasource.getAllMoviesWithSession();

      if (showTimeResponse.success == true) {
        return DataResult.success(ShowTimeSessionDto.toDomainModel(showTimeResponse.data));
      }

      throw AppException(message: showTimeResponse.message, errorCode: ErrorCode.UNKNOWN_ERROR);
    } on AppException catch (error, stack) {
      Logger.customLogError("getAllMoviesWithSession", error, stack);
      return DataResult.error(error, null);
    }
  }




}
