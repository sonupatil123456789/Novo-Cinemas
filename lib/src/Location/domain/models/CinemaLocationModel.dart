import 'package:equatable/equatable.dart';

class CinemaLocationModel extends Equatable {
  final String? name;
  final String? nameAr;
  final dynamic lat;
  final dynamic long;
  final int? id;
  final String? vistaId;
  final String? address;
  final dynamic addressAr;
  final bool? isLikedCinema;

  const CinemaLocationModel({
    this.name,
    this.nameAr,
    this.lat,
    this.long,
    this.id,
    this.vistaId,
    this.address,
    this.addressAr,
    this.isLikedCinema,
  });

  CinemaLocationModel copyWith({
    String? name,
    String? nameAr,
    dynamic lat,
    dynamic long,
    int? id,
    String? vistaId,
    String? address,
    dynamic addressAr,
    bool? isLikedCinema
  }) {
    return CinemaLocationModel(
      name: name ?? this.name,
      nameAr: nameAr ?? this.nameAr,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      id: id ?? this.id,
      vistaId: vistaId ?? this.vistaId,
      address: address ?? this.address,
      addressAr: addressAr ?? this.addressAr,
      isLikedCinema: isLikedCinema ?? this.isLikedCinema,
    );
  }

  @override
  List<Object?> get props => [
    name,
    nameAr,
    lat,
    long,
    id,
    vistaId,
    address,
    addressAr,
    isLikedCinema,
  ];

  @override
  String toString() {
    return 'CinemaLocationModel(name: $name, nameAr: $nameAr, lat: $lat, long: $long, id: $id, vistaId: $vistaId, address: $address, addressAr: $addressAr, isLikedCinema: $isLikedCinema)';
  }
}