import 'package:equatable/equatable.dart';
import 'package:novocinema/src/ShowTime/domain/models/ShowTimeMoviesModel.dart';

import '../../../../entities/dto/ShowTimeDetailsDto.dart';

class ShowTimeMovieDto extends Equatable {
  final String? movieTitle;
  final String? movieTitleAr;
  final String? movieBannerUrl;
  final String? movieImageUrl;
  final List<ShowTimeDetailsDto>? sessions;

  const ShowTimeMovieDto({
     this.movieTitle,
     this.movieTitleAr,
     this.movieBannerUrl,
     this.movieImageUrl,
     this.sessions,
  });

  // Convert JSON to Movie
  factory ShowTimeMovieDto.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw const FormatException('Null JSON provided');
    }

    return ShowTimeMovieDto(
      movieTitle: json['movie_title'] as String? ?? '',
      movieTitleAr: json['movie_title_ar'] as String? ?? '',
      movieBannerUrl: json['movie_banner_url'] as String? ?? '',
      movieImageUrl: json['movie_image_url'] as String? ?? '',
      sessions: (json['sessions'] as List<dynamic>? ?? [])
          .map((session) => ShowTimeDetailsDto.fromJson(session as Map<String, dynamic>? ?? <String,dynamic>{}))
          .toList(),
    );
  }

  // Convert Movie to JSON
  Map<String, dynamic> toJson() {
    return {
      'movie_title': movieTitle,
      'movie_title_ar': movieTitleAr,
      'movie_banner_url': movieBannerUrl,
      'movie_image_url': movieImageUrl,
      'sessions': sessions?.map((session) => session.toJson()).toList(),
    };
  }

  static ShowTimeMovieModel toDomainModel(ShowTimeMovieDto showTimeMovieDto) {
    return ShowTimeMovieModel(
     movieBannerUrl: showTimeMovieDto.movieBannerUrl,
      movieImageUrl: showTimeMovieDto.movieImageUrl,
      sessions: showTimeMovieDto.sessions?.map((toElement)=> ShowTimeDetailsDto.toDomainModel(toElement)).toList() ?? [],
      movieTitleAr: showTimeMovieDto.movieTitleAr,
      movieTitle: showTimeMovieDto.movieTitle,
    );
  }

  @override
  List<Object?> get props =>
      [movieTitle, movieTitleAr, movieBannerUrl, movieImageUrl, sessions];

  @override
  String toString() =>
      'ShowTimeMovieDto(movieTitle: $movieTitle, movieTitleAr: $movieTitleAr, movieBannerUrl: $movieBannerUrl, movieImageUrl: $movieImageUrl, sessions: $sessions)';
}