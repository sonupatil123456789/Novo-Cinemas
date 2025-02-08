

import 'package:equatable/equatable.dart';
import 'ShowTimeDataModel.dart';

class ShowTimeSessionModel extends Equatable {
  final ShowTimesDataModel? sessions;
  // final ShowTimeFiltersDto? filters;

  const ShowTimeSessionModel({
    this.sessions,
    // this.filters,
  });



  ShowTimeSessionModel copyWith({
    ShowTimesDataModel? sessions,
    // ShowTimeFiltersDto? filters
  }) {
    return ShowTimeSessionModel(
        sessions : sessions ?? this.sessions,
        // filters : filters ?? this.filters
    );
  }


  @override
  List<Object?> get props => [sessions];

  @override
  String toString() {
    return 'ShowTimeSessionModel(sessions: $sessions)';
  }
}
