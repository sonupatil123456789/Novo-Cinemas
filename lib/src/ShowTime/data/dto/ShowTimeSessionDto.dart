

import 'package:equatable/equatable.dart';
import 'package:novocinema/src/ShowTime/domain/models/ShowTimeSessionModel.dart';
import 'ShowTimeDataDto.dart';

class ShowTimeSessionDto extends Equatable {
  final ShowTimesDataDto? sessions;
  // final ShowTimeFiltersDto? filters;

  const ShowTimeSessionDto({
    this.sessions,
    // this.filters,
  });

  factory ShowTimeSessionDto.fromJson(Map<String, dynamic> json) {
    return ShowTimeSessionDto(
      sessions:json['sessions'] != null ? ShowTimesDataDto.fromJson(json['sessions']) : ShowTimesDataDto.fromJson(const <String,dynamic>{}),
      // filters:json['filters'] != null ? ShowTimeFiltersDto.fromJson(json['filters']) : ShowTimeFiltersDto.fromJson(const <String,dynamic>{})
    );
  }


  ShowTimeSessionDto copyWith({
    ShowTimesDataDto? sessions,
    // ShowTimeFiltersDto? filters
  }) {
    return ShowTimeSessionDto(
        sessions : sessions ?? this.sessions,
        // filters : filters ?? this.filters
    );
  }

  static ShowTimeSessionModel toDomainModel(ShowTimeSessionDto getSessionDto) {
    return ShowTimeSessionModel(
        sessions: ShowTimesDataDto.toDomainModel(getSessionDto.sessions!),
        // filters: ShowTimeFiltersDto.toDomainModel(getSessionDto.filters!)
    );
  }

  @override
  List<Object?> get props => [sessions];

  @override
  String toString() {
    return 'ShowTimeSessionDto(sessions: $sessions)';
  }
}
