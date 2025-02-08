import 'package:novocinema/src/AncillaryPages/data/dto/AncillaryPagesDto.dart';
import '../../../../core/resources/ResponseData.dart';

abstract interface class AncillaryPagesRemoteDatasource {
  Future<ResponseData<AncillaryPagesDto>> getAncillaryData(String? key);
}
