part of 'TicketBloc.dart';

class TicketState extends Equatable {
  final ReservationDetailsModel? reservationDetails;
  final CurrentAppState loading;
  final AppException? appException;

  const TicketState(
      {this.reservationDetails,
      this.loading = CurrentAppState.INITIAL,
      this.appException});

  TicketState copyWith(
      {AppException? appException,
      ReservationDetailsModel? reservationDetails,
      CurrentAppState? loading}) {
    return TicketState(
        reservationDetails: reservationDetails ?? this.reservationDetails,
        appException: appException ?? this.appException,
        loading: loading ?? this.loading);
  }

  @override
  List<Object?> get props => [reservationDetails, loading, appException];
}
