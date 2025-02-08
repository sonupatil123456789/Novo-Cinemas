

import 'package:equatable/equatable.dart';

import 'MovieFiltersDataModel.dart';
import 'ShowTimesDataModel.dart';

class GetSessionModel extends Equatable {
  final ShowTimesDataModel? sessions;
  final MovieFilterDataModel? filters;

  const GetSessionModel({
    this.sessions,
    this.filters,
  });



  // GetSessionDto copyWith({
  //   List<MovieDto>? movies,
  // }) {
  //   return GetSessionDto(
  //     movies: movies ?? this.movies,
  //     filters: filters ?? this.filters,
  //   );
  // }



  @override
  List<Object?> get props => [sessions];

  @override
  String toString() {
    return 'GetSessionModel(sessions: $sessions)';
  }
}

