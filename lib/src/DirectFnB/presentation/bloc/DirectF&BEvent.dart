part of 'DirectF&BBloc.dart';

sealed class DirectFAndBEvent extends Equatable {
  const DirectFAndBEvent();

  @override
  List<Object> get props => [];
}


class OnBookingIdChanged extends DirectFAndBEvent {
  final String bookingId;
  const OnBookingIdChanged(this.bookingId);

  @override
  List<Object> get props => [bookingId];
}


class GetAllUpcomingBookingsEvent extends DirectFAndBEvent {
  const GetAllUpcomingBookingsEvent();

  @override
  List<Object> get props => [];
}

class GetUpcomingBookingsDetailsEvent extends DirectFAndBEvent {
  final Function(ReservationDetailsModel) onSuccess ;
  final Function(AppException) onFailure;

  const GetUpcomingBookingsDetailsEvent({required this.onSuccess,required this.onFailure});

  @override
  List<Object> get props => [onSuccess,onFailure];
}

class SelectedUpcomingBooking extends DirectFAndBEvent {
  final ReservationDetailsModel upcomingBooking;
  final Function callback ;
  const SelectedUpcomingBooking({required this.upcomingBooking,required this.callback});

  @override
  List<Object> get props => [upcomingBooking,callback];
}

class SelectedCinemaLocation extends DirectFAndBEvent {
  final CinemaLocationModel cinemaLocation;
  const SelectedCinemaLocation({required this.cinemaLocation});

  @override
  List<Object> get props => [cinemaLocation];
}

class OnBookingIdError extends DirectFAndBEvent {
  final String errorMessage;
  const OnBookingIdError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

