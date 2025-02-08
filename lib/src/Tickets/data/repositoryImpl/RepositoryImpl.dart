



import 'package:novocinema/core/resources/DataResult.dart';

import 'package:novocinema/src/Tickets/data/dto/ReservationDetailsDto.dart';

import '../../../../core/resources/AppException.dart';
import '../../../../core/utils/Logger.dart';
import '../../domain/Repository/Repository.dart';
import '../../domain/models/ReservationDetailsModel.dart';
import '../remote/RemoteDatasource.dart';

class TicketRepositoryImpl implements TicketRepository {
  late final TicketRemoteDatasource remoteDatasource;

  TicketRepositoryImpl(this.remoteDatasource);

  @override
  Future<DataResult<ReservationDetailsModel>> getReservationDetails(String reservationId)async  {

    try {
      final orderResponse = await remoteDatasource.getReservationDetails(reservationId);

      if(orderResponse.success == true){
        return DataResult.success(ReservationDetailsDto.toDomainModel(orderResponse.data));
      }

      throw Exception(orderResponse.message);

    } on AppException catch (error,stack) {
      Logger.customLogError("getReservationDetails", error, stack);
      return DataResult.error(error, null);
    }

  }





  // @override
  // Future<DataResult<ShowTimesDataModel>> createSession(String movieId) async{
  //
  //   try {
  //     final bannerResponse = await remoteDatasource.createSession(movieId);
  //
  //     if(bannerResponse.success == true){
  //
  //       return DataResult.success(ShowTimesDataDto.toDomainModel(bannerResponse.data));
  //     }
  //
  //     throw Exception(bannerResponse.message);
  //
  //   } on AppException catch (error,stack) {
  //     Logger.customLogError("createSession", error, stack);
  //     return DataResult.error(error, null);
  //   }
  //
  // }
  //
  // @override
  // Future<DataResult<MovieModel>> getMovieDetails(String movieId) async {
  //   try {
  //     final bannerResponse = await remoteDatasource.getMovieDetails(movieId);
  //
  //     if (bannerResponse.success == true) {
  //       return DataResult.success(MovieDto.toDomainModel(bannerResponse.data));
  //     }
  //
  //     throw Exception(bannerResponse.message);
  //   } on AppException catch (error, stack) {
  //     Logger.customLogError("getMovieDetails", error, stack);
  //     return DataResult.error(error, null);
  //   }
  // }

}
