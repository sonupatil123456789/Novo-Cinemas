import 'package:equatable/equatable.dart';
import 'package:novocinema/src/Home/domain/models/QuickBookMoviesModel.dart';

// Movie Model
class QuickBookMoviesDto extends Equatable {
  final int? movieId;
  final String? movieTitle;
  final String? movieTitleAr;
  final String? movieBannerUrl;
  final String? movieImageUrl;

  const QuickBookMoviesDto({
     this.movieId = 0 ,
     this.movieTitle = '',
     this.movieTitleAr = '',
    this.movieBannerUrl = '',
    this.movieImageUrl = '',
  });

  factory QuickBookMoviesDto.fromJson(Map<String, dynamic> json) => QuickBookMoviesDto(
    movieId: json['movie_id'] ?? 0,
    movieTitle: json['movie_title'] ?? '',
    movieTitleAr: json['movie_title_ar'] ?? '',
    movieBannerUrl: json['movie_banner_url'] ??  '',
    movieImageUrl: json['movie_image_url'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'movie_id': movieId,
    'movie_title': movieTitle,
    'movie_title_ar': movieTitleAr,
    'movie_banner_url': movieBannerUrl,
    'movie_image_url':movieImageUrl
  };

  QuickBookMoviesDto copyWith({
    int? movieId,
    String? movieTitle,
    String? movieTitleAr,
     String? movieBannerUrl,
     String? movieImageUrl

  }) =>
      QuickBookMoviesDto(
        movieId: movieId ?? this.movieId,
        movieTitle: movieTitle ?? this.movieTitle,
        movieTitleAr: movieTitleAr ?? this.movieTitleAr,
        movieBannerUrl:  movieBannerUrl?? this.movieBannerUrl,
        movieImageUrl: movieImageUrl?? this.movieImageUrl
      );

  static QuickBookMoviesModel toDomainModel(QuickBookMoviesDto quickBookMoviesDto){
    return QuickBookMoviesModel(
       movieId: quickBookMoviesDto.movieId,
      movieTitle: quickBookMoviesDto.movieTitle,
      movieTitleAr: quickBookMoviesDto.movieTitleAr,
      movieImageUrl: quickBookMoviesDto.movieImageUrl,
      movieBannerUrl: quickBookMoviesDto.movieBannerUrl
    );
  }

  @override
  List<Object?> get props => [movieId, movieTitle, movieTitleAr,movieBannerUrl,movieImageUrl];

  @override
  String toString() => 'QuickBookMoviesDto(movieId: $movieId, movieTitle: $movieTitle, movieTitleAr: $movieTitleAr, movieBannerUrl: $movieBannerUrl, movieImageUrl: $movieImageUrl)';
}


