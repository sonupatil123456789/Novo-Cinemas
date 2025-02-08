
import 'package:novocinema/core/resources/enums.dart';

import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/DataResult.dart';
import '../../../../core/utils/Logger.dart';
import '../../../Tickets/data/dto/ReservationDetailsDto.dart';
import '../../../Tickets/domain/models/ReservationDetailsModel.dart';
import '../../domain/Repository/Repository.dart';
import '../remote/RemoteDatasource.dart';

class DirectFAndBRepositoryImpl implements DirectFAndBRepository {
  late final DirectFAndBDatasource remoteDatasource;

  DirectFAndBRepositoryImpl(this.remoteDatasource);

  @override
  Future<DataResult<ReservationDetailsModel>> getUpcomingBookingsDetails(String bookingId)async  {

    try {
      final upcomingBookingResponse = await remoteDatasource.getUpcomingBookingsDetails(bookingId);

      if(upcomingBookingResponse.success == true){
        return DataResult.success(ReservationDetailsDto.toDomainModel(upcomingBookingResponse.data));
      }

      throw AppException(errorCode: ErrorCode.UNKNOWN_ERROR, message: upcomingBookingResponse.message);

    } on AppException catch (error,stack) {
      Logger.customLogError("getUpcomingBookingsDetails", error, stack);
      return DataResult.error(error, null);
    }

  }






  @override
  Future<DataResult<List<ReservationDetailsModel>>> getAllUpcomingBookings() async {
    try {
      final orderResponse = await remoteDatasource.getAllUpcomingBookings();

      if (orderResponse.success == true) {
        return DataResult.success(orderResponse.data.map((toElement) =>
            ReservationDetailsDto.toDomainModel(toElement)).toList());
      }

      throw AppException(
          message: orderResponse.message, errorCode: ErrorCode.UNKNOWN_ERROR);
    } on AppException catch (error, stack) {
      Logger.customLogError("getAllUpcomingBookings", error, stack);
      return DataResult.error(error, null);
    }
  }


}
