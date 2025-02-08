import 'package:equatable/equatable.dart';

abstract class CinemaExperienceEvent extends Equatable {
  const CinemaExperienceEvent();

  @override
  List<Object?> get props => [];
}

class ClearCinemaExperienceEvent extends CinemaExperienceEvent {}

class GetCinemaExperiencesEvent extends CinemaExperienceEvent {
  final int? cinemaId;

  const GetCinemaExperiencesEvent(this.cinemaId);

  @override
  List<Object?> get props => [cinemaId];
}

class ExperienceSelectedEvent extends CinemaExperienceEvent {
  final String experienceName;

  const ExperienceSelectedEvent(this.experienceName);

  @override
  List<Object?> get props => [experienceName];
}
