part of 'MoviesBloc.dart';

sealed class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object> get props => [];
}

class ToggleLayoutViewEvent extends MoviesEvent {
  final MovieLayoutType toggleMovieLayout;

  const ToggleLayoutViewEvent(this.toggleMovieLayout);

  @override
  List<Object> get props => [toggleMovieLayout];
}

class SelectedMovieTypeEvent extends MoviesEvent {
  // final TabBarData<Map<String,dynamic>> selectedMovieType;
  final ChoiceChipData<Map<String, dynamic>> selectedMovieType;
  const SelectedMovieTypeEvent(this.selectedMovieType);

  @override
  List<Object> get props => [selectedMovieType];
}

class SelectedLanguageEvent extends MoviesEvent {
  final ChoiceChipData selectedLanguage;
  final Function(Map<String, dynamic>) query;
  const SelectedLanguageEvent(this.selectedLanguage, this.query);

  @override
  List<Object> get props => [selectedLanguage, query];
}

class SelectedCategoryEvent extends MoviesEvent {
  final ChoiceChipData selectedCategory;
  final Function(Map<String, dynamic>) query;
  const SelectedCategoryEvent(this.selectedCategory, this.query);

  @override
  List<Object> get props => [selectedCategory, query];
}

class SelectedExperienceEvent extends MoviesEvent {
  final ChoiceChipData selectedExperience;
  final Function(Map<String, dynamic>) query;
  const SelectedExperienceEvent(this.selectedExperience, this.query);

  @override
  List<Object> get props => [selectedExperience, query];
}

class SelectedLocationEvent extends MoviesEvent {
  final ChoiceChipData selectedLocation;
  final Function(Map<String, dynamic>) query;
  const SelectedLocationEvent(this.selectedLocation, this.query);

  @override
  List<Object> get props => [selectedLocation, query];
}

class SingleLocationEvent extends MoviesEvent {
  final String locationId;
  final Function(Map<String, dynamic>) query;

  const SingleLocationEvent(this.locationId, this.query);

  @override
  List<Object> get props => [locationId, query];
}

class ClearLocationEvent extends MoviesEvent {}

class ClearFiltersEvent extends MoviesEvent {
  final Function(Map<String, dynamic>) query;
  const ClearFiltersEvent(this.query);

  @override
  List<Object> get props => [query];
}

class LikeMovieEvent extends MoviesEvent {
  final MovieModel movie;
  final bool liked;
  const LikeMovieEvent(this.movie, this.liked);

  @override
  List<Object> get props => [movie, liked];
}

class GetAllFilteredMoviesEvent extends MoviesEvent {
  final Map<String, dynamic> query;
  const GetAllFilteredMoviesEvent(this.query);

  @override
  List<Object> get props => [query];
}
