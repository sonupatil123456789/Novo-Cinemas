import 'package:equatable/equatable.dart';

import '../../domain/models/MovieFiltersDataModel.dart';

class MovieFilterLocationDto extends Equatable {
  final int id;
  final String name;

  const MovieFilterLocationDto({required this.id, required this.name});

  factory MovieFilterLocationDto.fromJson(Map<String, dynamic> json) {
    return MovieFilterLocationDto(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  List<Object?> get props => [id, name];

  @override
  String toString() => 'MovieFilterLocationDto(id: $id, name: $name)';
}

class MovieFilterFormatDto extends Equatable {
  final int id;
  final String name;

  const MovieFilterFormatDto({required this.id, required this.name});

  factory MovieFilterFormatDto.fromJson(Map<String, dynamic> json) {
    return MovieFilterFormatDto(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  List<Object?> get props => [id, name];

  @override
  String toString() => 'MovieFilterFormatDto(id: $id, name: $name)';
}

class MovieFilterDataDto extends Equatable {
  final List<String>? languages;
  final List<MovieFilterLocationDto>? locations;
  final List<MovieFilterFormatDto>? formats;
  final List<String>? timings;

  const MovieFilterDataDto({
    this.languages,
    this.locations,
    this.formats,
    this.timings,
  });

  factory MovieFilterDataDto.fromJson(Map<String, dynamic> json) {
    return MovieFilterDataDto(
      languages: json['languages'] != null
          ? List<String>.from(json['languages'])
          : [],
      locations: json['locations'] != null
          ? List<MovieFilterLocationDto>.from(
        json['locations'].map((item) => MovieFilterLocationDto.fromJson(item)),
      )
          : [],
      formats: json['formats'] != null
          ? List<MovieFilterFormatDto>.from(
        json['formats'].map((item) => MovieFilterFormatDto.fromJson(item)),
      )
          : [],
      timings: json['timings'] != null
          ? List<String>.from(json['timings'])
          : [],
    );
  }

  MovieFilterDataDto copyWith({
    List<String>? languages,
    List<MovieFilterLocationDto>? locations,
    List<MovieFilterFormatDto>? formats,
    List<String>? timings,
  }) {
    return MovieFilterDataDto(
      languages: languages ?? this.languages,
      locations: locations ?? this.locations,
      formats: formats ?? this.formats,
      timings: timings ?? this.timings,
    );
  }

  static MovieFilterDataModel toDomainModel(MovieFilterDataDto movieFiltersDataDto) {
    return MovieFilterDataModel(
      languages: movieFiltersDataDto.languages ?? [],
      locations: movieFiltersDataDto.locations != null
          ? movieFiltersDataDto.locations!.map((dto) => MovieFilterLocationModel(
        id: dto.id,
        name: dto.name,
      )).toList()
          : [],
      formats: movieFiltersDataDto.formats != null
          ? movieFiltersDataDto.formats!.map((dto) => MovieFilterFormatModel(
        id: dto.id,
        name: dto.name,
      )).toList()
          : [],
      timings: movieFiltersDataDto.timings ?? [],
    );
  }

  @override
  List<Object?> get props => [languages, locations, formats, timings];

  @override
  String toString() {
    return 'MovieFiltersDataDto(languages: $languages, locations: $locations, formats: $formats, timings: $timings)';
  }
}
