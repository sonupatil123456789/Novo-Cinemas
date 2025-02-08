part of 'SeatLayoutBloc.dart';

sealed class SeatLayoutEvent extends Equatable {
  const SeatLayoutEvent();


  @override
  List<Object> get props => [];
}

class GetSeatLayoutEvent extends SeatLayoutEvent {
  final String cinemaId;
  final String sessionId;

  const GetSeatLayoutEvent(this.sessionId, this.cinemaId);

  @override
  List<Object> get props => [];
}

class ExtendSeatBookingTimerEvent extends SeatLayoutEvent {
  final String reservationId ;
  final Function(String) onSuccess ;
  final Function(AppException) onFailure ;

  const ExtendSeatBookingTimerEvent(
      {required this.reservationId, required this.onFailure, required this.onSuccess});

  @override
  List<Object> get props => [reservationId,onFailure,onSuccess];
}



class OnSeatSelected extends SeatLayoutEvent {
  final SeatModel selectedSeat;
  final String areaCategoryCode;
  final String rowName ;
  final String seatName ;
  final String ticketTypeCode ;
  final String areaName ;
  final num priceInCents ;
  const OnSeatSelected(this.selectedSeat, this.areaCategoryCode , this.rowName , this.seatName , this.ticketTypeCode , this.priceInCents,this.areaName);

  @override
  List<Object> get props => [selectedSeat,areaCategoryCode, rowName,seatName,ticketTypeCode ,priceInCents,areaName];
}



class BookSelectedSeatsEvent extends SeatLayoutEvent {
  final Map<String,dynamic> confirmationDetails;
  final Function(String) onSuccess ;
  final MovieSelectionType movieSelectionType ;
  final Function(AppException) onFailure ;

  const BookSelectedSeatsEvent({required this.confirmationDetails,required this.onSuccess, required this.onFailure , required this.movieSelectionType});

  @override
  List<Object> get props => [confirmationDetails,onFailure,onSuccess,movieSelectionType];
}

class ClearSeatStateEvent extends SeatLayoutEvent {
  const ClearSeatStateEvent();
}

