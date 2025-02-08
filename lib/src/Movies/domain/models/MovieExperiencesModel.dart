


import 'package:equatable/equatable.dart';


class MovieExperiencesModel extends Equatable{


  final int? experienceId ;
  final String? experienceName ;
  final String? experienceNameAr ;

  const MovieExperiencesModel({
    this.experienceId = 0,
    this.experienceName = '',
    this.experienceNameAr = '',
  });


  // CopyWith method
  MovieExperiencesModel copyWith({
    int? experienceId,
    String? experienceName,
    String? experienceNameAr,
  }) {
    return MovieExperiencesModel(
        experienceId: experienceId ?? this.experienceId,
        experienceName: experienceName ?? this.experienceName,
        experienceNameAr: experienceNameAr ?? this.experienceNameAr
    );
  }

  // ToString method
  @override
  String toString() {
    return 'MovieExperiencesModel(experienceId: $experienceId, experienceName: $experienceName, experienceNameAr: $experienceNameAr)';
  }

  // Equatable props
  @override
  List<Object?> get props => [experienceId, experienceName, experienceNameAr];



}