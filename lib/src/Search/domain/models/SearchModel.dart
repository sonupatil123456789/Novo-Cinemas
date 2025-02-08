import 'package:equatable/equatable.dart';
import 'package:novocinema/src/Search/domain/models/SearchCinemaModel.dart';
import 'package:novocinema/src/Search/domain/models/SearchMovieModel.dart';


class SearchModel extends Equatable{
  final List<SearchMovieModel>? movies;
  final List<SearchCinemaModel>? cinemas;

  const SearchModel({
     this.movies = const[],
     this.cinemas = const[],
  });


  SearchModel copyWith({
    List<SearchMovieModel>? movies,
    List<SearchCinemaModel>? cinemas,
  }) {
    return SearchModel(
      movies: movies ?? this.movies,
      cinemas: cinemas ?? this.cinemas,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [movies,cinemas];

  @override
  String toString() {
    return 'SearchModel(movies: $movies, cinemas: $cinemas)';
  }
}