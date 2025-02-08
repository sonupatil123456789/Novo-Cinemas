part of 'ShowTimeBloc.dart';

class ShowTimeState extends Equatable {
  late ShowTimesDataModel showTimeData;
  final CurrentAppState loading;
  final AppException? appException;
  final ShowTimeDetailsModel? selectedTiming;
  final ShowTimeMovieModel movieDetail ;
  final String? selectedDate;
  final String? selectedMallName;

  ShowTimeState(
      {this.showTimeData = const ShowTimesDataModel(),
      this.loading = CurrentAppState.INITIAL,
      this.selectedDate = '',
      this.selectedMallName = '',
        this.movieDetail  = const ShowTimeMovieModel(),
      this.selectedTiming = const ShowTimeDetailsModel(),
      this.appException});

  ShowTimeState copyWith({
    ShowTimesDataModel? showTimeData,
    CurrentAppState? loading,
    AppException? appException,
    String? selectedMallName,
    String? selectedDate,
    ShowTimeMovieModel? movieDetail,
    ShowTimeDetailsModel? selectedTiming,
  }) {
    return ShowTimeState(
        showTimeData: showTimeData ?? this.showTimeData,
        loading: loading ?? this.loading,
        movieDetail : movieDetail ?? this.movieDetail,
        selectedTiming: selectedTiming ?? this.selectedTiming,
        selectedMallName: selectedMallName ?? this.selectedMallName,
        selectedDate: selectedDate ?? this.selectedDate,
        appException: appException ?? this.appException);
  }

  @override
  List<Object?> get props => [
        loading,
        appException,
        showTimeData,
        selectedTiming,
        selectedMallName,
        movieDetail,
        selectedDate,

      ];
}
