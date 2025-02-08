


import 'package:equatable/equatable.dart';
import 'package:novocinema/src/SeatLayout/domain/models/SeatModel.dart';


class RowModel extends Equatable {
  final String? name;
  final int? rowIndex;
  final List<SeatModel>? seats;

  const RowModel({
    this.name,
     this.rowIndex,
     this.seats,
  });



  RowModel copyWith({
    String? name,
    int? rowIndex,
    List<SeatModel>? seats,
  }) {
    return RowModel(
      name: name ?? this.name,
      rowIndex: rowIndex ?? this.rowIndex,
      seats: seats ?? this.seats,
    );
  }

  @override
  List<Object?> get props => [name, rowIndex, seats];

  @override
  String toString() => 'RowModel(name: $name, rowIndex: $rowIndex, seats: $seats)';
}
