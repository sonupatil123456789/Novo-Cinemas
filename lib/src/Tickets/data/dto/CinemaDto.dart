import 'package:equatable/equatable.dart';

import '../../domain/models/CinemaModel.dart';

class CinemaDto extends Equatable {
  final String? name;
  final String? nameAr;

  const CinemaDto({
    this.name = '',
    this.nameAr = '',
  });

  factory CinemaDto.fromJson(Map<String, dynamic> json) {
    return CinemaDto(
      name: json['name'],
      nameAr: json['name_ar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'name_ar': nameAr,
    };
  }

  CinemaDto copyWith({
    String? name,
    String? nameAr,
  }) {
    return CinemaDto(
      name: name ?? this.name,
      nameAr: nameAr ?? this.nameAr,
    );
  }

  static CinemaModel toDomainModel(CinemaDto cinemaDto) {
    return CinemaModel(
      name: cinemaDto.name ?? '',
      nameAr: cinemaDto.nameAr ?? '',
    );
  }

  @override
  List<Object?> get props => [name, nameAr];

  @override
  String toString() {
    return 'CinemaDto(name: $name, nameAr: $nameAr)';
  }
}