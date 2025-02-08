


import 'package:equatable/equatable.dart';
import 'package:novocinema/src/ShowTime/domain/models/ShowTimeMoviesModel.dart';


class ShowTimeMallLocationModel extends Equatable {
  final Map<String,Map<String,Map<String,ShowTimeMovieModel>>>? mallLocation;

  const ShowTimeMallLocationModel({this.mallLocation});




  ShowTimeMallLocationModel copyWith({
    Map<String,Map<String,Map<String,ShowTimeMovieModel>>>? mallLocation
  }) {
    return ShowTimeMallLocationModel(
      mallLocation: mallLocation ?? this.mallLocation,
    );
  }



  @override
  List<Object?> get props => [mallLocation];

  @override
  String toString() {
    return 'ShowTimeMallLocationModel(mallLocation: $mallLocation)';
  }
}
