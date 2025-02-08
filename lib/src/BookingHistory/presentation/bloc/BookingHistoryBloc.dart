

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/core/resources/DataResult.dart';
import 'package:novocinema/core/resources/UseCase.dart';
import 'package:novocinema/src/Tickets/domain/models/ReservationDetailsModel.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/enums.dart';
import '../../../../core/utils/DateFormater.dart';
import '../../domain/useCases/GetReservationHistoryDetailsUseCase.dart';
part 'BookingHistoryEvent.dart';
part 'BookingHistoryState.dart';

class BookingHistoryBloc extends Bloc<BookingHistoryEvent, BookingHistoryState> {

  final GetReservationHistoryDetailsUseCase getReservationHistoryDetailsUseCase;

  BookingHistoryBloc(this.getReservationHistoryDetailsUseCase): super(const BookingHistoryState()) {
    on<GetReservationHistoryDetailsEvent>(_getReservationHistoryDetailsEvent);
  }

  // _setSettingsChanged(SetSettingsChanged event,Emitter<UserProfileState> emit)  {
  //   emit(state.copyWith(selectedSetting: event.settings));
  // }



  _getReservationHistoryDetailsEvent(GetReservationHistoryDetailsEvent event,Emitter<BookingHistoryState> emit) async {
    emit(state.copyWith(loading: CurrentAppState.LOADING));
    final bookingHistoryData = await getReservationHistoryDetailsUseCase.call(EmptyParams());

    switch (bookingHistoryData) {
      case Success<List<ReservationDetailsModel>>():

         List<ReservationDetailsModel> resentBookingList = [];
         List<ReservationDetailsModel> pastBookingList = [];


        for(var item in bookingHistoryData.data){
          if(isDateTimeBeforeToday(item.showDateTime.toString() ?? '') == true){
            pastBookingList.add(item);
          }else{
            resentBookingList.add(item);
          }
        }

        emit(state.copyWith(loading: CurrentAppState.SUCCESS,bookingHistory:bookingHistoryData.data, pastBookingList: pastBookingList, resentBookingList: resentBookingList ));
      case Error<List<ReservationDetailsModel>>():
        emit(state.copyWith(loading: CurrentAppState.ERROR,appException: bookingHistoryData.exception));
    }
  }
}

