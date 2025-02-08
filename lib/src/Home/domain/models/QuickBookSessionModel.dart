
import 'package:equatable/equatable.dart';

class QuickBookSessionModel extends Equatable {
  final String? showTime;
  final String? experience;
  final int? cinemaId;
  final String? sessionId;
  final bool? sessionDisabled;
  final bool? isMidnightShow;

  const QuickBookSessionModel({
     this.showTime = '',
     this.experience = '',
     this.cinemaId = 0 ,
     this.sessionId = '',
     this.sessionDisabled = false ,
     this.isMidnightShow = false,
  });



  QuickBookSessionModel copyWith({
    String? showTime,
    String? experience,
    int? cinemaId,
    String? sessionId,
    bool? sessionDisabled,
    bool? isMidnightShow,
  }) =>
      QuickBookSessionModel(
        showTime: showTime ?? this.showTime,
        experience: experience ?? this.experience,
        cinemaId: cinemaId ?? this.cinemaId,
        sessionId: sessionId ?? this.sessionId,
        sessionDisabled: sessionDisabled ?? this.sessionDisabled,
        isMidnightShow: isMidnightShow ?? this.isMidnightShow,
      );

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
      'QuickBookSessionModel(showTime: $showTime, experience: $experience, cinemaId: $cinemaId, sessionId: $sessionId, sessionDisabled: $sessionDisabled, isMidnightShow: $isMidnightShow)';
}
