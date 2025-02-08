import 'package:equatable/equatable.dart';

import '../../domain/models/CinemaModel.dart';

class SeatDetailsModel extends Equatable {
  final String? seats;
  final String? areaName;

  const SeatDetailsModel({
    this.seats = '',
    this.areaName = '',
  });



  SeatDetailsModel copyWith({
     String? seats,
     String? areaName,
  }) {
    return SeatDetailsModel(
      seats:  seats ?? this.seats,
      areaName: areaName?? this.areaName
    );
  }


  @override
  List<Object?> get props => [seats, areaName];

  @override
  String toString() {
    return 'SeatDetailsModel(seats: $seats, areaName: $areaName)';
  }
}