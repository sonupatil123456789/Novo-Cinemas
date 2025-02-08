

import 'package:equatable/equatable.dart';
import 'package:novocinema/src/Movies/data/dto/MovieDto.dart';
import 'package:novocinema/entities/models/FiltersModel.dart';
import 'package:novocinema/src/Movies/domain/models/MovieModel.dart';


class GetAllMoviesModel extends Equatable {
  final List<MovieModel>? movies;
  final FiltersModel? filters;


  const GetAllMoviesModel({
    this.movies,
    this.filters
  });



  GetAllMoviesModel copyWith({
    List<MovieModel>? movies,
     FiltersModel? filters
  }) {
    return GetAllMoviesModel(
      movies: movies ?? this.movies,
        filters : filters ?? this.filters
    );
  }

  @override
  List<Object?> get props => [movies, filters];


}