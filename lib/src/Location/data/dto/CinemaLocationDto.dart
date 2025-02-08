import 'package:equatable/equatable.dart';
import 'package:novocinema/src/Location/domain/models/CinemaLocationModel.dart';

class CinemaLocationDto extends Equatable {
  final String? name;
  final String? nameAr;
  final dynamic lat;
  final dynamic long;
  final int? id;
  final String? vistaId;
  final String? address;
  final dynamic addressAr;
  final bool? isLikedCinema;

  const CinemaLocationDto({
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

  factory CinemaLocationDto.fromJson(Map<String, dynamic> json) {
    return CinemaLocationDto(
      name: json["name"] ?? "",
      nameAr: json["name_ar"] ?? "",
      lat: json["lat"] ?? "",
      long: json["long"] ?? "",
      id: json["id"] ?? 0,
      vistaId: json["vista_id"] ?? "",
      address: json["address"] ?? "",
      addressAr: json["address_ar"] ?? "",
      isLikedCinema: json["isLikedCinema"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "name_ar": nameAr,
      "lat": lat,
      "long": long,
      "id": id,
      "vista_id": vistaId,
      "address": address,
      "address_ar": addressAr,
      "isLikedCinema": isLikedCinema,
    };
  }

  CinemaLocationDto copyWith(
      {String? name,
        String? nameAr,
        dynamic lat,
        dynamic long,
        int? id,
        String? vistaId,
        String? address,
        dynamic addressAr,
        bool? isLikedCinema}) {
    return CinemaLocationDto(
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

  static CinemaLocationModel toDomainModel(CinemaLocationDto cinemaDto) {
    return CinemaLocationModel(
        name: cinemaDto.name,
        nameAr: cinemaDto.nameAr,
        lat: cinemaDto.lat,
        long: cinemaDto.long,
        id: cinemaDto.id,
        vistaId: cinemaDto.vistaId,
        address: cinemaDto.address,
        addressAr: cinemaDto.addressAr,
        isLikedCinema: cinemaDto.isLikedCinema,
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
