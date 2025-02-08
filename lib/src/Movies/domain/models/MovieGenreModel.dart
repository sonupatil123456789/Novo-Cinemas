
import 'package:equatable/equatable.dart';
import 'package:novocinema/entities/models/GenreModel.dart';

class MovieGenreModel extends Equatable {


  final String? genreName;
  final int ? genreId;
  final String? genreNameAr;

  const MovieGenreModel({
    this.genreId,
    this.genreName,
    this.genreNameAr,
  });



  MovieGenreModel copyWith({
    String? genreName,
    String? genreNameAr,
    int? genreId
  }) {
    return MovieGenreModel(
        genreName: genreName ?? this.genreName,
        genreNameAr: genreNameAr ?? this.genreNameAr,
        genreId : genreId ?? this.genreId
    );
  }


  @override
  List<Object?> get props => [genreName, genreNameAr,genreId];


  @override
  String toString() {
    return 'MovieGenreModel(genreId: $genreId, genreName: $genreName, genreNameAr: $genreNameAr)';
  }


}