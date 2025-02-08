
import 'package:equatable/equatable.dart';
import 'package:novocinema/entities/models/GenreModel.dart';

import '../models/LocationModel.dart';

class LocationDto extends Equatable {
  final int ? id;
  final String? name;
  final bool? isActive ;

  const LocationDto({
    this.id = 0,
    this.name = '',
    this.isActive = false
  });

  factory LocationDto.fromJson(Map<String, dynamic> json) {
    return LocationDto(
      id: json['id'] ?? '',
      name: json['name'] ?? 0,
      isActive: json['is_active'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'is_active':isActive
    };
  }

  LocationDto copyWith({
    String? name,
    int? id,
    bool? isActive
  }) {
    return LocationDto(
        id: id ?? this.id,
        name: name ?? this.name,
        isActive:  isActive ?? this.isActive
    );
  }

  static LocationModel toDomainModel(LocationDto locationDto) {
    return LocationModel(
        id: locationDto.id,
        name: locationDto.name ,
        isActive : locationDto.isActive
    );
  }

  @override
  List<Object?> get props => [id, name,isActive];


  @override
  String toString() {
    return 'LocationDto(id: $id, name: $name , isActive: $isActive)';
  }
}