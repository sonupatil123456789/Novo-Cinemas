

import 'package:equatable/equatable.dart';

class MovieCastModel extends Equatable{


  final String? firstName ;
  final String? lastName ;
  final String? picture ;

  const MovieCastModel({
    this.firstName = '',
    this.lastName = '',
    this.picture = '',
  });


  // CopyWith method
  MovieCastModel copyWith({
    String? firstName,
    String? lastName,
    String? picture,
  }) {
    return MovieCastModel(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        picture: picture ?? this.picture
    );
  }


  // ToString method
  @override
  String toString() {
    return 'MovieCastModel(firstName: $firstName, lastName: $lastName, picture: $picture)';
  }

  // Equatable props
  @override
  List<Object?> get props => [firstName, lastName, picture];



}