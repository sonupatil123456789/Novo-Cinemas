
import 'package:equatable/equatable.dart';

import '../../domain/models/SearchCinemaModel.dart';

class SearchCinemaDto extends Equatable {
  final int? id;
  final String? name;
  final String? nameAr;
  final String? type;

  const SearchCinemaDto({
     this.id = 0,
     this.name = '',
     this.nameAr = '',
     this.type = '',
  });

  factory SearchCinemaDto.fromJson(Map<String, dynamic> json) {
    return SearchCinemaDto(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      nameAr: json['name_ar'] ?? '',
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_ar': nameAr,
      'type': type,
    };
  }

  SearchCinemaDto copyWith({
    int? id,
    String? name,
    String? nameAr,
    String? type,
  }) {
    return SearchCinemaDto(
      id: id ?? this.id,
      name: name ?? this.name,
      nameAr: nameAr ?? this.nameAr,
      type: type ?? this.type,
    );
  }

  static SearchCinemaModel toDomainModel(SearchCinemaDto searchCinemaDto){
    return SearchCinemaModel(
        name: searchCinemaDto.name,
        id: searchCinemaDto.id,
        nameAr: searchCinemaDto.nameAr,
        type: searchCinemaDto.type,
    );
  }

  @override
  List<Object?> get props => [id, name, nameAr, type];

  @override
  String toString() {
    return 'SearchCinemaDto(id: $id, name: $name, nameAr: $nameAr, type: $type)';
  }
}