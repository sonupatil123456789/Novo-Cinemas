import 'package:equatable/equatable.dart';

class MovieFilterDataModel extends Equatable {
  final List<String>? languages;
  final List<MovieFilterLocationModel>? locations;
  final List<MovieFilterFormatModel>? formats;
  final List<String>? timings;

  const MovieFilterDataModel({
    this.languages,
    this.locations,
    this.formats,
    this.timings,
  });

  MovieFilterDataModel copyWith({
    List<String>? languages,
    List<MovieFilterLocationModel>? locations,
    List<MovieFilterFormatModel>? formats,
    List<String>? timings,
  }) {
    return MovieFilterDataModel(
      languages: languages ?? this.languages,
      locations: locations ?? this.locations,
      formats: formats ?? this.formats,
      timings: timings ?? this.timings,
    );
  }

  @override
  List<Object?> get props => [languages, locations, formats, timings];

  @override
  String toString() {
    return 'MovieFilterDataModel(languages: $languages, locations: $locations, formats: $formats, timings: $timings)';
  }
}

class MovieFilterLocationModel extends Equatable {
  final int id;
  final String name;

  const MovieFilterLocationModel({
    required this.id,
    required this.name,
  });

  // Copy constructor (for immutability)
  MovieFilterLocationModel copyWith({
    int? id,
    String? name,
  }) {
    return MovieFilterLocationModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [id, name];

  @override
  String toString() => 'MovieFilterLocationModel(id: $id, name: $name)';
}

class MovieFilterFormatModel extends Equatable {
  final int id;
  final String name;

  const MovieFilterFormatModel({
    required this.id,
    required this.name,
  });

  // Copy constructor (for immutability)
  MovieFilterFormatModel copyWith({
    int? id,
    String? name,
  }) {
    return MovieFilterFormatModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [id, name];

  @override
  String toString() => 'MovieFilterFormatModel(id: $id, name: $name)';
}

