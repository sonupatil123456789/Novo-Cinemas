import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/src/Cinema-Experience/domain/Usecases/GetCinemaExperiencesUseCase.dart';
import 'package:novocinema/src/Cinema-Experience/domain/models/cinemaexperience.dart';
import 'package:novocinema/src/Cinema-Experience/presentation/bloc/cinema_experience_event.dart';

import 'package:novocinema/src/Cinema-Experience/presentation/bloc/cinema_experience_state.dart';

import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/enums.dart';
import 'package:equatable/equatable.dart';

class CinemaExperienceBloc
    extends Bloc<CinemaExperienceEvent, CinemaExperienceState> {
  final GetCinemaExperiencesUseCase getCinemaExperiencesUseCase;

  CinemaExperienceBloc(this.getCinemaExperiencesUseCase)
      : super(const CinemaExperienceState()) {
    on<GetCinemaExperiencesEvent>(_getCinemaExperiencesEvent);
    on<ExperienceSelectedEvent>(_onExperienceSelected);
    on<ClearCinemaExperienceEvent>(_onClearExperience);
  }

  void _onClearExperience(
      ClearCinemaExperienceEvent event, Emitter<CinemaExperienceState> emit) {
    emit(state.copyWith(cinemaExperiences: [], selectedExperience: null));
  }

  FutureOr<void> _getCinemaExperiencesEvent(GetCinemaExperiencesEvent event,
      Emitter<CinemaExperienceState> emit) async {
    emit(state.copyWith(cinemaExperienceState: CurrentAppState.LOADING));

    final experienceData =
        await getCinemaExperiencesUseCase.call(event.cinemaId);

    switch (experienceData) {
      case Success<List<CinemaExperienceModel>>():
        emit(state.copyWith(
            cinemaExperienceState: CurrentAppState.SUCCESS,
            cinemaExperiences: experienceData.data));
        break;
      case Error<List<CinemaExperienceModel>>():
        emit(state.copyWith(
            cinemaExperienceState: CurrentAppState.ERROR,
            appException: experienceData.exception));
        break;
    }
  }

  FutureOr<void> _onExperienceSelected(ExperienceSelectedEvent event,
      Emitter<CinemaExperienceState> emit) async {
    emit(state.copyWith(selectedExperience: event.experienceName));
  }
}
