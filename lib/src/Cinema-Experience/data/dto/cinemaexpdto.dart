import 'package:equatable/equatable.dart';
import 'package:novocinema/src/Cinema-Experience/domain/models/cinemaexperience.dart';

class CinemaExperienceDto extends Equatable {
  final int fkExperienceId;
  final int experienceId;
  final String experienceName;
  final String experienceNameAr;
  final String experienceImageUrl;

  const CinemaExperienceDto({
    required this.fkExperienceId,
    required this.experienceId,
    required this.experienceName,
    required this.experienceNameAr,
    required this.experienceImageUrl,
  });

  factory CinemaExperienceDto.fromJson(Map<String, dynamic> json) {
    return CinemaExperienceDto(
      fkExperienceId: json['fk_experience_id'] as int? ?? 0,
      experienceId: json['experience']['experience_id'] as int? ?? 0,
      experienceName: json['experience']['experience_name'] as String? ?? '',
      experienceNameAr: json['experience']['experience_name_ar'] as String? ?? '',
        experienceImageUrl: json['experience']['experience_image_url'] as String ?? ''
    );
  }

  Map<String, dynamic> toJson() => {
        'fk_experience_id': fkExperienceId,
        'experience': {
          'experience_id': experienceId,
          'experience_name': experienceName,
          'experience_name_ar': experienceNameAr,
          'experience_image_url': experienceImageUrl
        },
      };

  CinemaExperienceDto copyWith({
    int? fkExperienceId,
    int? experienceId,
    String? experienceName,
    String? experienceNameAr,
    String? experienceImageUrl,
  }) {
    return CinemaExperienceDto(
      fkExperienceId: fkExperienceId ?? this.fkExperienceId,
      experienceId: experienceId ?? this.experienceId,
      experienceName: experienceName ?? this.experienceName,
      experienceNameAr: experienceNameAr ?? this.experienceNameAr,
      experienceImageUrl: experienceImageUrl ?? this.experienceImageUrl
    );
  }

  static CinemaExperienceModel toDomainModel(CinemaExperienceDto dto) {
    return CinemaExperienceModel(
      fkExperienceId: dto.fkExperienceId,
      experienceId: dto.experienceId,
      experienceName: dto.experienceName,
      experienceNameAr: dto.experienceNameAr,
      experienceImageUrl: dto.experienceImageUrl,
    );
  }

  @override
  List<Object?> get props =>
      [fkExperienceId, experienceId, experienceName, experienceNameAr, experienceImageUrl];

  @override
  String toString() {
    return 'CinemaExperienceDto(fkExperienceId: $fkExperienceId, experienceId: $experienceId, experienceName: $experienceName, experienceNameAr: $experienceNameAr)';
  }
}
