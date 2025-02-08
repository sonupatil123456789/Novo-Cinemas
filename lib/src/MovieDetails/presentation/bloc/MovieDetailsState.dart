part of 'MovieDetailsBloc.dart';

class MovieDetailsState extends Equatable {

  late ShowTimesDataModel showTimeData;
  final CurrentAppState  showTimeDataState;
  late MovieFilterDataModel movieFilterData;
  final CurrentAppState loading;
  final CurrentAppState likeDislikeState;
  final AppException? appException;
  late MovieModel movieDetails;
  final String? selectedDate;
  final String? selectedMallName;
  final ShowTimeDetailsModel? selectedTiming;

  final ChoiceChipData? selectedLocations ;
  final ChoiceChipData? selectedLanguage ;
  final ChoiceChipData? selectedTimings ;
  final ChoiceChipData? selectedExperiences ;
  final List<String> ? showTimeDateList ;

  MovieDetailsState(
      {
        this.selectedLocations,
        this.selectedLanguage,
      this.selectedTimings,
      this.selectedExperiences,
        this.showTimeDateList = const [],
      this.showTimeData = const ShowTimesDataModel(),
      this.movieFilterData = const MovieFilterDataModel(),
      this.loading = CurrentAppState.INITIAL,
        this.showTimeDataState = CurrentAppState.INITIAL,
      this.likeDislikeState = CurrentAppState.INITIAL,
      this.movieDetails = const MovieModel(),
      this.selectedDate = '',
      this.selectedMallName = '',
      this.selectedTiming,
      this.appException});

  MovieDetailsState copyWith({
    // List<ChoiceChipData>? selectedLocations,
    // List<ChoiceChipData>? selectedTimings,
    // List<ChoiceChipData>? selectedExperiences,
    ShowTimesDataModel? showTimeData,
    CurrentAppState?  showTimeDataState,
    MovieFilterDataModel? movieFilterData,
    CurrentAppState? loading,
    MovieModel? movieDetails,
    AppException? appException,
    CurrentAppState? likeDislikeState,
    String? selectedMallName,
    List<String> ? showTimeDateList,
    String? selectedDate,
    ShowTimeDetailsModel? selectedTiming,
  }) {
    return MovieDetailsState(
        // selectedLocations: selectedLocations ?? this.selectedLocations,
        // selectedTimings: selectedTimings ?? this.selectedTimings,
        // selectedExperiences: selectedExperiences ?? this.selectedExperiences,
        movieDetails: movieDetails ?? this.movieDetails,
        showTimeDataState : showTimeDataState ?? this.showTimeDataState ,
        showTimeData: showTimeData ?? this.showTimeData,
        movieFilterData: movieFilterData ?? this.movieFilterData,
        loading: loading ?? this.loading,
        likeDislikeState: likeDislikeState ?? this.likeDislikeState,
        selectedMallName: selectedMallName ?? this.selectedMallName,
        selectedDate: selectedDate ?? this.selectedDate,
        selectedTiming: selectedTiming ?? this.selectedTiming,
        showTimeDateList:showTimeDateList ?? this.showTimeDateList ,
        appException: appException ?? this.appException);
  }

  @override
  List<Object?> get props => [
        loading,
        showTimeDataState,
        movieDetails,
        appException,
        showTimeData,
        movieFilterData,
        selectedDate,
        selectedTiming,
        selectedMallName,
        likeDislikeState,
        selectedLocations,
        selectedTimings,
         selectedLanguage,
        selectedExperiences,
        showTimeDateList
      ];
}
