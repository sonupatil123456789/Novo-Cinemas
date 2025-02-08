part of 'DashboardBloc.dart';

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

// class SetSettingsChanged extends DashboardEvent {
//   final int settings;
//   const SetSettingsChanged(this.settings);
//
//   @override
//   List<Object> get props => [settings];
// }
//
//
// class GetReservationDetailsEvent extends DashboardEvent {
//   final String reservationId ;
//
//   const GetReservationDetailsEvent(this.reservationId);
//
//   @override
//   List<Object> get props => [reservationId];
// }



