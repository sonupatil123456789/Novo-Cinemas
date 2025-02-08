import 'package:equatable/equatable.dart';
import 'package:novocinema/core/resources/AppException.dart';
import 'package:novocinema/core/resources/enums.dart';
import 'package:novocinema/src/Cinema-Experience/domain/models/cinemaexperience.dart';

class CinemaExperienceState extends Equatable {
  final CurrentAppState cinemaExperienceState;
  final List<CinemaExperienceModel> cinemaExperiences;
  final String? selectedExperience;
  final AppException? appException;

  const CinemaExperienceState({
    this.cinemaExperienceState = CurrentAppState.INITIAL,
    this.cinemaExperiences = const [],
    this.selectedExperience,
    this.appException,
  });

  CinemaExperienceState copyWith({
    CurrentAppState? cinemaExperienceState,
    List<CinemaExperienceModel>? cinemaExperiences,
    String? selectedExperience,
    AppException? appException,
  }) {
    return CinemaExperienceState(
      cinemaExperienceState:
          cinemaExperienceState ?? this.cinemaExperienceState,
      cinemaExperiences: cinemaExperiences ?? this.cinemaExperiences,
      selectedExperience: selectedExperience ?? this.selectedExperience,
      appException: appException ?? this.appException,
    );
  }

  @override
  List<Object?> get props => [
        cinemaExperienceState,
        cinemaExperiences,
        selectedExperience,
        appException,
      ];
}
