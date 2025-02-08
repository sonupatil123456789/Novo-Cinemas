
import 'package:equatable/equatable.dart';
import 'package:novocinema/src/Search/domain/models/SearchMovieModel.dart';
import '../../../Movies/data/dto/MovieGenreDto.dart';
import '../../../Movies/data/dto/MovieLanguageDto.dart';

class SearchMovieDto extends Equatable {
  final int? id;
  final String? name;
  final String? nameAr;
  final MovieLanguageDto? languages;
  final List<MovieGenreDto>? genres;
  final String? imageUrl;
  final String? bannerUrl;
  final String? type;

  const SearchMovieDto({
     this.id = 0,
     this.name = '',
     this.nameAr = '',
     this.languages,
     this.genres = const [],
     this.imageUrl = '',
     this.bannerUrl = '',
     this.type = '',
  });

  factory SearchMovieDto.fromJson(Map<String, dynamic> json) {
    return SearchMovieDto(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      nameAr: json['name_ar'] ?? '',
      languages:json['languages']!= null? MovieLanguageDto.fromJson(json['languages']) :MovieLanguageDto.fromJson(const <String,dynamic>{}) ,
      genres:json['genres']!= null? (json['genres'] as List)
          .map((genreJson) => MovieGenreDto.fromJson(genreJson))
          .toList() : [],
      imageUrl: json['image_url'] ?? '',
      bannerUrl: json['banner_url'] ?? '',
      type: json['type'] = '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_ar': nameAr,
      'languages': languages?.toJson() ?? {},
      'genres': genres?.map((genre) => genre.toJson()).toList() ?? [],
      'image_url': imageUrl,
      'banner_url': bannerUrl,
      'type': type,
    };
  }

  SearchMovieDto copyWith({
    int? id,
    String? name,
    String? nameAr,
    MovieLanguageDto? languages,
    List<MovieGenreDto>? genres,
    String? imageUrl,
    String? bannerUrl,
    String? type,
  }) {
    return SearchMovieDto(
      id: id ?? this.id,
      name: name ?? this.name,
      nameAr: nameAr ?? this.nameAr,
      languages: languages ?? this.languages,
      genres: genres ?? this.genres,
      imageUrl: imageUrl ?? this.imageUrl,
      bannerUrl: bannerUrl ?? this.bannerUrl,
      type: type ?? this.type,
    );
  }

  static SearchMovieModel toDomainModel(SearchMovieDto searchMovieDto){
    return SearchMovieModel(
      languages: searchMovieDto.languages,
      name: searchMovieDto.name,
      imageUrl: searchMovieDto.imageUrl,
      bannerUrl: searchMovieDto.bannerUrl,
      genres: searchMovieDto.genres,
      id: searchMovieDto.id,
      nameAr: searchMovieDto.nameAr,
      type: searchMovieDto.type
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    nameAr,
    languages,
    genres,
    imageUrl,
    bannerUrl,
    type,
  ];

  @override
  String toString() {
    return 'SearchMovieDto(id: $id, name: $name, nameAr: $nameAr, '
        'languages: $languages, genres: $genres, '
        'imageUrl: $imageUrl, bannerUrl: $bannerUrl, type: $type)';
  }
}