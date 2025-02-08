
import 'package:equatable/equatable.dart';

import '../../domain/models/BannerMovieDetailModel.dart';
import '../../../Movies/data/dto/MovieLanguageDto.dart';

class BannerMovieDetailsDto extends Equatable {
  final int? movieId;
  final String? title ;
  final String? titleAr;
  final int? duration;
  final String? rating;
  final String? trailerLink;
  final MovieLanguageDto? language;
  final String? slug;
  final String? imageUrl;

  const BannerMovieDetailsDto({
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

  // Factory constructor to create from JSON
  factory BannerMovieDetailsDto.fromJson(Map<String, dynamic> json) {
    return BannerMovieDetailsDto(
      movieId: json['movie_id'] ?? 0,
      title: json['title'] ?? '',
      titleAr: json['title_ar'] ?? '',
      duration: json['duration'] ?? 0,
      rating: json['rating'] ?? '',
      trailerLink: json['trailer_link'] ?? '',
      language: json['languages'] != null ? MovieLanguageDto.fromJson(json['languages']) : MovieLanguageDto.fromJson(const <String,dynamic>{}),
      slug: json['slug'] ?? '',
        imageUrl : json['image_url'] ?? ''
    );
  }

  // Copy with method for easy modification
  BannerMovieDetailsDto copyWith({
    int? movieId,
    String? title,
    String? titleAr,
    int? duration,
    String? rating,
    String? trailerLink,
     MovieLanguageDto? language,
     String? slug,
     String? imageUrl,
  }) {
    return BannerMovieDetailsDto(
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

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'movie_id': movieId,
      'title': title,
      'title_ar': titleAr,
      'duration': duration,
      'rating': rating,
      'trailer_link': trailerLink,
      'languages': language?.toJson(),
      'slug': slug,
      'image_url':imageUrl
    };
  }

  static BannerMovieDetailsModel toDomainModel(BannerMovieDetailsDto bannerMovieDetailsDto) {
    return BannerMovieDetailsModel(
      movieId:bannerMovieDetailsDto. movieId ,
      title: bannerMovieDetailsDto.title,
      titleAr: bannerMovieDetailsDto.titleAr,
      duration: bannerMovieDetailsDto.duration,
      rating:bannerMovieDetailsDto.rating,
      trailerLink: bannerMovieDetailsDto.trailerLink,
      language: MovieLanguageDto.toDomainModel(bannerMovieDetailsDto.language!),
      slug: bannerMovieDetailsDto.slug,
      imageUrl: bannerMovieDetailsDto.imageUrl
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
    slug,
    imageUrl
  ];

  // Custom toString method
  @override
  String toString() {
    return 'BannerMovieDetailsDto(movieId: $movieId, title: $title, titleAr: $titleAr, '
        'duration: $duration, rating: $rating, trailerLink: $trailerLink, '
        'languages: $language, slug: $slug imageUrl: $imageUrl)';
  }
}