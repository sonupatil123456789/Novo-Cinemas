import 'package:equatable/equatable.dart';
import 'package:novocinema/src/Search/data/dto/SearchMovieDto.dart';
import 'package:novocinema/src/Search/domain/models/SearchModel.dart';

import 'SearchCinemaDto.dart';

class SearchDto extends Equatable{
  final List<SearchMovieDto>? movies;
  final List<SearchCinemaDto>? cinemas;

  SearchDto({
     this.movies = const[],
     this.cinemas = const[],
  });

  factory SearchDto.fromJson(Map<String, dynamic> json) {
    return SearchDto(
      movies: json['movies'] != null ?(json['movies'] as List)
          .map((movieJson) => SearchMovieDto.fromJson(movieJson))
          .toList() : [],
      cinemas:json['cinemas']!= null ? (json['cinemas'] as List)
          .map((cinemaJson) => SearchCinemaDto.fromJson(cinemaJson))
          .toList() : [] ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'movies': movies?.map((movie) => movie.toJson()).toList() ?? [],
      'cinemas': cinemas?.map((cinema) => cinema.toJson()).toList() ?? [],
    };
  }

  SearchDto copyWith({
    List<SearchMovieDto>? movies,
    List<SearchCinemaDto>? cinemas,
  }) {
    return SearchDto(
      movies: movies ?? this.movies,
      cinemas: cinemas ?? this.cinemas,
    );
  }

  static SearchModel toDomainModel(SearchDto searchDto){
    return SearchModel(
      movies: searchDto.movies?.map((toElement)=>SearchMovieDto.toDomainModel(toElement)).toList(),
      cinemas: searchDto.cinemas?.map((toElement)=>SearchCinemaDto.toDomainModel(toElement)).toList(),
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [movies,cinemas];

  @override
  String toString() {
    return 'SearchDto(movies: $movies, cinemas: $cinemas)';
  }
}