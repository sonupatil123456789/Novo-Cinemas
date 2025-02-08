import 'package:novocinema/src/AncillaryPages/domain/models/AncillaryPagesModel.dart';

import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../Repository/Repository.dart';

class AncillaryPagesUseCase implements UseCase<DataResult<AncillaryPagesModel>, String?> {
  final AncillaryPagesRepository repository;

  AncillaryPagesUseCase(this.repository);

  @override
  Future<DataResult<AncillaryPagesModel>> call(String? params) async {
    return await repository.getAncillaryData(params);
  }
}