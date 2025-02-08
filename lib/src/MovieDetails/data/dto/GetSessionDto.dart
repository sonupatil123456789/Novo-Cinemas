

import 'package:equatable/equatable.dart';

import '../../domain/models/GetSessionModel.dart';
import 'MovieFiltersDataDto.dart';
import 'ShowTimeDataDto.dart';

class GetSessionDto extends Equatable {
  final ShowTimesDataDto? sessions;
  final MovieFilterDataDto? filters;

  const GetSessionDto({
    this.sessions,
    this.filters,
  });

  factory GetSessionDto.fromJson(Map<String, dynamic> json) {
    return GetSessionDto(
      sessions:json['sessions'] != null ? ShowTimesDataDto.fromJson(json['sessions']) : ShowTimesDataDto.fromJson(const <String,dynamic>{}),
      filters:json['filters'] != null ? MovieFilterDataDto.fromJson(json['filters']) : MovieFilterDataDto.fromJson(const <String,dynamic>{})
    );
  }


  GetSessionDto copyWith({
    ShowTimesDataDto? sessions,
    MovieFilterDataDto? filters
  }) {
    return GetSessionDto(
        sessions : sessions ?? this.sessions,
        filters : filters ?? this.filters
    );
  }

  static GetSessionModel toDomainModel(GetSessionDto getSessionDto) {
    return GetSessionModel(sessions: ShowTimesDataDto.toDomainModel(getSessionDto.sessions!), filters: MovieFilterDataDto.toDomainModel(getSessionDto.filters!));
  }

  @override
  List<Object?> get props => [sessions];

  @override
  String toString() {
    return 'GetSessionDto(sessions: $sessions)';
  }
}
