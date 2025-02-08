

import 'package:equatable/equatable.dart';
import 'package:novocinema/src/Movies/domain/models/MovieCastModel.dart';
import 'package:novocinema/src/Movies/domain/models/MovieExperiencesModel.dart';
import 'package:novocinema/src/Movies/domain/models/MovieGenreModel.dart';

import '../../../../entities/models/GenreModel.dart';
import 'MovieLanguageModel.dart';

class MovieModel extends Equatable {

  final String? movieTitle;
  final String? movieTitleAr;
  final String? movieBannerUrl;
  final String? movieCountryId;
  final String? movieDescription;
  final String? movieDescriptionAr;
  final int? movieDuration;
  final int? movieId;
  final String? movieImageUrl;
  final String? movieProductionCompany;
  final String? vistaFilmId;
  final bool? movieIsComingSoon;
  final bool? isAdvanceBookingAvailable;
  final String? movieRating;
  final DateTime? movieReleaseDate;
  final String? movieSlug;
  final String? vistaHoFilmCodeId;
  final List<MovieGenreModel>? movieGenres;
  final List<MovieCastModel>? cast;
  final List<MovieExperiencesModel>? experience;
  final MovieLanguageModel? language;
  final bool? isMovieLiked ;
  final bool ? isMovieComingSoon;

  const MovieModel({
    this.movieTitle = '',
    this.movieTitleAr = '',
    this.movieBannerUrl = '',
    this.movieCountryId = '',
    this.movieDescription = '',
    this.movieDescriptionAr = '',
    this.movieDuration = 0,
    this.movieId = 0,
    this.movieImageUrl = '',
    this.movieProductionCompany = '',
    this.vistaFilmId = '',
    this.movieIsComingSoon = false,
    this.isAdvanceBookingAvailable = false,
    this.movieRating = '',
    this.movieReleaseDate ,
    this.movieSlug = '',
    this.vistaHoFilmCodeId = '',
    this.movieGenres = const [],
    this.cast = const [],
    this.experience = const [],
    this.language,
    this.isMovieComingSoon = false,
    this.isMovieLiked = false
  });



  MovieModel copyWith({
    String? movieTitle,
    String? movieTitleAr,
    String? movieBannerUrl,
    String? movieCountryId,
    String? movieDescription,
    String? movieDescriptionAr,
    int? movieDuration,
    String? movieGenre1,
    String? movieGenre2,
    String? movieGenre3,
    int? movieId,
    String? movieImageUrl,
    String? movieProductionCompany,
    String? vistaFilmId,
    bool? movieIsComingSoon,
    bool? isAdvanceBookingAvailable ,
    String? movieRating,
    DateTime? movieReleaseDate,
    String? movieSlug,
    String? vistaHoFilmCodeId,
    List<MovieGenreModel>? movieGenres,
    List<MovieCastModel>? cast,
    List<MovieExperiencesModel>? experience,
    MovieLanguageModel? language,
    bool? isMovieLiked,
    bool ? isMovieComingSoon ,
  }) {
    return MovieModel(
        movieTitle: movieTitle ?? this.movieTitle,
        movieTitleAr: movieTitleAr ?? this.movieTitleAr,
        movieBannerUrl: movieBannerUrl ?? this.movieBannerUrl,
        movieCountryId: movieCountryId ?? this.movieCountryId,
        movieDescription: movieDescription ?? this.movieDescription,
        movieDescriptionAr: movieDescriptionAr ?? this.movieDescriptionAr,
        movieDuration: movieDuration ?? this.movieDuration,
        movieId: movieId ?? this.movieId,
        movieImageUrl: movieImageUrl ?? this.movieImageUrl,
        movieProductionCompany:
        movieProductionCompany ?? this.movieProductionCompany,
        isMovieLiked : isMovieLiked ?? this.isMovieLiked,
        vistaFilmId: vistaFilmId ?? this.vistaFilmId,
        movieIsComingSoon: movieIsComingSoon ?? this.movieIsComingSoon,
        isAdvanceBookingAvailable : isAdvanceBookingAvailable??this.isAdvanceBookingAvailable,
        movieRating: movieRating ?? this.movieRating,
        movieReleaseDate: movieReleaseDate ?? this.movieReleaseDate,
        movieSlug: movieSlug ?? this.movieSlug,
        vistaHoFilmCodeId: vistaHoFilmCodeId ?? this.vistaHoFilmCodeId,
        movieGenres: movieGenres ?? this.movieGenres,
        language:  language ?? this.language,
        cast: cast ?? this.cast,
        isMovieComingSoon : isMovieComingSoon ?? this.isMovieComingSoon,
        experience: experience ?? this.experience,

    );
  }


  @override
  List<Object?> get props => [
    movieTitle,
    movieTitleAr,
    movieBannerUrl,
    movieCountryId,
    movieDescription,
    movieDescriptionAr,
    movieDuration,
    movieId,
    movieImageUrl,
    movieProductionCompany,
    vistaFilmId,
    movieIsComingSoon,
    isAdvanceBookingAvailable,
    movieRating,
    movieReleaseDate,
    movieSlug,
    vistaHoFilmCodeId,
    movieGenres,
    language,
    cast,
    isMovieLiked,
    experience,
    isMovieComingSoon
  ];

  @override
  String toString() {
    return 'MovieModel(movieTitle: $movieTitle, movieTitleAr: $movieTitleAr, movieBannerUrl: $movieBannerUrl, movieCountryId: $movieCountryId, movieDescription: $movieDescription, movieDescriptionAr: $movieDescriptionAr, movieDuration: $movieDuration, movieId: $movieId, movieImageUrl: $movieImageUrl, movieProductionCompany: $movieProductionCompany, vistaFilmId: $vistaFilmId, movieIsComingSoon: $movieIsComingSoon, movieRating: $movieRating, movieReleaseDate: $movieReleaseDate, movieSlug: $movieSlug, movieGenres: $movieGenres,  vistaHoFilmCodeId: $vistaHoFilmCodeId language: $language isAdvanceBookingAvailable: $isAdvanceBookingAvailable, experience: $experience, cast: $cast, isMovieLiked: $isMovieLiked, isMovieComingSoon: $isMovieComingSoon)';
  }


}
