import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:novocinema/core/resources/DataResult.dart';
import 'package:novocinema/core/resources/enums.dart';
import 'package:novocinema/src/SeatLayout/domain/useCases/GetSeatLayoutUseCase.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/utils/Logger.dart';
import '../../domain/models/SeatLayoutModel.dart';
import '../../domain/models/SeatModel.dart';
import '../../domain/useCases/BookSelectedSeatsUseCase.dart';
import '../../domain/useCases/ExtendSeatBookingTimerUseCase.dart';
import '../screens/SeatLayoutScreen.dart';
part 'SeatLayoutEvent.dart';
part 'SeatLayoutState.dart';

class SeatLayoutBloc extends Bloc<SeatLayoutEvent, SeatLayoutState> {
  final  GetSeatLayoutUseCase getSeatLayoutUseCase ;
  final  BookSelectedSeatsUseCase bookSelectedSeatsUseCase ;
  final ExtendSeatBookingTimerUseCase extendSeatBookingTimerUseCase;


  SeatLayoutBloc(this.getSeatLayoutUseCase,this. bookSelectedSeatsUseCase,this.extendSeatBookingTimerUseCase) : super(const SeatLayoutState()) {

    on<GetSeatLayoutEvent>(_getSeatLayoutEvent);
    on<OnSeatSelected>(_onSeatSelected);
    on<ClearSeatStateEvent>(_clearSeatStateEvent);
    on<BookSelectedSeatsEvent>(_bookSelectedSeatsEvent);
    on<ExtendSeatBookingTimerEvent>(_extendSeatBookingTimerEvent);


  }

  _extendSeatBookingTimerEvent(ExtendSeatBookingTimerEvent event , Emitter<SeatLayoutState> emit)async{
    emit(state.copyWith(extendTimerState: CurrentAppState.LOADING));
    final data = await  extendSeatBookingTimerUseCase.call(event.reservationId);
    switch(data) {
      case Success<Map<String, dynamic>>():
        emit(state.copyWith(extendTimerState: CurrentAppState.SUCCESS));
        event.onSuccess(event.reservationId);
      case Error<Map<String, dynamic>>():
        emit(state.copyWith(extendTimerState: CurrentAppState.ERROR,appException: data.exception));
        event.onFailure(data.exception);
    }
  }

  _clearSeatStateEvent(ClearSeatStateEvent event , Emitter<SeatLayoutState> emit){
    emit(state.copyWith(seatConfirmationDetails: {} ,selectedSeat: [] ,bookSelectedSeat: [],seatLayout: null));
    Logger.customLogData("Seat Confirmation Details (SeatsLayoutScreen)", state.seatConfirmationDetails );
  }


  _getSeatLayoutEvent(GetSeatLayoutEvent event , Emitter<SeatLayoutState> emit)async{
    emit(state.copyWith(loading: CurrentAppState.LOADING));
    final data = await  getSeatLayoutUseCase.call(GetSeatLayoutParams(event.sessionId, event.cinemaId));

    switch(data) {
      case Success<SeatLayoutModel>():
        emit(state.copyWith(loading: CurrentAppState.SUCCESS,seatLayout: data.data));
      case Error<SeatLayoutModel>():
        emit(state.copyWith(loading: CurrentAppState.ERROR,appException: data.exception));

    }
  }

  _bookSelectedSeatsEvent(BookSelectedSeatsEvent event , Emitter<SeatLayoutState> emit)async {

    // Step 1: generating seat according to  AreaName
    Map<String,List<Map<String,dynamic>>> selectedMovieSeatsMap = {};
    for (var seat in state.bookSelectedSeat) {
      String areaName = seat["AreaName"];
      if(selectedMovieSeatsMap.containsKey(areaName) == true){
        selectedMovieSeatsMap[areaName]?.add(seat);
      }else{
        selectedMovieSeatsMap[areaName] = [...?selectedMovieSeatsMap[areaName],seat ];
      }
    }


    // Step 2: Calculate TicketTypes
    Map<String, Map<String, dynamic>> ticketTypeMap = {};

    for (var seat in state.bookSelectedSeat) {
      String ticketTypeCode = seat["TicketTypeCode"];
      if (!ticketTypeMap.containsKey(ticketTypeCode)) {
        ticketTypeMap[ticketTypeCode] = {
          "TicketTypeCode": ticketTypeCode,
          "Qty": 0,
          // "PriceInCents": 0
        };
      }
      ticketTypeMap[ticketTypeCode]!["Qty"] += 1;
      // ticketTypeMap[ticketTypeCode]!["PriceInCents"] += seat["PriceInCents"];
    }

    List<Map<String, dynamic>> ticketTypes = ticketTypeMap.values.toList();

    emit(state.copyWith(seatConfirmationDetails: {
      ...event.confirmationDetails,
      "SelectedSeats": state.bookSelectedSeat,
      "TicketTypes": ticketTypes,
      "selectedMovieSeatsMap": selectedMovieSeatsMap
    },bookSelectedSeatState: CurrentAppState.LOADING));


    final bokSelectedSeatData =  await bookSelectedSeatsUseCase.call(state.seatConfirmationDetails);

    switch(bokSelectedSeatData) {
      case Success<String>():
        emit(state.copyWith(bookSelectedSeatState: CurrentAppState.SUCCESS, reservationId: bokSelectedSeatData.data,movieSelectionType: event.movieSelectionType));
        event.onSuccess(bokSelectedSeatData.data);
      case Error<String>():
        emit(state.copyWith(bookSelectedSeatState: CurrentAppState.ERROR, appException:bokSelectedSeatData.exception ));
        event.onFailure(bokSelectedSeatData.exception);
    }
  }

  _onSeatSelected(OnSeatSelected event , Emitter<SeatLayoutState> emit){
      final newList = [...state.selectedSeat];
      final bookingList = [...state.bookSelectedSeat];
      if(newList.contains(event.selectedSeat) ||state.selectedSeat.length > 9 ){
        newList.remove(event.selectedSeat);
        bookingList.removeWhere((map) =>
        map['AreaCategoryCode'] == event.areaCategoryCode &&
            map['AreaName'] == event.areaName &&
            map['RowName'] == event.rowName &&
            map['SeatName'] == event.seatName &&
            map['AreaNumber'] == event.selectedSeat.position?.areaNumber &&
            map['RowIndex'] == event.selectedSeat.position?.rowIndex &&
            map['ColumnIndex'] == event.selectedSeat.position?.columnIndex &&
            map['TicketTypeCode'] == event.ticketTypeCode &&
            map['PriceInCents'] == event.priceInCents
        );
      }else {
        newList.add(event.selectedSeat);
        bookingList.add(<String,dynamic>{
          'AreaName' : event.areaName,
          'AreaCategoryCode' : event.areaCategoryCode,
          'RowName': event.rowName,
          'SeatName': event.seatName,
          'AreaNumber': event.selectedSeat.position?.areaNumber,
          'RowIndex': event.selectedSeat.position?.rowIndex,
          'ColumnIndex': event.selectedSeat.position?.columnIndex,
          'TicketTypeCode' : event.ticketTypeCode,
          'PriceInCents' : event.priceInCents,
        });
      }
      emit(state.copyWith(selectedSeat:newList , bookSelectedSeat: bookingList,));

      Logger.customLogData("Selected Seat ${newList.length}", newList );
    }

}
