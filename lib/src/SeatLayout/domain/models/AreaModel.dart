import 'package:equatable/equatable.dart';

import 'RowModel.dart';

class AreaModel extends Equatable {
  final num? priceInCents;
  final num? taxInCents;
  final String? ticketTypeCode ;
  final String? name;
  final num? number;
  final String? areaCategoryCode;
  final List<RowModel>? rows;

  const AreaModel({
    this.taxInCents = 0,
    this.priceInCents = 0 ,
    this.ticketTypeCode = '',
    this.name,
    this.number,
    this.areaCategoryCode,
    this.rows,
  });



  AreaModel copyWith({
    num? priceInCents,
    num? taxInCents,
    String? ticketTypeCode ,
    String? name,
    num? number,
    String? areaCategoryCode,
    List<RowModel>? rows,
  }) {
    return AreaModel(
      priceInCents: priceInCents ?? this.priceInCents,
      taxInCents: taxInCents ?? this.taxInCents,
      ticketTypeCode: ticketTypeCode ?? this.ticketTypeCode,
      name: name ?? this.name,
      number: number ?? this.number,
      areaCategoryCode: areaCategoryCode ?? this.areaCategoryCode,
      rows: rows ?? this.rows,
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
    return 'AreaModel(taxInCents: $taxInCents, priceInCents: $priceInCents, ticketTypeCode: $ticketTypeCode, name: $name, number: $number, areaCategoryCode: $areaCategoryCode, rows: $rows)';
  }
}

