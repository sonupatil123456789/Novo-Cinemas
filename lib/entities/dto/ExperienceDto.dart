
import 'package:equatable/equatable.dart';
import 'package:novocinema/entities/models/GenreModel.dart';

import '../models/ExperienceModel.dart';
import '../models/LocationModel.dart';

class ExperienceDto extends Equatable {
  final int ? id;
  final String? name;
  final bool? isActive ;

  const ExperienceDto({
    this.id = 0,
    this.name = '',
    this.isActive = false
  });

  factory ExperienceDto.fromJson(Map<String, dynamic> json) {
    return ExperienceDto(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      isActive: json['is_active'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'is_active':isActive
    };
  }

  ExperienceDto copyWith({
    String? name,
    int? id,
    bool? isActive
  }) {
    return ExperienceDto(
        id: id ?? this.id,
        name: name ?? this.name,
        isActive:  isActive ?? this.isActive
    );
  }

  static ExperienceModel toDomainModel(ExperienceDto experienceDto) {
    return ExperienceModel(
        id: experienceDto.id,
        name: experienceDto.name ,
        isActive : experienceDto.isActive
    );
  }

  @override
  List<Object?> get props => [id, name,isActive];


  @override
  String toString() {
    return 'ExperienceDto(id: $id, name: $name , isActive: $isActive)';
  }
}