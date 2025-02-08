part of 'UserProfileBloc.dart';

sealed class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class SetSettingsChanged extends UserProfileEvent {
  final int settings;
  const SetSettingsChanged(this.settings);

  @override
  List<Object> get props => [settings];
}


class GetReservationDetailsEvent extends UserProfileEvent {
  final String reservationId ;

  const GetReservationDetailsEvent(this.reservationId);

  @override
  List<Object> get props => [reservationId];
}



