
import 'package:novocinema/core/resources/DataResult.dart';
import 'package:novocinema/core/resources/enums.dart';
import 'package:novocinema/src/SeatLayout/data/dto/SeatLayoutDto.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/utils/Logger.dart';
import '../../domain/Repository/Repository.dart';
import '../../domain/models/SeatLayoutModel.dart';
import '../remote/RemoteDatasource.dart';


class SeatLayoutRepositoryImpl implements SeatLayoutRepository {
  late final SeatLayoutRemoteDatasource remoteDatasource;

  SeatLayoutRepositoryImpl(this.remoteDatasource);

  @override
  Future<DataResult<SeatLayoutModel>> getSeatLayout(String cinemaId, String sessionId) async {

    try {
      final seatLayoutResponse = await remoteDatasource.getSeatLayout(cinemaId, sessionId);

      if(seatLayoutResponse.success == true){
        return DataResult.success(SeatLayoutDto.toDomainModel(seatLayoutResponse.data));
      }

      throw AppException(message: seatLayoutResponse.message, errorCode: ErrorCode.UNKNOWN_ERROR);

    } on AppException catch (error,stack) {
      Logger.customLogError("getSeatLayout", error, stack);
      return DataResult.error(error, null);
    }

  }




  @override
  Future<DataResult<String>> bookSelectedSeats(Map<String, dynamic> seatData) async {

    try {
      final reservationResponse = await remoteDatasource.bookSelectedSeats(seatData);

      if(reservationResponse.success == true){
        return DataResult.success(reservationResponse.data['reservationId']);
      }


      throw AppException(message: reservationResponse.message, errorCode: ErrorCode.UNKNOWN_ERROR);

    } on AppException catch (error,stack) {
      Logger.customLogError("bookSelectedSeats", error, stack);
      return DataResult.error(error, null);
    }

  }

  @override
  Future<DataResult<Map<String, dynamic>>> extendSeatBookingTimer(String reservationId) async{

    try {
      final extendTimerResponse = await remoteDatasource.extendSeatBookingTimer(reservationId);

      if(extendTimerResponse.success == true){
        return DataResult.success(extendTimerResponse.data);
      }

      throw AppException(message: extendTimerResponse.message, errorCode: ErrorCode.UNKNOWN_ERROR);

    } on AppException catch (error,stack) {
      Logger.customLogError("extendSeatBookingTimer", error, stack);
      return DataResult.error(error, null);
    }
  }




}
