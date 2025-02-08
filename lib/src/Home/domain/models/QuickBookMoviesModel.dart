import 'package:equatable/equatable.dart';

// Movie Model
class QuickBookMoviesModel extends Equatable {
  final int? movieId;
  final String? movieTitle;
  final String? movieTitleAr;
  final String? movieBannerUrl;
  final String? movieImageUrl;

  const QuickBookMoviesModel({
     this.movieId = 0 ,
     this.movieTitle = '',
     this.movieTitleAr = '',
    this.movieBannerUrl = '',
    this.movieImageUrl = '',
  });


  QuickBookMoviesModel copyWith({
    int? movieId,
    String? movieTitle,
    String? movieTitleAr,
     String? movieBannerUrl,
     String? movieImageUrl,
  }) =>
      QuickBookMoviesModel(
        movieId: movieId ?? this.movieId,
        movieTitle: movieTitle ?? this.movieTitle,
        movieTitleAr: movieTitleAr ?? this.movieTitleAr,
          movieBannerUrl:  movieBannerUrl?? this.movieBannerUrl,
          movieImageUrl: movieImageUrl?? this.movieImageUrl
      );

  @override
  List<Object?> get props => [movieId, movieTitle, movieTitleAr,movieImageUrl,movieBannerUrl];

  @override
  String toString() =>'QuickBookMoviesModel(movieId: $movieId, movieTitle: $movieTitle, movieTitleAr: $movieTitleAr, movieBannerUrl: $movieBannerUrl, movieImageUrl: $movieImageUrl)';
}


