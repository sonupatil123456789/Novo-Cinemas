import 'package:equatable/equatable.dart';
import 'package:novocinema/src/Movies/data/dto/MovieDto.dart';
import '../models/GetAllMoviesModel.dart';
import 'FiltersDto.dart';

class GetAllMoviesDto extends Equatable {
  final List<MovieDto>? movies;
  final FiltersDto? filters;

  const GetAllMoviesDto({
    this.movies,
    this.filters,
  });

  factory GetAllMoviesDto.fromJson(Map<String, dynamic> json) {
    return GetAllMoviesDto(
      movies: (json['movies'] as List<dynamic>)
              .map((movieMapper) => MovieDto.fromJson(movieMapper))
              .toList() ??
          [],
      filters: FiltersDto.fromJson(json['filters']),
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'filters': filters,
  //   };
  // }

  GetAllMoviesDto copyWith({
    List<MovieDto>? movies,
    FiltersDto? filters
  }) {
    return GetAllMoviesDto(
      movies: movies ?? this.movies,
      filters: filters ?? this.filters,
    );
  }

  static GetAllMoviesModel toDomainModel(GetAllMoviesDto getAllMoviesDto) {
    return GetAllMoviesModel(
        filters: FiltersDto.toDomainModel(getAllMoviesDto.filters),
        movies: getAllMoviesDto.movies?.map((toElement)=>MovieDto.toDomainModel(toElement)).toList());
  }

  @override
  List<Object?> get props => [movies, filters];

  @override
  String toString() {
    return 'GetAllMoviesDto(movies: $movies, filters: $filters)';
  }
}
