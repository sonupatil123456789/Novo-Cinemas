

import 'package:equatable/equatable.dart';


class SeatPositionModel extends Equatable {
  final int? areaNumber;
  final int? rowIndex;
  final int? columnIndex;

  const SeatPositionModel({
     this.areaNumber,
     this.rowIndex,
     this.columnIndex,
  });



  SeatPositionModel copyWith({
    int? areaNumber,
    int? rowIndex,
    int? columnIndex,
  }) {
    return SeatPositionModel(
      areaNumber: areaNumber ?? this.areaNumber,
      rowIndex: rowIndex ?? this.rowIndex,
      columnIndex: columnIndex ?? this.columnIndex,
    );
  }

  @override
  List<Object?> get props => [areaNumber, rowIndex, columnIndex];

  @override
  String toString() =>
      'SeatPositionModel(areaNumber: $areaNumber, rowIndex: $rowIndex, columnIndex: $columnIndex)';
}