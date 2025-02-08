

import 'package:equatable/equatable.dart';
import '../../domain/models/MovieCastModel.dart';

class MovieCastDto extends Equatable{


  final String? firstName ;
  final String? lastName ;
  final String? picture ;

  const MovieCastDto({
    this.firstName = '',
    this.lastName = '',
    this.picture = '',
  });

  // FromJson constructor
  factory MovieCastDto.fromJson(Map<String, dynamic> json) {
    return MovieCastDto(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      picture: json['url_to_picture'] ?? '',
    );
  }

  // ToJson method
  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'url_to_picture': picture,
    };
  }

  // CopyWith method
  MovieCastDto copyWith({
    String? firstName,
    String? lastName,
    String? picture,
  }) {
    return MovieCastDto(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      picture: picture ?? this.picture
    );
  }

  static MovieCastModel toDomainModel(MovieCastDto castDto){
    return MovieCastModel(
      picture: castDto.picture,
      lastName:  castDto.lastName,
      firstName: castDto.firstName
    );
  }

  // ToString method
  @override
  String toString() {
    return 'MovieCastDto(firstName: $firstName, lastName: $lastName, picture: $picture)';
  }

  // Equatable props
  @override
  List<Object?> get props => [firstName, lastName, picture];



}