
import 'package:equatable/equatable.dart';
import 'package:novocinema/entities/models/GenreModel.dart';

class LocationModel extends Equatable {
  final int ? id;
  final String? name;
  final bool? isActive ;

  const LocationModel({
    this.id = 0,
    this.name = '',
    this.isActive = false
  });



  LocationModel copyWith({
    String? name,
    int? id,
    bool? isActive
  }) {
    return LocationModel(
        id: id ?? this.id,
        name: name ?? this.name,
        isActive:  isActive ?? this.isActive
    );
  }



  @override
  List<Object?> get props => [id, name,isActive];


  @override
  String toString() {
    return 'LocationModel(id: $id, name: $name , isActive: $isActive)';
  }
}