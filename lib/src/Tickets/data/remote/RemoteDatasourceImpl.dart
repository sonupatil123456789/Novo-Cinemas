import 'package:novocinema/core/resources/ResponseData.dart';
import '../../../../core/constants/ApiUrlConstants.dart';
import '../../../../core/restServices/BaseApi.dart';
import '../../../../core/utils/Logger.dart';
import '../dto/ReservationDetailsDto.dart';
import 'RemoteDatasource.dart';

class TicketRemoteDatasourceImpl implements TicketRemoteDatasource {
  late final BaseApi responseData;

  TicketRemoteDatasourceImpl(this.responseData);

  @override
  Future<ResponseData<ReservationDetailsDto>> getReservationDetails(
      String reservationId) async {
    try {
      final response = await responseData.get(
          ApiUrlConstants.getReservationDetails + reservationId, null, null);

      ResponseData<ReservationDetailsDto> dtoResponse =
          ResponseData<ReservationDetailsDto>.fromJson(response.data, (value) {
        return value != null
            ? ReservationDetailsDto.fromJson(value)
            : ReservationDetailsDto.fromJson(const <String, dynamic>{});
      });

      Logger.customLogData("getReservationDetails", dtoResponse.toString());
      return dtoResponse;
    } on Exception catch (error) {
      rethrow;
    }
  }
}
