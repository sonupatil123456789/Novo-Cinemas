
import 'package:equatable/equatable.dart';

import '../../domain/models/MovieLanguageModel.dart';

class MovieLanguageDto extends Equatable {
  final int? langId ;
  final String? langName ;
  final String? langNameAr ;

  const MovieLanguageDto({
     this.langId = 0,
     this.langName = '',
     this.langNameAr = '',
  });

  // FromJson constructor
  factory MovieLanguageDto.fromJson(Map<String, dynamic> json) {
    return MovieLanguageDto(
      langId: json['lang_id'] ?? 0,
      langName: json['lang_name'] ?? '',
      langNameAr: json['lang_name_ar'] ?? '',
    );
  }

  // ToJson method
  Map<String, dynamic> toJson() {
    return {
      'lang_id': langId,
      'lang_name': langName,
      'lang_name_ar': langNameAr,
    };
  }

  // CopyWith method
  MovieLanguageDto copyWith({
    int? langId,
    String? langName,
    String? langNameAr,
  }) {
    return MovieLanguageDto(
      langId: langId ?? this.langId,
      langName: langName ?? this.langName,
      langNameAr: langNameAr ?? this.langNameAr,
    );
  }

  static MovieLanguageModel toDomainModel(MovieLanguageDto movieLanguageDto){
    return MovieLanguageModel(langId: movieLanguageDto.langId,
      langName: movieLanguageDto.langName,
      langNameAr: movieLanguageDto.langNameAr
    );
  }

  // ToString method
  @override
  String toString() {
    return 'MovieLanguageDto(langId: $langId, langName: $langName, langNameAr: $langNameAr)';
  }

  // Equatable props
  @override
  List<Object?> get props => [langId, langName, langNameAr];
}