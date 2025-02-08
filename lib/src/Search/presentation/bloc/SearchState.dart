part of 'SearchBloc.dart';

class SearchState extends Equatable {
  final CurrentAppState loading;
  final AppException? appException;
  List<SearchMovieModel> searchMoviesList = [];
  List<SearchCinemaModel> searchCinemaList = [];

  SearchState(
      {this.loading = CurrentAppState.INITIAL,
      this.searchMoviesList = const [],
      this.searchCinemaList = const [],
      this.appException});

  SearchState copyWith({
    List<SearchMovieModel>? searchMoviesList,
    List<SearchCinemaModel>? searchCinemaList,
    CurrentAppState? loading,
    AppException? appException,
  }) {
    return SearchState(
      loading: loading ?? this.loading,
      appException: appException ?? this.appException,
      searchMoviesList: searchMoviesList ?? this.searchMoviesList,
      searchCinemaList: searchCinemaList ?? this.searchCinemaList,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        searchCinemaList,
        searchMoviesList,
        appException,
      ];
}
