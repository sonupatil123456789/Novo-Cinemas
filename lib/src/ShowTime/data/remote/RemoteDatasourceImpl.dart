import 'package:novocinema/core/constants/ApiUrlConstants.dart';
import 'package:novocinema/core/resources/ResponseData.dart';
import '../../../../core/restServices/BaseApi.dart';
import '../../../../core/utils/Logger.dart';
import '../dto/ShowTimeSessionDto.dart';
import 'RemoteDatasource.dart';


class ShowTimeRemoteDatasourceImpl implements ShowTimeRemoteDatasource {
  late final BaseApi responseData;

  ShowTimeRemoteDatasourceImpl(this.responseData);

  @override
  Future<ResponseData<ShowTimeSessionDto>> getAllMoviesWithSession() async {
    try {
      final response = await responseData.get(ApiUrlConstants.getAllMoviesWithSession, null, null);

      ResponseData<ShowTimeSessionDto> dtoResponse =
      ResponseData<ShowTimeSessionDto>.fromJson(response.data, (value) {
        return value != null ? ShowTimeSessionDto.fromJson(value) : ShowTimeSessionDto.fromJson(const <String,dynamic>{});
      });

      Logger.customLogData("getAllMoviesWithSession", dtoResponse.toString());
      return dtoResponse;
    } on Exception catch (error) {
      rethrow;
    }
  }


}
