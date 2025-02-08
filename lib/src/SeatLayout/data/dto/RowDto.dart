import 'package:equatable/equatable.dart';
import 'package:novocinema/src/SeatLayout/data/dto/SeatDto.dart';
import 'package:novocinema/src/SeatLayout/domain/models/RowModel.dart';

class RowDto extends Equatable {
  final String? name;
  final int? rowIndex;
  final List<SeatDto>? seats;

  const RowDto({
    this.name,
    this.rowIndex,
    this.seats,
  });

  factory RowDto.fromJson(Map<String, dynamic> json) => RowDto(
        name: json['name'] ?? '',
        rowIndex: json['rowIndex'] ?? 0,
        seats: json['seats'] != null
            ? (json['seats'] as List<dynamic>)
                .map((e) => SeatDto.fromJson(e as Map<String, dynamic>))
                .toList()
            : [],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'rowIndex': rowIndex,
        'seats': seats != null ? seats!.map((e) => e.toJson()).toList() : [],
      };

  RowDto copyWith({
    String? name,
    int? rowIndex,
    List<SeatDto>? seats,
  }) {
    return RowDto(
      name: name ?? this.name,
      rowIndex: rowIndex ?? this.rowIndex,
      seats: seats ?? this.seats,
    );
  }

  static RowModel toDomainModel(RowDto rowDto) {
    return RowModel(
        seats: rowDto.seats
            ?.map((toElement) => SeatDto.toDomainModel(toElement))
            .toList(),
        name: rowDto.name,
        rowIndex: rowDto.rowIndex);
  }

  @override
  List<Object?> get props => [name, rowIndex, seats];

  @override
  String toString() =>
      'RowDto(name: $name, rowIndex: $rowIndex, seats: $seats)';
}
