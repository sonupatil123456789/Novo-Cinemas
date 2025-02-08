import 'package:equatable/equatable.dart';

import '../../domain/models/SeatLayoutModel.dart';
import 'AreaDto.dart';

class SeatLayoutDto extends Equatable {
  final num? boundaryLeft;
  final num? boundaryRight;
  final num? boundaryTop;
  final num? screenWidth;
  final num? screenStart;
  final List<AreaDto>? areas;

  const SeatLayoutDto({
     this.boundaryLeft,
     this.boundaryRight,
     this.boundaryTop,
     this.screenWidth,
     this.screenStart,
     this.areas,
  });

  factory SeatLayoutDto.fromJson(Map<String, dynamic> json) => SeatLayoutDto(
    boundaryLeft: json['boundaryLeft'] ?? 0,
    boundaryRight: json['boundaryRight'] ?? 0,
    boundaryTop: json['boundaryTop'] ?? 0,
    screenWidth: json['screenWidth'] ?? 0 ,
    screenStart: json['screenStart'] ?? 0 ,
    areas: json['boundaryLeft'] != null ? (json['areas'] as List<dynamic>)
        .map((e) => AreaDto.fromJson(e as Map<String, dynamic>))
        .toList() : [],
  );

  Map<String, dynamic> toJson() => {
    'boundaryLeft': boundaryLeft,
    'boundaryRight': boundaryRight,
    'boundaryTop': boundaryTop,
    'screenWidth': screenWidth,
    'screenStart': screenStart,
    'areas':areas != null ? areas!.map((e) => e.toJson()).toList() : [],
  };

  SeatLayoutDto copyWith({
    num? boundaryLeft,
    num? boundaryRight,
    num? boundaryTop,
    num? screenWidth,
    num? screenStart,
    List<AreaDto>? areas,
  }) {
    return SeatLayoutDto(
      boundaryLeft: boundaryLeft ?? this.boundaryLeft,
      boundaryRight: boundaryRight ?? this.boundaryRight,
      boundaryTop: boundaryTop ?? this.boundaryTop,
      screenWidth: screenWidth ?? this.screenWidth,
      screenStart: screenStart ?? this.screenStart,
      areas: areas ?? this.areas,
    );
  }

  static SeatLayoutModel toDomainModel(SeatLayoutDto seatLayoutDto) {
    return SeatLayoutModel(
      boundaryLeft: seatLayoutDto.boundaryLeft,
      boundaryRight: seatLayoutDto.boundaryRight,
      boundaryTop: seatLayoutDto.boundaryTop,
      screenStart: seatLayoutDto.screenStart,
      screenWidth: seatLayoutDto.screenWidth,
      areas: seatLayoutDto.areas?.map((toElement)=> AreaDto.toDomainModel(toElement)).toList()
    );
  }

  @override
  List<Object?> get props => [
    boundaryLeft,
    boundaryRight,
    boundaryTop,
    screenWidth,
    screenStart,
    areas,
  ];

  @override
  String toString() {
    return 'SeatLayoutDto(boundaryLeft: $boundaryLeft, boundaryRight: $boundaryRight, boundaryTop: $boundaryTop, screenWidth: $screenWidth, screenStart: $screenStart, areas: $areas)';
  }
}