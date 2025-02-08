import 'package:equatable/equatable.dart';
import 'package:novocinema/src/SeatLayout/domain/models/AreaModel.dart';

import 'RowDto.dart';


class AreaDto extends Equatable {
  final num? priceInCents;
  final num? taxInCents;
  final String? ticketTypeCode ;
  final String? name;
  final num? number;
  final String? areaCategoryCode;
  final List<RowDto>? rows;

  const AreaDto({
     this.taxInCents = 0,
     this.priceInCents = 0 ,
    this.ticketTypeCode = '',
     this.name,
     this.number,
     this.areaCategoryCode,
     this.rows,
  });

  factory AreaDto.fromJson(Map<String, dynamic> json) => AreaDto(
    priceInCents: json['priceInCents'] ?? 0,
    taxInCents: json['taxInCents'] ?? 0,
    ticketTypeCode: json['ticketTypeCode'] ?? '',
    name: json['name'] ?? '',
    number: json['number'] ?? 0,
    areaCategoryCode: json['areaCategoryCode'] ?? '',
    rows: json['row'] != null ? (json['row'] as List<dynamic>)
        .map((e) => RowDto.fromJson(e as Map<String, dynamic>))
        .toList() : [],
  );

  Map<String, dynamic> toJson() => {
    'ticketTypeCode': ticketTypeCode,
    'taxInCents': taxInCents,
    'priceInCents': priceInCents,
    'name': name,
    'number': number,
    'areaCategoryCode': areaCategoryCode,
    'row': rows != null ? rows!.map((e) => e.toJson()).toList() : [],
  };

  AreaDto copyWith({
    num? priceInCents,
    num? taxInCents,
    String? ticketTypeCode ,
    String? name,
    num? number,
    String? areaCategoryCode,
    List<RowDto>? rows,
  }) {
    return AreaDto(
      priceInCents: priceInCents ?? this.priceInCents,
      taxInCents: taxInCents ?? this.taxInCents,
      ticketTypeCode: ticketTypeCode ?? this.ticketTypeCode,
      name: name ?? this.name,
      number: number ?? this.number,
      areaCategoryCode: areaCategoryCode ?? this.areaCategoryCode,
      rows: rows ?? this.rows,
    );
  }

  static AreaModel toDomainModel(AreaDto areaDto) {
    return AreaModel(
      priceInCents:areaDto.priceInCents ,
      taxInCents: areaDto.taxInCents,
      ticketTypeCode: areaDto.ticketTypeCode,
      name: areaDto.name,
      areaCategoryCode: areaDto.areaCategoryCode,
      number: areaDto.number,
      rows: areaDto.rows?.map((toElement)=>RowDto.toDomainModel(toElement)).toList()
    );
  }

  @override
  List<Object?> get props => [
    taxInCents,
    priceInCents,
    ticketTypeCode,
    name,
    number,
    areaCategoryCode,
    rows,
  ];

  @override
  String toString() {
    return 'AreaDto(priceInCents: $priceInCents, taxInCents: $taxInCents, ticketTypeCode: $ticketTypeCode, name: $name, number: $number, areaCategoryCode: $areaCategoryCode, rows: $rows)';
  }
}

