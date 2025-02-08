
import 'package:equatable/equatable.dart';

import 'SeatPositionModel.dart';

class SeatModel extends Equatable {
  final int? colIndex;
  final int? status;
  final int? seatStyle;
  final int? priority;
  final String? name;
  final SeatPositionModel? position;

  const SeatModel({
    this.colIndex,
    this.status,
    this.seatStyle,
    this.priority,
    this.name,
    this.position,
  });



  SeatModel copyWith({
    int? colIndex,
    int? status,
    int? seatStyle,
    int? priority,
    String? name,
    SeatPositionModel? position,
  }) {
    return SeatModel(
      colIndex: colIndex ?? this.colIndex,
      status: status ?? this.status,
      seatStyle: seatStyle ?? this.seatStyle,
      priority: priority ?? this.priority,
      name: name ?? this.name,
      position: position ?? this.position ,
    );
  }


  bool isEmpty() {
    return colIndex == null &&
        status == null &&
        seatStyle == null &&
        priority == null &&
        name == null &&
        position == const SeatPositionModel(rowIndex: null,areaNumber: null,columnIndex: null);
  }

  @override
  List<Object?> get props => [
    colIndex,
    status,
    seatStyle,
    priority,
    name,
    position,
  ];

  @override
  String toString() {
    return 'SeatModel(colIndex: $colIndex, status: $status, seatStyle: $seatStyle, priority: $priority, name: $name, position: $position)';
  }
}
