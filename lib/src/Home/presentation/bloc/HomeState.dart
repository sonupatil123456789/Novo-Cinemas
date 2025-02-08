part of 'HomeBloc.dart';

class HomeState extends Equatable {
  List<ChoiceChipData>? selectedGenera = [];
  List<ChoiceChipData>? selectedLocation = [];
  List<ChoiceChipData>? selectedExperience = [];
  List<ChoiceChipData>? selectedLanguage = [];
  ChoiceChipData<QuickBookMoviesModel>? selectedQuickBookMovie;
  ChoiceChipData<QuickBookCinemaModel>? selectedQuickBookCinema;
  ChoiceChipData<MapEntry<String,List<QuickBookSessionModel>>>? selectedQuickBookDate;
  ChoiceChipData<QuickBookSessionModel>? selectedQuickBookTime;
  // QuickBookSessionModel? selectedSessionData;

  QuickBookModel? quickBookData;

  List<GenreModel> genreList = [];
  List<LocationModel> locationList = [];
  List<ExperienceModel> experienceList = [];
  List<LanguageModel> languageList = [];

  final CurrentAppState loading;
  final CurrentAppState quickBookState;
  final CurrentAppState bannerState;
  final CurrentAppState moviesState;
  final AppException? appException;
  List<MovieModel> moviesList = [];
  List<BannerModel> topFiveBannersList = [];

  HomeState(
      {this.selectedGenera,
      this.selectedLocation,
      this.selectedExperience,
      this.selectedLanguage,
      this.quickBookData,
      this.selectedQuickBookMovie,
      this.selectedQuickBookCinema,
      this.selectedQuickBookDate,
      this.selectedQuickBookTime,
      // this.selectedSessionData,
      this.quickBookState = CurrentAppState.INITIAL,
      this.loading = CurrentAppState.INITIAL,
      this.moviesState = CurrentAppState.INITIAL,
      this.bannerState = CurrentAppState.INITIAL,
      this.moviesList = const [],
      this.genreList = const [],
      this.languageList = const [],
      this.locationList = const [],
      this.experienceList = const [],
      this.topFiveBannersList = const [],
      this.appException});

  HomeState copyWith(
      {List<ChoiceChipData>? selectedGenera,
      List<ChoiceChipData>? selectedLocation,
      List<ChoiceChipData>? selectedExperience,
      List<ChoiceChipData>? selectedLanguage,
      List<GenreModel>? genreList,
      List<LocationModel>? locationList,
      List<ExperienceModel>? experienceList,
      List<LanguageModel>? languageList,
      ChoiceChipData<QuickBookMoviesModel>? selectedQuickBookMovie,
      ChoiceChipData<QuickBookCinemaModel>? selectedQuickBookCinema,
      ChoiceChipData<MapEntry<String,List<QuickBookSessionModel>>>? selectedQuickBookDate,
      ChoiceChipData<QuickBookSessionModel>? selectedQuickBookTime,
      QuickBookSessionModel? selectedSessionData,
      QuickBookModel? quickBookData,
      CurrentAppState? quickBookState,
      CurrentAppState? loading,
      CurrentAppState? moviesState,
      CurrentAppState? bannerState,
      List<MovieModel>? moviesList,
      AppException? appException,
      List<BannerModel>? topFiveBannersList}) {
    return HomeState(
        loading: loading ?? this.loading,
        genreList: genreList ?? this.genreList,
        moviesState: moviesState ?? this.moviesState,
        bannerState: bannerState ?? this.bannerState,
        selectedQuickBookMovie:
            selectedQuickBookMovie ?? this.selectedQuickBookMovie,
        selectedQuickBookCinema:
            selectedQuickBookCinema ?? this.selectedQuickBookCinema,
        selectedQuickBookDate:
            selectedQuickBookDate ?? this.selectedQuickBookDate,
        selectedQuickBookTime:selectedQuickBookTime ?? this.selectedQuickBookTime,
        quickBookData: quickBookData ?? this.quickBookData,
        quickBookState: quickBookState ?? this.quickBookState,
        topFiveBannersList: topFiveBannersList ?? this.topFiveBannersList,
        moviesList: moviesList ?? this.moviesList,
        appException: appException ?? this.appException,
        experienceList: experienceList ?? this.experienceList,
        languageList: languageList ?? this.languageList,
        locationList: locationList ?? this.locationList,
        // selectedSessionData: selectedSessionData ?? this.selectedSessionData,
        selectedExperience: selectedExperience ?? this.selectedExperience,
        selectedGenera: selectedGenera ?? this.selectedGenera,
        selectedLanguage: selectedLanguage ?? this.selectedLanguage,
        selectedLocation: selectedLocation ?? this.selectedLocation);
  }

  @override
  List<Object?> get props => [
        loading,
        bannerState,
        quickBookData,
        quickBookState,
        moviesState,
        topFiveBannersList,
        moviesList,
        appException,
        genreList,
        experienceList,
        languageList,
        locationList,
        selectedExperience,
        selectedGenera,
        selectedLanguage,
        selectedLocation,
        selectedQuickBookTime,
        selectedQuickBookDate,
        selectedQuickBookCinema,
        // selectedSessionData,
        selectedQuickBookMovie,
      ];
}
