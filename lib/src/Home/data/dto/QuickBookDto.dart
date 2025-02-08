import 'package:equatable/equatable.dart';
import 'package:novocinema/src/Home/data/dto/QuickBookMoviesDto.dart';
import 'package:novocinema/src/Home/data/dto/QuickBookSessionDto.dart';

import '../../domain/models/QuickBookModel.dart';
import 'QuickBookCinemaDto.dart';



class QuickBookDto extends Equatable {
  final List<QuickBookMoviesDto> movies;
  final List<QuickBookCinemaDto> cinemas;
  final Map<String, List<QuickBookSessionDto>> sessions;

  const QuickBookDto({
     this.movies = const[],
     this.cinemas = const [],
     this.sessions = const{},
  });

  factory QuickBookDto.fromJson(Map<String, dynamic> json) => QuickBookDto(
    movies:json['movies']!= null ? (json['movies'] as List)
        .map((movieJson) => QuickBookMoviesDto.fromJson(movieJson))
        .toList() : [],
    cinemas: json['cinemas'] != null ?(json['cinemas'] as List)
        .map((cinemaJson) => QuickBookCinemaDto.fromJson(cinemaJson))
        .toList() : [],
    sessions:json['sessions']!=null ? (json['sessions'] as Map).map(
          (date, sessionList) => MapEntry(date,
        (sessionList as List).map((sessionJson) => QuickBookSessionDto.fromJson(sessionJson)).toList(),
      ),
    ) : <String,List<QuickBookSessionDto>>{},
  );

  Map<String, dynamic> toJson() => {
    'movies': movies.map((movie) => movie.toJson()).toList(),
    'cinemas': cinemas.map((cinema) => cinema.toJson()).toList(),
    'sessions': sessions.map(
          (date, sessionList) => MapEntry(
        date,
        sessionList.map((session) => session.toJson()).toList(),
      ),
    ),
  };

  QuickBookDto copyWith({
     List<QuickBookMoviesDto>? movies,
     List<QuickBookCinemaDto> ? cinemas,
     Map<String, List<QuickBookSessionDto>>? sessions
  }) =>
      QuickBookDto(
        movies: movies ?? this.movies,
        cinemas: cinemas ?? this.cinemas,
        sessions: sessions ?? this.sessions,
      );

  static QuickBookModel toDomainModel(QuickBookDto quickBookDto){
    return QuickBookModel(
        cinemas: quickBookDto.cinemas.map((toElement)=>QuickBookCinemaDto.toDomainModel(toElement)).toList(),
      movies: quickBookDto.movies.map((toElement)=>QuickBookMoviesDto.toDomainModel(toElement)).toList(),
        sessions: Map.fromEntries(
          quickBookDto.sessions.entries.map((entry) {
            return  MapEntry(entry.key,entry.value.map((session) => QuickBookSessionDto.toDomainModel(session)).toList());
              }
          ),
        ),
    );
  }

  @override
  List<Object?> get props => [movies, cinemas, sessions];

  @override
  String toString() =>'QuickBookDto(movies: $movies, cinemas: $cinemas, sessions: $sessions)';
}