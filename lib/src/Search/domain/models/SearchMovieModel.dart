
import 'package:equatable/equatable.dart';
import '../../../Movies/data/dto/MovieGenreDto.dart';
import '../../../Movies/data/dto/MovieLanguageDto.dart';

class SearchMovieModel extends Equatable {
  final int? id;
  final String? name;
  final String? nameAr;
  final MovieLanguageDto? languages;
  final List<MovieGenreDto>? genres;
  final String? imageUrl;
  final String? bannerUrl;
  final String? type;

  const SearchMovieModel({
     this.id = 0,
     this.name = '',
     this.nameAr = '',
     this.languages,
     this.genres = const [],
     this.imageUrl = '',
     this.bannerUrl = '',
     this.type = '',
  });


  SearchMovieModel copyWith({
    int? id,
    String? name,
    String? nameAr,
    MovieLanguageDto? languages,
    List<MovieGenreDto>? genres,
    String? imageUrl,
    String? bannerUrl,
    String? type,
  }) {
    return SearchMovieModel(
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
    return 'SearchMovieModel(id: $id, name: $name, nameAr: $nameAr, '
        'languages: $languages, genres: $genres, '
        'imageUrl: $imageUrl, bannerUrl: $bannerUrl, type: $type)';
  }
}