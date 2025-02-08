
import 'package:equatable/equatable.dart';

import '../../../Movies/data/dto/MovieLanguageDto.dart';
import '../../../Movies/domain/models/MovieLanguageModel.dart';

class BannerMovieDetailsModel extends Equatable {
  final int? movieId;
  final String? title;
  final String? titleAr;
  final int? duration;
  final String? rating;
  final String? trailerLink;
  final MovieLanguageModel? language ;
  final String? slug ;
  final String? imageUrl ;


  const BannerMovieDetailsModel({
    this.movieId = 0,
    this.title = '',
    this.titleAr = '',
    this.duration = 0,
    this.rating = '',
    this.trailerLink = '',
    this.language,
    this.slug = '',
    this.imageUrl = ''
  });



  // Copy with method for easy modification
  BannerMovieDetailsModel copyWith({
    int? movieId,
    String? title,
    String? titleAr,
    int? duration,
    String? rating,
    String? trailerLink,
    MovieLanguageModel? language,
    String? slug,
    String? imageUrl,
  }) {
    return BannerMovieDetailsModel(
        movieId: movieId ?? this.movieId,
        title: title ?? this.title,
        titleAr: titleAr ?? this.titleAr,
        duration: duration ?? this.duration,
        rating: rating ?? this.rating,
        trailerLink: trailerLink ?? this.trailerLink,
        language: language ?? this.language,
        slug: slug ?? this.slug,
        imageUrl : imageUrl ?? this.imageUrl
    );
  }



  // Equatable props for equality check
  @override
  List<Object?> get props => [
    movieId,
    title,
    titleAr,
    duration,
    rating,
    trailerLink,
    language,
    imageUrl,
    slug,
  ];

  // Custom toString method
  @override
  String toString() {
    return 'BannerMovieDetailsModel(movieId: $movieId, title: $title, titleAr: $titleAr, '
        'duration: $duration, rating: $rating, trailerLink: $trailerLink, '
        'languages: $language, slug: $slug imageUrl: $imageUrl)';
  }
}