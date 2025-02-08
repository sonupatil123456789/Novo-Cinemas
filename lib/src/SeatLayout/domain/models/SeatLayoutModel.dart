import 'package:equatable/equatable.dart';

import 'AreaModel.dart';

class SeatLayoutModel extends Equatable {
  final num? boundaryLeft;
  final num? boundaryRight;
  final num? boundaryTop;
  final num? screenWidth;
  final num? screenStart;
  final List<AreaModel>? areas;

  const SeatLayoutModel({
     this.boundaryLeft,
     this.boundaryRight,
     this.boundaryTop,
     this.screenWidth,
     this.screenStart,
     this.areas,
  });


  SeatLayoutModel copyWith({
    num? boundaryLeft,
    num? boundaryRight,
    num? boundaryTop,
    num? screenWidth,
    num? screenStart,
    List<AreaModel>? areas,
  }) {
    return SeatLayoutModel(
      boundaryLeft: boundaryLeft ?? this.boundaryLeft,
      boundaryRight: boundaryRight ?? this.boundaryRight,
      boundaryTop: boundaryTop ?? this.boundaryTop,
      screenWidth: screenWidth ?? this.screenWidth,
      screenStart: screenStart ?? this.screenStart,
      areas: areas ?? this.areas,
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
    return 'SeatLayoutModel(boundaryLeft: $boundaryLeft, boundaryRight: $boundaryRight, boundaryTop: $boundaryTop, screenWidth: $screenWidth, screenStart: $screenStart, areas: $areas)';
  }
}