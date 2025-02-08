


import 'package:equatable/equatable.dart';
import '../../domain/models/MovieExperiencesModel.dart';

class MovieExperiencesDto extends Equatable{


  final int? experienceId ;
  final String? experienceName ;
  final String? experienceNameAr ;

  const MovieExperiencesDto({
    this.experienceId = 0,
    this.experienceName = '',
    this.experienceNameAr = '',
  });

  // FromJson constructor
  factory MovieExperiencesDto.fromJson(Map<String, dynamic> json) {
    return MovieExperiencesDto(
    experienceId: json['experience_id'] ?? 0,
      experienceName: json['experience_name'] ?? '',
      experienceNameAr: json['experience_name_ar'] ?? '',
    );
  }

  // ToJson method
  Map<String, dynamic> toJson() {
    return {
      'experience_id': experienceId,
      'experience_name': experienceName,
      'experience_name_ar': experienceNameAr,
    };
  }

  // CopyWith method
  MovieExperiencesDto copyWith({
    int? experienceId,
    String? experienceName,
    String? experienceNameAr,
  }) {
    return MovieExperiencesDto(
        experienceId: experienceId ?? this.experienceId,
        experienceName: experienceName ?? this.experienceName,
        experienceNameAr: experienceNameAr ?? this.experienceNameAr
    );
  }

  static MovieExperiencesModel toDomainModel(MovieExperiencesDto experienceDto){
    return MovieExperiencesModel(
      experienceNameAr: experienceDto.experienceNameAr,
        experienceName:  experienceDto.experienceName,
         experienceId: experienceDto.experienceId
    );
  }

  // ToString method
  @override
  String toString() {
    return 'MovieExperiencesDto(experienceId: $experienceId, experienceName: $experienceName, experienceNameAr: $experienceNameAr)';
  }

  // Equatable props
  @override
  List<Object?> get props => [experienceId, experienceName, experienceNameAr];



}