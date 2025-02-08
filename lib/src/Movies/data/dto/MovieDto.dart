import 'package:equatable/equatable.dart';
import 'package:novocinema/src/Movies/data/dto/MovieCastDto.dart';
import 'package:novocinema/src/Movies/data/dto/MovieExperiencesDto.dart';
import 'package:novocinema/src/Movies/data/dto/MovieGenreDto.dart';
import 'package:novocinema/src/Movies/domain/models/MovieModel.dart';
import 'MovieLanguageDto.dart';

class MovieDto extends Equatable {
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
  final List<MovieGenreDto>? movieGenres;
  final List<MovieCastDto>? cast;
  final List<MovieExperiencesDto>? experience;
  final MovieLanguageDto? language;
  final bool? isMovieLiked ;
  final bool ? isMovieComingSoon ;

  const MovieDto({
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
    this.experience = const [],
    this.cast = const [],
    this.language,
    this.isMovieComingSoon = false ,
    this.isMovieLiked = false
  });

  factory MovieDto.fromJson(Map<String, dynamic> json) {
    return MovieDto(
        movieTitle: json['movie_title'] ?? '',
        movieTitleAr: json['movie_title_ar'] ?? '',
        movieBannerUrl: json['movie_banner_url'] ??  '',
        movieImageUrl: json['movie_image_url'] ?? '',
        movieCountryId: json['movie_country_id'] ?? '',
        movieDescription: json['movie_description'] ?? '',
        movieDescriptionAr: json['movie_description_ar'] ?? '',
        movieDuration: json['movie_duration'] ?? 0,
        movieId: json['movie_id'] ?? 0,
        movieProductionCompany: json['movie_production_company'] ??'',
        vistaFilmId: json['vista_Film_id'] ?? '',
        movieIsComingSoon: json['movie_is_coming_soon'] ?? false ,
        isAdvanceBookingAvailable : json['isAdvanceBookingAvailable'] ?? false ,
        movieRating: json['movie_rating'] ?? '',
        isMovieLiked: json['isMovieLiked'] ?? false,
        movieReleaseDate: json['movie_release_date'] != null
            ? DateTime.parse(json['movie_release_date'])
            : DateTime.now(),
        isMovieComingSoon:  json['movie_is_coming_soon'] ?? false ,
        movieSlug: json['movie_slug'] ?? '',
        language : json['language'] != null ?MovieLanguageDto.fromJson(json['language']) :MovieLanguageDto.fromJson(const <String,dynamic>{}),
        experience : json['experiences'] != null ? (json['experiences'] as List<dynamic>).map((experiences)=>MovieExperiencesDto.fromJson(experiences)).toList() : [],
        cast : json['movie_cast'] != null ? (json['movie_cast'] as List<dynamic>).map((casts)=>MovieCastDto.fromJson(casts)).toList() : [],
        vistaHoFilmCodeId: json['vista_hOFilmCode_id'] ?? '',

        movieGenres: json['movie_genre'] != null ? (json['movie_genre'] as List<dynamic>).map((genra)=>MovieGenreDto.fromJson(genra)).toList() : []
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'movie_title': movieTitle,
      'movie_title_ar': movieTitleAr,
      'movie_banner_url': movieBannerUrl,
      'movie_country_id': movieCountryId,
      'movie_description': movieDescription,
      'movie_description_ar': movieDescriptionAr,
      'movie_duration': movieDuration,
      'movie_id': movieId,
      'movie_image_url': movieImageUrl,
      'movie_production_company': movieProductionCompany,
      'vista_Film_id': vistaFilmId,
      'movie_is_coming_soon': movieIsComingSoon,
      'isAdvanceBookingAvailable': isAdvanceBookingAvailable,
      'movie_rating': movieRating,
      'movie_release_date': movieReleaseDate?.toIso8601String(),
      'movie_slug': movieSlug,
      'vista_hOFilmCode_id': vistaHoFilmCodeId,
      'movie_genre': movieGenres?.map((x) => x.toJson()).toList(),
      'experiences': experience?.map((x) => x.toJson()).toList(),
      'movie_cast': cast?.map((x) => x.toJson()).toList(),
      'language': language?.toJson(),
      'movie_is_coming_soon': isMovieComingSoon ,
      'isMovieLiked': isMovieLiked
    };
  }

  MovieDto copyWith({
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
    List<MovieGenreDto>? movieGenres,
    MovieLanguageDto? language,
     List<MovieCastDto>? cast,
    bool ? isMovieComingSoon ,
    bool ? isMovieLiked ,
     List<MovieExperiencesDto>? experience,
  }) {
    return MovieDto(
        movieTitle: movieTitle ?? this.movieTitle,
        movieTitleAr: movieTitleAr ?? this.movieTitleAr,
        movieBannerUrl: movieBannerUrl ?? this.movieBannerUrl,
        movieCountryId: movieCountryId ?? this.movieCountryId,
        movieDescription: movieDescription ?? this.movieDescription,
        movieDescriptionAr: movieDescriptionAr ?? this.movieDescriptionAr,
        movieDuration: movieDuration ?? this.movieDuration,
        movieId: movieId ?? this.movieId,
        movieImageUrl: movieImageUrl ?? this.movieImageUrl,
        movieProductionCompany:movieProductionCompany ?? this.movieProductionCompany,
        isMovieLiked : isMovieLiked ?? this.isMovieLiked ,
        vistaFilmId: vistaFilmId ?? this.vistaFilmId,
        movieIsComingSoon: movieIsComingSoon ?? this.movieIsComingSoon,
        isAdvanceBookingAvailable : isAdvanceBookingAvailable??this.isAdvanceBookingAvailable,
        movieRating: movieRating ?? this.movieRating,
        movieReleaseDate: movieReleaseDate ?? this.movieReleaseDate,
        movieSlug: movieSlug ?? this.movieSlug,
        vistaHoFilmCodeId: vistaHoFilmCodeId ?? this.vistaHoFilmCodeId,
        movieGenres: movieGenres ?? this.movieGenres,
        language:  language ?? this.language,
      experience: experience ?? this.experience,
        isMovieComingSoon : isMovieComingSoon ?? this.isMovieComingSoon ,
      cast:  cast ?? this.cast
    );
  }

  static MovieModel toDomainModel(MovieDto movieDto) {
    return MovieModel(
        movieTitle: movieDto.movieTitle ,
        movieTitleAr: movieDto.movieTitleAr,
        movieBannerUrl:movieDto.movieBannerUrl ,
        movieCountryId: movieDto.movieCountryId ,
        movieDescription: movieDto.movieDescription ,
        movieDescriptionAr: movieDto.movieDescriptionAr ,
        movieDuration: movieDto.movieDuration ,
        movieId: movieDto.movieId,
        movieImageUrl: movieDto.movieImageUrl ,
        movieProductionCompany:movieDto.movieProductionCompany ,
        vistaFilmId: movieDto.vistaFilmId ,
        movieIsComingSoon: movieDto.movieIsComingSoon ,
        movieRating: movieDto.movieRating ,
        movieReleaseDate: movieDto.movieReleaseDate ,
        movieSlug: movieDto.movieSlug ,
        isMovieLiked : movieDto.isMovieLiked,
        vistaHoFilmCodeId: movieDto.vistaHoFilmCodeId ,
        isMovieComingSoon : movieDto.isMovieComingSoon,
        language: MovieLanguageDto.toDomainModel(movieDto.language!),
        isAdvanceBookingAvailable: movieDto.isAdvanceBookingAvailable,
        movieGenres: movieDto.movieGenres?.map((genra)=> MovieGenreDto.toDomainModel(genra)).toList() ?? [],
       experience:  movieDto.experience?.map((experience)=> MovieExperiencesDto.toDomainModel(experience)).toList() ?? [],
       cast: movieDto.cast?.map((cast)=> MovieCastDto.toDomainModel(cast)).toList() ?? [],
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
    experience,
    cast,
    isMovieLiked,
    isMovieComingSoon
  ];

  @override
  String toString() {
    return 'MovieDto(movieTitle: $movieTitle, movieTitleAr: $movieTitleAr, movieBannerUrl: $movieBannerUrl, movieCountryId: $movieCountryId, movieDescription: $movieDescription, movieDescriptionAr: $movieDescriptionAr, movieDuration: $movieDuration, movieId: $movieId, movieImageUrl: $movieImageUrl, movieProductionCompany: $movieProductionCompany, vistaFilmId: $vistaFilmId, movieIsComingSoon: $movieIsComingSoon, movieRating: $movieRating, movieReleaseDate: $movieReleaseDate, movieSlug: $movieSlug, movieGenres: $movieGenres,  vistaHoFilmCodeId: $vistaHoFilmCodeId language: $language, isAdvanceBookingAvailable: $isAdvanceBookingAvailable, experience: $experience cast: $cast, isMovieLiked: $isMovieLiked, isMovieComingSoon: $isMovieComingSoon)';
  }
}
