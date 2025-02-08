part of 'LocationBloc.dart';

class LocationState extends Equatable {
  final CurrentAppState cinemaLocationState;
  final CurrentAppState cityState;
  final AppException? appException;
  final List<CinemaLocationModel> cinemaLocations;
  final List<CinemaLocationModel> filteredCinemaLocations;
  final List<CityModel> cities;
  final String? selectedCity;
  final String? slectedCinema;
  final int? cityId;

  LocationState({
    this.cinemaLocations = const [],
    this.filteredCinemaLocations = const [],
    this.cities = const [],
    this.selectedCity,
    this.slectedCinema,
    this.cityId,
    this.cinemaLocationState = CurrentAppState.INITIAL,
    this.cityState = CurrentAppState.INITIAL,
    this.appException,
  });

  LocationState copyWith({
    AppException? appException,
    CurrentAppState? cinemaLocationState,
    CurrentAppState? cityState,
    List<CinemaLocationModel>? cinemaLocations,
    List<CinemaLocationModel>? filteredCinemaLocations,
    List<CityModel>? cities,
    String? selectedCity,
    String? selectedCinema,
    int? cityId,
  }) {
    return LocationState(
      appException: appException ?? this.appException,
      cinemaLocationState: cinemaLocationState ?? this.cinemaLocationState,
      cityState: cityState ?? this.cityState,
      cinemaLocations: cinemaLocations ?? this.cinemaLocations,
      filteredCinemaLocations:
          filteredCinemaLocations ?? this.filteredCinemaLocations,
      cities: cities ?? this.cities,
      selectedCity: selectedCity ?? this.selectedCity,
      slectedCinema: selectedCinema ?? this.slectedCinema,
      cityId: cityId ?? this.cityId,
    );
  }

  @override
  List<Object?> get props => [
        cinemaLocationState,
        cityState,
        appException,
        cinemaLocations,
        filteredCinemaLocations,
        cities,
        selectedCity,
        slectedCinema,
        cityId,
      ];
}
