import 'package:equatable/equatable.dart';
import 'package:novocinema/entities/dto/ExperienceDto.dart';
import 'package:novocinema/entities/dto/GenreDto.dart';
import 'package:novocinema/entities/dto/LocationDto.dart';
import 'package:novocinema/entities/models/FiltersModel.dart';

import 'LanguageDto.dart';

class FiltersDto extends Equatable {
  final List<GenreDto>? genres;
  final List<LanguageDto>? languages;
  final List<LocationDto>? locations;
  final List<ExperienceDto>? experiences;

  const FiltersDto(
      {this.genres = const [],
      this.languages = const [],
      this.locations = const [],
      this.experiences = const []});

  factory FiltersDto.fromJson(Map<String, dynamic> json) {
    return FiltersDto(
      genres: json['genres'] != null
          ? (json['genres'] as List<dynamic>)
              .map((toElement) => GenreDto.fromJson(toElement))
              .toList()
          : [],
      languages: json['languages'] != null
          ? (json['languages'] as List<dynamic>)
              .map((toElement) => LanguageDto.fromJson(toElement))
              .toList()
          : [],
      locations: json['locations'] != null
          ? (json['locations'] as List<dynamic>)
              .map((toElement) => LocationDto.fromJson(toElement))
              .toList()
          : [],
      experiences: json['experiences'] != null
          ? (json['experiences'] as List<dynamic>)
              .map((toElement) => ExperienceDto.fromJson(toElement))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'genres': genres?.map((toElement) => toElement.toJson()).toList(),
      'languages': languages?.map((toElement) => toElement.toJson()).toList(),
      'locations': locations?.map((toElement) => toElement.toJson()).toList(),
      'experiences':
          experiences?.map((toElement) => toElement.toJson()).toList()
    };
  }

  FiltersDto copyWith(
      {List<GenreDto>? genres,
      List<LanguageDto>? languages,
      List<LocationDto>? locations,
      List<ExperienceDto>? experiences}) {
    return FiltersDto(
        genres: genres ?? this.genres,
        languages: languages ?? this.languages,
        locations: locations ?? this.locations,
        experiences: experiences ?? this.experiences);
  }

  static FiltersModel toDomainModel(FiltersDto? filtersDto) {
    return FiltersModel(
        genres: filtersDto?.genres
            ?.map((toElement) => GenreDto.toDomainModel(toElement))
            .toList(),
        experiences: filtersDto?.experiences
            ?.map((toElement) => ExperienceDto.toDomainModel(toElement))
            .toList(),
        languages: filtersDto?.languages
            ?.map((toElement) => LanguageDto.toDomainModel(toElement))
            .toList(),
        locations: filtersDto?.locations
            ?.map((toElement) => LocationDto.toDomainModel(toElement))
            .toList());
  }

  @override
  String toString() {
    return 'FiltersDto(genres: $genres, languages: $languages, locations: $locations, experiences: $experiences)';
  }

  @override
  List<Object?> get props => [genres, languages, locations, experiences];
}
