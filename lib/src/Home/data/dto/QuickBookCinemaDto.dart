
import 'package:equatable/equatable.dart';
import 'package:novocinema/src/Home/domain/models/QuickBookCinemaModel.dart';

class QuickBookCinemaDto extends Equatable {
  final int? id;
  final String? name;
  final String? slug;

  const QuickBookCinemaDto({
     this.id = 0,
     this.name = '',
     this.slug = '',
  });

  factory QuickBookCinemaDto.fromJson(Map<String, dynamic> json) => QuickBookCinemaDto(
    id: json['id'] ?? 0,
    name: json['name'] ?? '',
    slug: json['slug'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'slug': slug,
  };

  QuickBookCinemaDto copyWith({
    int? id,
    String? name,
    String? slug,
  }) =>
      QuickBookCinemaDto(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
      );

  static QuickBookCinemaModel toDomainModel(QuickBookCinemaDto quickBookCinemaDto){
    return QuickBookCinemaModel(
      id: quickBookCinemaDto.id,
      name: quickBookCinemaDto.name,
      slug: quickBookCinemaDto.slug
    );
  }

  @override
  List<Object?> get props => [id, name, slug];

  @override
  String toString() => 'QuickBookCinemaDto(id: $id, name: $name, slug: $slug)';
}
