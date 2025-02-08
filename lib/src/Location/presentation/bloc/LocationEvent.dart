part of 'LocationBloc.dart';

sealed class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class GetAllCinemaLocationEvent extends LocationEvent {
  final String? cityId;
  final Function() callback;

  const GetAllCinemaLocationEvent(
      {required this.cityId, required this.callback});

  @override
  List<Object> get props => [cityId ?? "", callback];
}

class GetAllCitiesEvent extends LocationEvent {}

class ClearSelectionEvent extends LocationEvent {}

class CitySelectedEvent extends LocationEvent {
  final int cityId;
  final String? cityName;

  const CitySelectedEvent(this.cityId, this.cityName);

  @override
  List<Object> get props => [cityId, cityName ?? ""];
}

class CinemaSelectionEvent extends LocationEvent {
  final int cinemaId;
  final String? cinemaName;

  const CinemaSelectionEvent(this.cinemaId, this.cinemaName);

  @override
  List<Object> get props => [cinemaId, cinemaName ?? ""];
}
