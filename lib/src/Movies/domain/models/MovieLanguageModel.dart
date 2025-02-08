
import 'package:equatable/equatable.dart';

class MovieLanguageModel extends Equatable {
  final int? langId ;
  final String? langName ;
  final String? langNameAr ;

  const MovieLanguageModel({
    this.langId = 0,
    this.langName = '',
    this.langNameAr = '',
  });

  // CopyWith method
  MovieLanguageModel copyWith({
    int? langId,
    String? langName,
    String? langNameAr,
  }) {
    return MovieLanguageModel(
      langId: langId ?? this.langId,
      langName: langName ?? this.langName,
      langNameAr: langNameAr ?? this.langNameAr,
    );
  }

  // ToString method
  @override
  String toString() {
    return 'MovieLanguageModel(langId: $langId, langName: $langName, langNameAr: $langNameAr)';
  }

  // Equatable props
  @override
  List<Object?> get props => [langId, langName, langNameAr];
}