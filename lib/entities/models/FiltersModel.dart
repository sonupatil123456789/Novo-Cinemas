


import 'package:equatable/equatable.dart';
import 'package:novocinema/entities/models/ExperienceModel.dart';
import 'package:novocinema/entities/models/GenreModel.dart';
import 'package:novocinema/entities/models/LanguageModel.dart';
import 'package:novocinema/entities/models/LocationModel.dart';


class FiltersModel extends Equatable{


  final List<GenreModel>? genres;
  final List<LanguageModel>? languages;
  final List<LocationModel>? locations;
  final List<ExperienceModel>? experiences ;

  const FiltersModel({
    this.genres = const [],
    this.languages= const [],
    this.locations = const[],
    this.experiences = const[]
  });



  FiltersModel copyWith({
     List<GenreModel>? genres,
     List<LanguageModel>? languages,
     List<LocationModel>? locations,
     List<ExperienceModel>? experiences
  }) {
    return FiltersModel(
        genres: genres ?? this.genres,
        languages : languages??this.languages,
        locations: locations ?? this.locations,
        experiences : experiences??this.experiences
    );
  }



  @override
  String toString() {
    return 'FiltersModel(genres: $genres, languages: $languages, locations: $locations, experiences: $experiences)';
  }



  @override
  List<Object?> get props => [genres, languages, locations, experiences];


}