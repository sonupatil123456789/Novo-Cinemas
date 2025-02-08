
import 'package:equatable/equatable.dart';
import 'package:novocinema/entities/models/GenreModel.dart';

class GenreDto extends Equatable {
  final int ? id;
  final String? name;
  final bool? isActive ;

  const GenreDto({
    this.id = 0,
    this.name = '',
    this.isActive = false
  });

  factory GenreDto.fromJson(Map<String, dynamic> json) {
    return GenreDto(
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

  GenreDto copyWith({
    String? name,
    int? id,
    bool? isActive
  }) {
    return GenreDto(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive:  isActive ?? this.isActive
    );
  }

  static GenreModel toDomainModel(GenreDto genreDto) {
    return GenreModel(
      id: genreDto.id,
        name: genreDto.name ,
        isActive : genreDto.isActive
    );
  }

  @override
  List<Object?> get props => [id, name,isActive];


  @override
  String toString() {
    return 'GenreDto(id: $id, name: $name , isActive: $isActive)';
  }
}