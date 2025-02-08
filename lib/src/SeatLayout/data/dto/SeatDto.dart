
import 'package:equatable/equatable.dart';
import 'package:novocinema/src/SeatLayout/domain/models/SeatModel.dart';

import '../../domain/models/SeatPositionModel.dart';
import 'SeatPositionDto.dart';

class SeatDto extends Equatable {
  final int? colIndex;
  final int? status;
  final int? seatStyle;
  final int? priority;
  final String? name;
  final SeatPositionDto? position;

  const SeatDto({
    this.colIndex,
    this.status,
    this.seatStyle,
    this.priority,
    this.name,
    this.position,
  });

  factory SeatDto.fromJson(Map<String, dynamic> json) => SeatDto(
    colIndex: json['colIndex'] ,
    status: json['status'] ,
    seatStyle: json['seatStyle'],
    priority: json['priority'] ,
    name: json['name'],
    position: json['position'] == null
        ? null
        : SeatPositionDto.fromJson(json['position'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'colIndex': colIndex,
    'status': status,
    'seatStyle': seatStyle,
    'priority': priority,
    'name': name,
    'position': position?.toJson(),
  };

  SeatDto copyWith({
    int? colIndex,
    int? status,
    int? seatStyle,
    int? priority,
    String? name,
    SeatPositionDto? position,
  }) {
    return SeatDto(
      colIndex: colIndex ?? this.colIndex,
      status: status ?? this.status,
      seatStyle: seatStyle ?? this.seatStyle,
      priority: priority ?? this.priority,
      name: name ?? this.name,
      position: position  ?? this.position ,
    );
  }

  // return SeatDto(
  // colIndex: colIndex ?? this.colIndex,
  // status: status ?? this.status,
  // seatStyle: seatStyle ?? this.seatStyle,
  // priority: priority ?? this.priority,
  // name: name ?? this.name,
  // position: position ?? this.position,
  // );

  static SeatModel toDomainModel(SeatDto seatDto) {
    return SeatModel(
      colIndex: seatDto.colIndex,
        priority: seatDto.priority,
         seatStyle: seatDto.seatStyle,
        status: seatDto.status,
        name: seatDto.name,
        position: SeatPositionDto.toDomainModel(seatDto.position)
    );
  }

  bool isEmpty() {
    return colIndex == null &&
        status == null &&
        seatStyle == null &&
        priority == null &&
        name == null &&
        position == const SeatPositionDto(rowIndex: null,areaNumber: null,columnIndex: null);
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
    return 'SeatDto(colIndex: $colIndex, status: $status, seatStyle: $seatStyle, priority: $priority, name: $name, position: $position)';
  }
}
