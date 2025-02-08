part of 'UserProfileBloc.dart';

class UserProfileState extends Equatable {
  final ReservationDetailsModel? reservationDetails;
  final CurrentAppState loading;
  final AppException? appException;
  final int selectedSetting;

  const UserProfileState(
      {this.reservationDetails,
      this.loading = CurrentAppState.INITIAL,
      this.selectedSetting = 0,
      this.appException});

  UserProfileState copyWith(
      {AppException? appException,
      int? selectedSetting,
      ReservationDetailsModel? reservationDetails,
      CurrentAppState? loading}) {
    return UserProfileState(
        reservationDetails: reservationDetails ?? this.reservationDetails,
        appException: appException ?? this.appException,
        selectedSetting: selectedSetting ?? this.selectedSetting,
        loading: loading ?? this.loading);
  }

  @override
  List<Object?> get props =>
      [reservationDetails, loading, appException, selectedSetting];
}
