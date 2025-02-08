
import 'package:equatable/equatable.dart';
import 'package:novocinema/entities/models/GenreModel.dart';
import 'package:novocinema/src/Movies/domain/models/MovieGenreModel.dart';

class MovieGenreDto extends Equatable {

  final String? genreName;
  final int ? genreId;
  final String? genreNameAr;

  const MovieGenreDto({
    this.genreId = 0,
    this.genreName = '',
    this.genreNameAr = '',
  });

  factory MovieGenreDto.fromJson(Map<String, dynamic> json) {
    return MovieGenreDto(
        genreName: json['genre_name'] ?? '',
        genreNameAr: json['genre_name_ar'] ?? '',
        genreId: json['genre_id'] ?? 0
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'genre_name': genreName,
      'genre_name_ar': genreNameAr,
      'genre_id'  : genreId
    };
  }

  MovieGenreDto copyWith({
    String? genreName,
    String? genreNameAr,
    int? genreId
  }) {
    return MovieGenreDto(
        genreName: genreName ?? this.genreName,
        genreNameAr: genreNameAr ?? this.genreNameAr,
        genreId : genreId ?? this.genreId
    );
  }

  static MovieGenreModel toDomainModel(MovieGenreDto movieGenreDto) {
    return MovieGenreModel(
        genreName: movieGenreDto.genreName ,
        genreNameAr: movieGenreDto.genreNameAr,
        genreId : movieGenreDto.genreId
    );
  }

  @override
  List<Object?> get props => [genreName, genreNameAr,genreId];


  @override
  String toString() {
    return 'MovieGenreDto(genreId: $genreId, genreName: $genreName, genreNameAr: $genreNameAr)';
  }
}