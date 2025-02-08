
import 'package:equatable/equatable.dart';

class QuickBookCinemaModel extends Equatable {
  final int? id;
  final String? name;
  final String? slug;

  const QuickBookCinemaModel({
     this.id = 0,
     this.name = '',
     this.slug = '',
  });

  QuickBookCinemaModel copyWith({
    int? id,
    String? name,
    String? slug,
  }) =>
      QuickBookCinemaModel(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
      );

  @override
  List<Object?> get props => [id, name, slug];

  @override
  String toString() => 'QuickBookCinemaModel(id: $id, name: $name, slug: $slug)';
}
