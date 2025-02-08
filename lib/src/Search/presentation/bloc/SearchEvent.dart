part of 'SearchBloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}


class SearchMovieEvent extends SearchEvent {
  final String search;
  const SearchMovieEvent(this.search);

  @override
  List<Object> get props => [search];
}

