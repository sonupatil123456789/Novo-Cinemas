import 'package:equatable/equatable.dart';

import '../../domain/models/SeatDetailsModel.dart';

class SeatDetailsDto extends Equatable {
  final String? seats;
  final String? areaName;

  const SeatDetailsDto({
    this.seats = '',
    this.areaName = '',
  });

  factory SeatDetailsDto.fromJson(Map<String, dynamic> json) {
    return SeatDetailsDto(
      seats: json['Seats'],
      areaName: json['AreaName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Seats': seats,
      'AreaName': areaName,
    };
  }

  SeatDetailsDto copyWith({
    String? seats,
    String? areaName,
  }) {
    return SeatDetailsDto(
        seats: seats ?? this.seats, areaName: areaName ?? this.areaName);
  }

  static SeatDetailsModel toDomainModel(SeatDetailsDto seatDetailsDto) {
    return SeatDetailsModel(
        areaName: seatDetailsDto.areaName, seats: seatDetailsDto.seats);
  }

  @override
  List<Object?> get props => [seats, areaName];

  @override
  String toString() {
    return 'SeatDetailsDto(seats: $seats, areaName: $areaName)';
  }
}
