


import 'package:equatable/equatable.dart';
import 'package:novocinema/src/ShowTime/data/dto/ShowTimeMoviesDto.dart';
import 'package:novocinema/src/ShowTime/domain/models/ShowTimeMallLocationModel.dart';
import 'package:novocinema/src/ShowTime/domain/models/ShowTimeMoviesModel.dart';


class ShowTimeMallLocationDto extends Equatable {
  final Map<String,Map<String,Map<String,ShowTimeMovieDto>>>? mallLocation;

  const ShowTimeMallLocationDto({this.mallLocation});

  factory ShowTimeMallLocationDto.fromJson(Map<String, dynamic> json) {
    return  ShowTimeMallLocationDto(mallLocation :json != null ? Map.fromEntries(
      json.entries.map((entry) {

        return MapEntry(
            entry.key,
            entry.value != null ?
            Map.fromEntries((entry.value as Map<String,dynamic>).entries.map((movie){

              return MapEntry(movie.key,
                  movie.value != null ? Map.fromEntries((movie.value as Map<String,dynamic>).entries.map((toElement){
                    return MapEntry(toElement.key, ShowTimeMovieDto.fromJson(toElement.value));
                  })) : <String,ShowTimeMovieDto>{}

              );

            })): <String,Map<String,ShowTimeMovieDto>>{}
        );
      }
      ),
    ) : <String,Map<String,Map<String,ShowTimeMovieDto>>>{});
  }



  ShowTimeMallLocationDto copyWith({
    Map<String,Map<String,Map<String,ShowTimeMovieDto>>>? mallLocation
  }) {
    return ShowTimeMallLocationDto(
      mallLocation: mallLocation ?? this.mallLocation,
    );
  }

  static ShowTimeMallLocationModel toDomainModel(ShowTimeMallLocationDto showTimeMallLocationDto) {
    return  ShowTimeMallLocationModel(mallLocation :showTimeMallLocationDto.mallLocation != null ? Map.fromEntries(
      showTimeMallLocationDto.mallLocation!.entries.map((entry) {

        return MapEntry(
            entry.key,
            entry.value != null ?
            Map.fromEntries((entry.value as Map<String,dynamic>).entries.map((movie){

              return MapEntry(movie.key,
                  Map.fromEntries((movie.value as Map<String,ShowTimeMovieDto>).entries.map((toElement){
                    return MapEntry(toElement.key, ShowTimeMovieDto.toDomainModel(toElement.value));
                  }))

              );

            })): <String,Map<String,ShowTimeMovieModel>>{}
        );
      }
      ),
    ) : <String,Map<String,Map<String,ShowTimeMovieModel>>>{});

  }

  @override
  List<Object?> get props => [mallLocation];

  @override
  String toString() {
    return 'ShowTimeMallLocationDto(mallLocation: $mallLocation)';
  }
}
