


import 'package:novocinema/core/resources/DataResult.dart';

import '../../../../core/resources/AppException.dart';
import '../../../../core/utils/Logger.dart';
import '../../domain/Repository/Repository.dart';
import '../remote/RemoteDatasource.dart';

class OrderConfirmationRepositoryImpl implements OrderConfirmationRepository {
  late final OrderConfirmationRemoteDatasource remoteDatasource;

  OrderConfirmationRepositoryImpl(this.remoteDatasource);

  @override
  Future<DataResult<Map<String, dynamic>>> completeOrder(String reservationId) async{
    try {
      final orderResponse = await remoteDatasource.completeOrder(reservationId);

      if(orderResponse.success == true){
        return DataResult.success(orderResponse.data);
      }

      throw Exception(orderResponse.message);

    } on AppException catch (error,stack) {
      Logger.customLogError("completeOrder", error, stack);
      return DataResult.error(error, null);
    }
  }

  @override
  Future<DataResult> cancelFAndB(String reservationId) async{
    try {
      final cancelOrderResponse = await remoteDatasource.cancelFAndB(reservationId);

      if(cancelOrderResponse.success == true){
        return DataResult.success(cancelOrderResponse.data);
      }

      throw Exception(cancelOrderResponse.message);

    } on AppException catch (error,stack) {
      Logger.customLogError("cancelFAndB", error, stack);
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
