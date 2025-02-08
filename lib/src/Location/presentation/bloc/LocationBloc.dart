import 'dart:async';
import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/src/Cinema-Experience/presentation/bloc/cinema_experience_bloc.dart';
import 'package:novocinema/src/Cinema-Experience/presentation/bloc/cinema_experience_event.dart';
import 'package:novocinema/src/Location/domain/models/CinemaLocationModel.dart';

import 'package:novocinema/src/Location/domain/models/cityModel.dart';
import 'package:novocinema/src/Location/domain/useCases/CinemaLocationUseCase.dart';
import 'package:novocinema/src/Location/domain/useCases/CityUseCase.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../../../../core/resources/enums.dart';

part 'LocationEvent.dart';
part 'LocationState.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetAllCinemaLocationUseCase getAllCinemaLocationUseCase;
  final GetAllCitiesUseCase getAllCitiesUseCase;

  LocationBloc(
    this.getAllCinemaLocationUseCase,
    this.getAllCitiesUseCase,
  ) : super(LocationState()) {
    on<GetAllCinemaLocationEvent>(_getAllCinemaLocationEvent);
    on<GetAllCitiesEvent>(_getAllCitiesEvent);
    on<CitySelectedEvent>(_onCitySelected);
    on<CinemaSelectionEvent>(_onCinemaSelected);
    on<ClearSelectionEvent>(_onClearSelection);
  }

  void _onClearSelection(
      ClearSelectionEvent event, Emitter<LocationState> emit) {
    emit(state.copyWith(
      selectedCity: null,
      selectedCinema: null,
      cityId: null,
      cities: null,
      filteredCinemaLocations: [],
    ));
  }

  FutureOr<void> _getAllCinemaLocationEvent(
      GetAllCinemaLocationEvent event, Emitter<LocationState> emit) async {
    emit(state.copyWith(cinemaLocationState: CurrentAppState.LOADING));
    final cinemaLocationData =
        await getAllCinemaLocationUseCase.call(event.cityId);
    switch (cinemaLocationData) {
      case Success<List<CinemaLocationModel>>():
        emit(state.copyWith(
          cinemaLocationState: CurrentAppState.SUCCESS,
          cinemaLocations: cinemaLocationData.data,
          filteredCinemaLocations: cinemaLocationData.data,
        ));
        event.callback();

      case Error<List<CinemaLocationModel>>():
        emit(state.copyWith(
            cinemaLocationState: CurrentAppState.ERROR,
            appException: cinemaLocationData.exception));
    }
  }

  FutureOr<void> _getAllCitiesEvent(
      GetAllCitiesEvent event, Emitter<LocationState> emit) async {
    emit(state.copyWith(cityState: CurrentAppState.LOADING));

    final cityData = await getAllCitiesUseCase.call(EmptyParams());

    switch (cityData) {
      case Success<List<CityModel>>():
        final cities = cityData.data;
        if (cities.isNotEmpty) {
          final defaultCity = cities.first;

          emit(state.copyWith(
            cityState: CurrentAppState.SUCCESS,
            cities: cities,
            selectedCity: defaultCity.cityName ?? "",
            cityId: defaultCity.cityId,
          ));

          add(
            GetAllCinemaLocationEvent(
              cityId: defaultCity.cityId.toString(),
              callback: () {},
            ),
          );
        } else {
          emit(state.copyWith(cityState: CurrentAppState.SUCCESS, cities: []));
        }
        break;

      case Error<List<CityModel>>():
        emit(state.copyWith(
          cityState: CurrentAppState.ERROR,
          appException: cityData.exception,
        ));
        break;
    }
  }

  FutureOr<void> _onCitySelected(
      CitySelectedEvent event, Emitter<LocationState> emit) async {
    emit(state.copyWith(
      cityId: event.cityId,
      selectedCity: event.cityName,
    ));

    await _getCinemaLocationsByCity(event.cityId.toString(), emit);
  }

  FutureOr<void> _onCinemaSelected(
      CinemaSelectionEvent event, Emitter<LocationState> emit) async {
    emit(state.copyWith(selectedCinema: event.cinemaName));
  }

  Future<void> _getCinemaLocationsByCity(
      String? cityId, Emitter<LocationState> emit) async {
    emit(state.copyWith(cinemaLocationState: CurrentAppState.LOADING));

    final cinemaLocationData = await getAllCinemaLocationUseCase.call(cityId);

    switch (cinemaLocationData) {
      case Success<List<CinemaLocationModel>>():
        emit(state.copyWith(
          cinemaLocationState: CurrentAppState.SUCCESS,
          filteredCinemaLocations: cinemaLocationData.data,
        ));
      case Error<List<CinemaLocationModel>>():
        emit(state.copyWith(
          cinemaLocationState: CurrentAppState.ERROR,
          appException: cinemaLocationData.exception,
        ));
    }
  }
}
