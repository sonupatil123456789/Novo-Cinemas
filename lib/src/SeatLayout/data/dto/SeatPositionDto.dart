

import 'package:equatable/equatable.dart';
import 'package:novocinema/src/SeatLayout/domain/models/SeatPositionModel.dart';


class SeatPositionDto extends Equatable {
  final int? areaNumber;
  final int? rowIndex;
  final int? columnIndex;

  const SeatPositionDto({
     this.areaNumber,
     this.rowIndex,
     this.columnIndex,
  });

  factory SeatPositionDto.fromJson(Map<String, dynamic> json) => SeatPositionDto(
    areaNumber: json['AreaNumber'] ?? 0,
    rowIndex: json['RowIndex'] ?? 0,
    columnIndex: json['ColumnIndex'] ?? 0 ,
  );

  Map<String, dynamic> toJson() => {
    'AreaNumber': areaNumber,
    'RowIndex': rowIndex,
    'ColumnIndex': columnIndex,
  };

  SeatPositionDto copyWith({
    int? areaNumber,
    int? rowIndex,
    int? columnIndex,
  }) {
    return SeatPositionDto(
      areaNumber: areaNumber ?? this.areaNumber,
      rowIndex: rowIndex ?? this.rowIndex,
      columnIndex: columnIndex ?? this.columnIndex,
    );
  }

  static SeatPositionModel toDomainModel(SeatPositionDto? seatPositionDto) {
    return SeatPositionModel(areaNumber: seatPositionDto?.areaNumber, rowIndex: seatPositionDto?.rowIndex, columnIndex: seatPositionDto?.columnIndex);
  }

  bool isEmpty() {
    return areaNumber == null &&
        rowIndex == null &&
        columnIndex == null;
  }

  @override
  List<Object?> get props => [areaNumber, rowIndex, columnIndex];

  @override
  String toString() =>
      'SeatPositionDto(areaNumber: $areaNumber, rowIndex: $rowIndex, columnIndex: $columnIndex)';
}