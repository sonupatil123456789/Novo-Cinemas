
import 'package:equatable/equatable.dart';

class SearchCinemaModel extends Equatable {
  final int? id;
  final String? name;
  final String? nameAr;
  final String? type;

  const SearchCinemaModel({
     this.id = 0,
     this.name = '',
     this.nameAr = '',
     this.type = '',
  });

  SearchCinemaModel copyWith({
    int? id,
    String? name,
    String? nameAr,
    String? type,
  }) {
    return SearchCinemaModel(
      id: id ?? this.id,
      name: name ?? this.name,
      nameAr: nameAr ?? this.nameAr,
      type: type ?? this.type,
    );
  }




  @override
  List<Object?> get props => [id, name, nameAr, type];

  @override
  String toString() {
    return 'SearchCinemaModel(id: $id, name: $name, nameAr: $nameAr, type: $type)';
  }
}