import 'package:equatable/equatable.dart';

class ShowTimeDetailsModel extends Equatable {
  final String? showTime;
  final String? experience;
  final String? sessionId;
  final int? cinemaId;
  final bool? sessionDisabled;
  final bool? isMidnightShow;
  final int? capacity;

  const ShowTimeDetailsModel({
    this.showTime,
    this.experience,
    this.sessionId,
    this.cinemaId,
    this.isMidnightShow,
    this.sessionDisabled,
    this.capacity,
  });

  ShowTimeDetailsModel copyWith({
    String? showTime,
    String? experience,
    String? sessionId,
    int? cinemaId,
    bool? sessionDisabled,
    bool? isMidnightShow,
    int? capacity,
  }) {
    return ShowTimeDetailsModel(
      showTime: showTime ?? this.showTime,
      experience: experience ?? this.experience,
      sessionId: sessionId ?? this.sessionId,
      cinemaId: cinemaId ?? this.cinemaId,
      isMidnightShow: isMidnightShow ?? this.isMidnightShow,
      sessionDisabled: sessionDisabled ?? this.sessionDisabled,
      capacity: capacity ?? this.capacity,
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
    return 'ShowTimeDetailsModel(showTime: $showTime, experience: $experience, sessionId: $sessionId, cinemaId: $cinemaId, sessionDisabled: $sessionDisabled, isMidnightShow: $isMidnightShow)';
  }
}
