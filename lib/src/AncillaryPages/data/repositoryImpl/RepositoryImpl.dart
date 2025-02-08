import 'package:novocinema/core/resources/DataResult.dart';
import 'package:novocinema/src/AncillaryPages/data/dto/AncillaryPagesDto.dart';
import 'package:novocinema/src/AncillaryPages/domain/models/AncillaryPagesModel.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/utils/Logger.dart';
import '../../domain/Repository/Repository.dart';
import '../remote/RemoteDatasource.dart';

class AncillaryPagesRepositoryImpl implements AncillaryPagesRepository {
  late final AncillaryPagesRemoteDatasource remoteDatasource;

  AncillaryPagesRepositoryImpl(this.remoteDatasource);

  @override
  Future<DataResult<AncillaryPagesModel>> getAncillaryData(String? key) async {
    try {
      final ancillaryPagesResponse =
          await remoteDatasource.getAncillaryData(key);

      if (ancillaryPagesResponse.success == true) {
        AncillaryPagesModel domainData =
            AncillaryPagesDto.toDomainModel(ancillaryPagesResponse.data);
        return DataResult.success(domainData);
      }
      throw Exception(ancillaryPagesResponse.message);
    } on AppException catch (error, stack) {
      Logger.customLogError("ancillaryPagesResponse", error, stack);
      return DataResult.error(error, null);
    }
  }
}
