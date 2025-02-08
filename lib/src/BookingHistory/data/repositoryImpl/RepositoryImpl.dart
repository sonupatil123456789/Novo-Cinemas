



import 'package:novocinema/core/resources/enums.dart';

import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/DataResult.dart';
import '../../../../core/utils/Logger.dart';
import '../../../Tickets/data/dto/ReservationDetailsDto.dart';
import '../../../Tickets/domain/models/ReservationDetailsModel.dart';
import '../../domain/Repository/Repository.dart';
import '../remote/RemoteDatasource.dart';

class BookingHistoryRepositoryImpl implements BookingHistoryRepository {
  late final BookingHistoryDatasource remoteDatasource;

  BookingHistoryRepositoryImpl(this.remoteDatasource);

  @override
  Future<DataResult<List<ReservationDetailsModel>>> getReservationHistoryDetails() async {

    try {
      final orderResponse = await remoteDatasource.getReservationHistoryDetails();

      if(orderResponse.success == true){
        print(orderResponse.data);
        return DataResult.success(orderResponse.data.map((toElement)=> ReservationDetailsDto.toDomainModel(toElement)).toList());
      }

      throw AppException(message: orderResponse.message, errorCode: ErrorCode.UNKNOWN_ERROR);

    } on AppException catch (error,stack) {
      Logger.customLogError("getReservationHistoryDetails", error, stack);
      return DataResult.error(error, null);
    }


  }




}
