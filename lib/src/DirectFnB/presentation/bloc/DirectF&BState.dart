part of 'DirectF&BBloc.dart';

class DirectFAndBState extends Equatable {
  final CurrentAppState loading;
  final CurrentAppState upcomingBookingDetailsState;
  final AppException? appException;
  final String? bookingId;
  final ReservationDetailsModel? selectedReservationDetail;
  final List<ReservationDetailsModel>? upcomingBookings;
  final CinemaLocationModel? selectedCinemaLocation;
  final String bookingIDError;

  const DirectFAndBState(
      {this.bookingIDError = '',
      this.loading = CurrentAppState.INITIAL,
      this.upcomingBookingDetailsState = CurrentAppState.INITIAL,
      this.bookingId = '',
      this.upcomingBookings = const [],
      this.selectedReservationDetail,
      this.appException,
      this.selectedCinemaLocation});

  DirectFAndBState copyWith(
      {AppException? appException,
      CurrentAppState? upcomingBookingDetailsState,
      String? bookingId,
      ReservationDetailsModel? selectedReservationDetail,
      List<ReservationDetailsModel>? upcomingBookings,
      CinemaLocationModel? selectedCinemaLocation,
      CurrentAppState? loading,
      String? bookingIDError}) {
    return DirectFAndBState(
        upcomingBookingDetailsState:
            upcomingBookingDetailsState ?? this.upcomingBookingDetailsState,
        bookingId: bookingId ?? this.bookingId,
        selectedReservationDetail:
            selectedReservationDetail ?? this.selectedReservationDetail,
        appException: appException ?? this.appException,
        upcomingBookings: upcomingBookings ?? this.upcomingBookings,
        selectedCinemaLocation:
            selectedCinemaLocation ?? this.selectedCinemaLocation,
        loading: loading ?? this.loading,
        bookingIDError: bookingIDError ?? this.bookingIDError);
  }

  @override
  List<Object?> get props => [
        loading,
        appException,
        bookingId,
        upcomingBookings,
        selectedReservationDetail,
        upcomingBookingDetailsState,
        selectedCinemaLocation,
        bookingIDError
      ];
}
