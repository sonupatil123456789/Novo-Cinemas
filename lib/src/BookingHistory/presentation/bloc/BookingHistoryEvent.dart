part of 'BookingHistoryBloc.dart';

sealed class BookingHistoryEvent extends Equatable {
  const BookingHistoryEvent();

  @override
  List<Object> get props => [];
}

class GetReservationHistoryDetailsEvent extends BookingHistoryEvent {

  const GetReservationHistoryDetailsEvent();

  @override
  List<Object> get props => [];
}




