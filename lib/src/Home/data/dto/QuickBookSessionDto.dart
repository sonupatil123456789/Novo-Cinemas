
import 'package:equatable/equatable.dart';

import '../../domain/models/QuickBookSessionModel.dart';

class QuickBookSessionDto extends Equatable {
  final String? showTime;
  final String? experience;
  final int? cinemaId;
  final String? sessionId;
  final bool? sessionDisabled;
  final bool? isMidnightShow;

  const QuickBookSessionDto({
     this.showTime = '',
     this.experience = '',
     this.cinemaId = 0 ,
     this.sessionId = '',
     this.sessionDisabled = false ,
     this.isMidnightShow = false,
  });

  factory QuickBookSessionDto.fromJson(Map<String, dynamic> json) => QuickBookSessionDto(
    showTime: json['show_time'] ?? '',
    experience: json['experience'] ?? '',
    cinemaId: json['cinemaId'] ?? 0,
    sessionId: json['session_id'] ?? '',
    sessionDisabled: json['sessionDisabled'] ?? false,
    isMidnightShow: json['isMidnightShow'] ?? false,
  );

  Map<String, dynamic> toJson() => {
    'show_time': showTime,
    'experience': experience,
    'cinemaId': cinemaId,
    'session_id': sessionId,
    'sessionDisabled': sessionDisabled,
    'isMidnightShow': isMidnightShow,
  };

  QuickBookSessionDto copyWith({
    String? showTime,
    String? experience,
    int? cinemaId,
    String? sessionId,
    bool? sessionDisabled,
    bool? isMidnightShow,
  }) =>
      QuickBookSessionDto(
        showTime: showTime ?? this.showTime,
        experience: experience ?? this.experience,
        cinemaId: cinemaId ?? this.cinemaId,
        sessionId: sessionId ?? this.sessionId,
        sessionDisabled: sessionDisabled ?? this.sessionDisabled,
        isMidnightShow: isMidnightShow ?? this.isMidnightShow,
      );

  static QuickBookSessionModel toDomainModel(QuickBookSessionDto quickBookSessionDto){
    return QuickBookSessionModel(
        experience: quickBookSessionDto.experience,
      isMidnightShow: quickBookSessionDto.isMidnightShow,
      sessionDisabled: quickBookSessionDto.sessionDisabled,
      cinemaId: quickBookSessionDto.cinemaId,
       showTime: quickBookSessionDto.showTime,
      sessionId: quickBookSessionDto.sessionId
    );
  }

  @override
  List<Object?> get props => [
    showTime,
    experience,
    cinemaId,
    sessionId,
    sessionDisabled,
    isMidnightShow
  ];

  @override
  String toString() =>
      'QuickBookSessionDto(showTime: $showTime, experience: $experience, cinemaId: $cinemaId, sessionId: $sessionId, sessionDisabled: $sessionDisabled, isMidnightShow: $isMidnightShow)';
}
