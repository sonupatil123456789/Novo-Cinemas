
import 'package:equatable/equatable.dart';
import 'package:novocinema/entities/models/GenreModel.dart';

import '../models/LocationModel.dart';

class ExperienceModel extends Equatable {
  final int ? id;
  final String? name;
  final bool? isActive ;

  const ExperienceModel({
    this.id = 0,
    this.name = '',
    this.isActive = false
  });



  ExperienceModel copyWith({
    String? name,
    int? id,
    bool? isActive
  }) {
    return ExperienceModel(
        id: id ?? this.id,
        name: name ?? this.name,
        isActive:  isActive ?? this.isActive
    );
  }



  @override
  List<Object?> get props => [id, name,isActive];


  @override
  String toString() {
    return 'ExperienceModel(id: $id, name: $name , isActive: $isActive)';
  }
}