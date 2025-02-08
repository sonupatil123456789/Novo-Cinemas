import 'package:equatable/equatable.dart';

class GenreModel extends Equatable {


  final int ? id;
  final String? name;
  final bool? isActive ;

  const GenreModel({
    this.id,
    this.name,
    this.isActive
  });



  GenreModel copyWith({
    String? name,
    int? id,
    bool? isActive,
  }) {
    return GenreModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive?? this.isActive
    );
  }


  @override
  List<Object?> get props => [id, name,isActive];

  @override
  String toString() {
    return 'GenreModel(id: $id, name: $name, isActive: $isActive)';
  }






}