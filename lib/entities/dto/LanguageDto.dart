

import 'package:equatable/equatable.dart';

import '../models/LanguageModel.dart';

class LanguageDto extends Equatable{

  final int ? id;
  final String? name;
  final bool? isActive ;

  const LanguageDto({
    this.id = 0,
    this.name = '',
    this.isActive = false
  });

  factory LanguageDto.fromJson(Map<String, dynamic> json) {
    return LanguageDto(
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

  LanguageDto copyWith({
    String? name,
    int? id,
    bool? isActive
  }) {
    return LanguageDto(
        id: id ?? this.id,
        name: name ?? this.name,
        isActive:  isActive ?? this.isActive
    );
  }

  static LanguageModel toDomainModel(LanguageDto languageDto) {
    return LanguageModel(
        id: languageDto.id,
        name: languageDto.name ,
        isActive : languageDto.isActive
    );
  }

  @override
  List<Object?> get props => [id, name,isActive];


  @override
  String toString() {
    return 'LanguageDto(id: $id, name: $name , isActive: $isActive)';
  }



}