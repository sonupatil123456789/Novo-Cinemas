import 'package:equatable/equatable.dart';

class CinemaExperienceModel extends Equatable {
  final int fkExperienceId;
  final int experienceId;
  final String experienceName;
  final String experienceNameAr;
  final String experienceImageUrl;

  const CinemaExperienceModel({
    required this.fkExperienceId,
    required this.experienceId,
    required this.experienceName,
    required this.experienceNameAr,
    required this.experienceImageUrl
  });

  @override
  List<Object?> get props =>
      [fkExperienceId, experienceId, experienceName, experienceNameAr, experienceImageUrl];

  @override
  String toString() {
    return 'CinemaExperienceModel(fkExperienceId: $fkExperienceId, experienceId: $experienceId, experienceName: $experienceName, experienceNameAr: $experienceNameAr)';
  }
}
