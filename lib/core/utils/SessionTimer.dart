import 'dart:async';
import 'package:flutter/material.dart';


const  SEASSION_TIMER_DURATION = 600;

class SessionTimer {
  static final SessionTimer _instance = SessionTimer._internal();

  factory SessionTimer() {
    return _instance;
  }

  SessionTimer._internal();

  final _countdownController = StreamController<Map<String, dynamic>>.broadcast();

  Timer? _timer;
  int _remainingTime = 0;
  // VoidCallback? _onSessionExpired;

  Stream<Map<String, dynamic>> get countdownStream => _countdownController.stream;

  Map<String, dynamic> _formatTimeToMap(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;

    return {
      'minutes': minutes,
      'seconds': seconds
    };
  }

  // New method to extend timer
  void extendTime(int additionalSeconds) {
    if (_timer != null && _timer!.isActive) {
      _remainingTime += additionalSeconds;
      _countdownController.add(_formatTimeToMap(_remainingTime));
    }
  }

  void startTimer({
    required int duration,
    required BuildContext context,
    Function(int)? onSessionExpired,
     required Function(int) sessionTime,
    required int remainingTimerAlert
  }) {
    _timer?.cancel();
    _remainingTime = duration;

    _countdownController.add(_formatTimeToMap(_remainingTime));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _remainingTime--;
      if(remainingTimerAlert ==_remainingTime){
        sessionTime(_remainingTime);
      }
      // print(" timer ===> $_remainingTime");
      _countdownController.add(_formatTimeToMap(_remainingTime));

      if (_remainingTime <= 0) {
        print(" remaining timer smaller than 0 $_remainingTime");
        onSessionExpired!(_remainingTime);
        stopTimer();
      }
    });
  }

  void pauseTimer() {
    _timer?.cancel();
  }

  void resumeTimer(BuildContext context) {
    if (_remainingTime > 0) {
      startTimer(
          duration: _remainingTime,
          context: context, sessionTime: (int time) {  },
          remainingTimerAlert: 0
      );
    }
  }

  void stopTimer() {
    _timer?.cancel();

    // if (_onSessionExpired != null) {
    //   _onSessionExpired!();
    // }

    _remainingTime = 0;
    _countdownController.add(_formatTimeToMap(_remainingTime));
  }

  Map<String, dynamic> get currentTimeFormatted => _formatTimeToMap(_remainingTime);

  int get currentTimeInSeconds => _remainingTime;

  void dispose() {
    _timer?.cancel();
    _countdownController.close();
  }
}


// import 'dart:async';
// import 'package:flutter/material.dart';
// import '../constants/RoutesName.dart';
//
// class SessionTimer {
//   static final SessionTimer _instance = SessionTimer._internal();
//
//   factory SessionTimer() {
//     return _instance;
//   }
//
//   SessionTimer._internal();
//
//   // Changed stream type to Map<String, dynamic>
//   final _countdownController = StreamController<Map<String, dynamic>>.broadcast();
//
//   Timer? _timer;
//   int _remainingTime = 0;
//   VoidCallback? _onSessionExpired;
//
//   // Updated stream getter with new type
//   Stream<Map<String, dynamic>> get countdownStream => _countdownController.stream;
//
//   /// Convert time into a Map with minutes and seconds
//   Map<String, dynamic> _formatTimeToMap(int totalSeconds) {
//     final minutes = totalSeconds ~/ 60;
//     final seconds = totalSeconds % 60;
//
//     return {
//       'minutes': minutes,
//       'seconds': seconds
//     };
//   }
//
//   void startTimer({
//     required int duration,
//     required BuildContext context,
//     Function(int)? onSessionExpired
//   }) {
//     _timer?.cancel();
//     _remainingTime = duration;
//
//     // _onSessionExpired = onSessionExpired ?? () {
//     //   Navigator.popUntil(
//     //     context,
//     //         (route) => route.settings.name == RoutesName.seatLayoutScreen,
//     //   );
//     // };
//
//     // Add initial map value to stream
//     _countdownController.add(_formatTimeToMap(_remainingTime));
//
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       _remainingTime--;
//       print(" timer ===> $_remainingTime");
//       // Add current time as map to stream
//       _countdownController.add(_formatTimeToMap(_remainingTime));
//
//       if (_remainingTime <= 0) {
//         print(" remaining timer smaller than 0 $_remainingTime");
//         onSessionExpired!(_remainingTime);
//         stopTimer();
//       }
//     });
//   }
//
//   void pauseTimer() {
//     _timer?.cancel();
//   }
//
//   void resumeTimer(BuildContext context) {
//     if (_remainingTime > 0) {
//       startTimer(
//           duration: _remainingTime,
//           context: context
//       );
//     }
//   }
//
//   void stopTimer() {
//     _timer?.cancel();
//
//     if (_onSessionExpired != null) {
//       _onSessionExpired!();
//     }
//
//     _remainingTime = 0;
//     _countdownController.add(_formatTimeToMap(_remainingTime));
//   }
//
//   // Updated to return Map
//   Map<String, dynamic> get currentTimeFormatted => _formatTimeToMap(_remainingTime);
//
//   int get currentTimeInSeconds => _remainingTime;
//
//   void dispose() {
//     _timer?.cancel();
//     _countdownController.close();
//   }
// }