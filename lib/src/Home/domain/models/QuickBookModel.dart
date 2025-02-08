import 'package:equatable/equatable.dart';
import 'QuickBookCinemaModel.dart';
import 'QuickBookMoviesModel.dart';
import 'QuickBookSessionModel.dart';



class QuickBookModel extends Equatable {
  final List<QuickBookMoviesModel> movies;
  final List<QuickBookCinemaModel> cinemas;
  final Map<String, List<QuickBookSessionModel>> sessions;

  const QuickBookModel({
     this.movies = const[],
     this.cinemas = const [],
     this.sessions = const{},
  });



  QuickBookModel copyWith({
     List<QuickBookMoviesModel>? movies,
     List<QuickBookCinemaModel> ? cinemas,
     Map<String, List<QuickBookSessionModel>>? sessions
  }) =>
      QuickBookModel(
        movies: movies ?? this.movies,
        cinemas: cinemas ?? this.cinemas,
        sessions: sessions ?? this.sessions,
      );

  @override
  List<Object?> get props => [movies, cinemas, sessions];

  @override
  String toString() =>
      'QuickBookModel(movies: $movies, cinemas: $cinemas, sessions: $sessions)';
}