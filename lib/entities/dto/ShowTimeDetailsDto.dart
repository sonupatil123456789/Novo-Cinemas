import 'package:equatable/equatable.dart';
import '../models/ShowTimeDetailsModel.dart';

class ShowTimeDetailsDto extends Equatable {
  final String? showTime;
  final String? experience;
  final String? sessionId;
  final int? cinemaId;
  final bool? sessionDisabled;
  final bool? isMidnightShow;
  final int? capacity;

  const ShowTimeDetailsDto({
    this.showTime = '',
    this.experience = '',
    this.sessionId = '',
    this.cinemaId = 0,
    this.isMidnightShow = false,
    this.sessionDisabled = false,
    this.capacity,
  });

  factory ShowTimeDetailsDto.fromJson(Map<String, dynamic> json) {
    return ShowTimeDetailsDto(
      showTime: json['show_time'] ?? '',
      experience: json['experience'] ?? '',
      sessionId: json['session_id'] ?? '',
      cinemaId: json['cinemaId'] ?? 0,
      sessionDisabled: json['sessionDisabled'] ?? false,
      isMidnightShow: json['isMidnightShow'] ?? false,
      capacity: json['capacity'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'show_time': showTime,
      'experience': experience,
      'session_id': sessionId,
      'cinemaId': cinemaId,
      'isMidnightShow': isMidnightShow,
      'sessionDisabled': sessionDisabled,
      'capacity': capacity,
    };
  }

  ShowTimeDetailsDto copyWith({
    String? showTime,
    String? experience,
    String? sessionId,
    int? cinemaId,
    bool? sessionDisabled,
    bool? isMidnightShow,
    int? capacity,
  }) {
    return ShowTimeDetailsDto(
      showTime: showTime ?? this.showTime,
      experience: experience ?? this.experience,
      sessionId: sessionId ?? this.sessionId,
      cinemaId: cinemaId ?? this.cinemaId,
      isMidnightShow: isMidnightShow ?? this.isMidnightShow,
      sessionDisabled: sessionDisabled ?? this.sessionDisabled,
      capacity: capacity ?? this.capacity,
    );
  }

  static ShowTimeDetailsModel toDomainModel(
      ShowTimeDetailsDto showTimeDetailsDto) {
    return ShowTimeDetailsModel(
      experience: showTimeDetailsDto.experience,
      sessionId: showTimeDetailsDto.sessionId,
      showTime: showTimeDetailsDto.showTime,
      cinemaId: showTimeDetailsDto.cinemaId,
      sessionDisabled: showTimeDetailsDto.sessionDisabled,
      isMidnightShow: showTimeDetailsDto.isMidnightShow,
      capacity: showTimeDetailsDto.capacity,
    );
  }

  @override
  List<Object?> get props => [
        showTime,
        experience,
        sessionId,
        cinemaId,
        sessionDisabled,
        isMidnightShow,
        capacity,
      ];

  @override
  String toString() {
    return 'ShowTimeDetailsDto(showTime: $showTime, experience: $experience, sessionId: $sessionId, cinemaId: $cinemaId, isMidnightShow: $isMidnightShow, sessionDisabled: $sessionDisabled )';
  }
}
