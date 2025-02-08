import 'package:equatable/equatable.dart';
import 'package:novocinema/entities/models/ShowTimeDetailsModel.dart';


class ShowTimeMovieModel extends Equatable {
  final String? movieTitle;
  final String? movieTitleAr;
  final String? movieBannerUrl;
  final String? movieImageUrl;
  final List<ShowTimeDetailsModel>? sessions;

  const ShowTimeMovieModel({
     this.movieTitle,
     this.movieTitleAr,
     this.movieBannerUrl,
     this.movieImageUrl,
     this.sessions,
  });

  ShowTimeMovieModel copyWith({
     String? movieTitle,
     String ?movieTitleAr,
     String ?movieBannerUrl,
     String ?movieImageUrl,
     List<ShowTimeDetailsModel>? sessions,
  }) {
    return ShowTimeMovieModel(
        movieTitle: movieTitle ?? this.movieTitle,
      movieTitleAr: movieTitleAr ?? this.movieTitleAr,
      sessions: sessions ?? this.sessions,
      movieImageUrl: movieImageUrl ?? this.movieImageUrl,
      movieBannerUrl: movieBannerUrl ?? this.movieBannerUrl

    );
  }


  @override
  List<Object?> get props =>
      [movieTitle, movieTitleAr, movieBannerUrl, movieImageUrl, sessions];

  @override
  String toString() =>
      'ShowTimeMovieModel(movieTitle: $movieTitle, movieTitleAr: $movieTitleAr, movieBannerUrl: $movieBannerUrl, movieImageUrl: $movieImageUrl, sessions: $sessions)';
}