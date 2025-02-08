part of 'TicketBloc.dart';

sealed class TicketEvent extends Equatable {
  const TicketEvent();

  @override
  List<Object> get props => [];
}




class GetReservationDetailsEvent extends TicketEvent {
  final String reservationId ;

  const GetReservationDetailsEvent(this.reservationId);

  @override
  List<Object> get props => [reservationId];
}



