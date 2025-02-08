part of 'MoviesBloc.dart';

class MoviesState extends Equatable {
  List<ChoiceChipData>? selectedLocation = [];
  List<ChoiceChipData>? selectedExperience = [];
  List<ChoiceChipData>? selectedLanguage = [];
  List<ChoiceChipData>? selectedGenera = [];

  MovieLayoutType toggleMovieLayout;

  ChoiceChipData<Map<String, dynamic>> selectedMovieType;
  List<LocationModel> locationList = [];
  List<ExperienceModel> experienceList = [];
  List<LanguageModel> languageList = [];
  List<GenreModel> genreList = [];
  final CurrentAppState loading;
  List<MovieModel> moviesList = [];
  AppException? appException;

  MoviesState(
      {this.selectedLocation = const [],
      this.selectedExperience = const [],
      this.selectedLanguage = const [],
      this.selectedGenera = const [],
      required this.selectedMovieType ,
      this.toggleMovieLayout = MovieLayoutType.GRID_VIEW,
      this.loading = CurrentAppState.INITIAL,
      this.genreList = const [],
      this.moviesList = const [],
      this.languageList = const [],
      this.locationList = const [],
      this.experienceList = const [],
      this.appException});

  MoviesState copyWith({
    List<ChoiceChipData>? selectedLocation,
    List<ChoiceChipData>? selectedExperience,
    List<ChoiceChipData>? selectedLanguage,
    List<ChoiceChipData>? selectedGenera,
    List<LocationModel>? locationList,
    List<ExperienceModel>? experienceList,
    List<LanguageModel>? languageList,
    List<GenreModel>? genreList,
    MovieLayoutType? toggleMovieLayout,
    ChoiceChipData<Map<String, dynamic>>? selectedMovieType,
    CurrentAppState? loading,
    List<MovieModel>? moviesList,
    AppException? appException,
  }) {
    return MoviesState(
        loading: loading ?? this.loading,
        moviesList: moviesList ?? this.moviesList,
        appException: appException ?? this.appException,
        experienceList: experienceList ?? this.experienceList,
        languageList: languageList ?? this.languageList,
        genreList: genreList ?? this.genreList,
        selectedGenera: selectedGenera ?? this.selectedGenera,
        locationList: locationList ?? this.locationList,
        selectedMovieType: selectedMovieType ?? this.selectedMovieType,
        selectedExperience: selectedExperience ?? this.selectedExperience,
        selectedLanguage: selectedLanguage ?? this.selectedLanguage,
        toggleMovieLayout: toggleMovieLayout ?? this.toggleMovieLayout,
        selectedLocation: selectedLocation ?? this.selectedLocation);
  }

  @override
  List<Object?> get props => [
        loading,
        moviesList,
        appException,
        experienceList,
        languageList,
        locationList,
        selectedMovieType,
        selectedGenera,
        genreList,
        toggleMovieLayout,
        selectedExperience,
        selectedLanguage,
        selectedLocation,
      ];
}
