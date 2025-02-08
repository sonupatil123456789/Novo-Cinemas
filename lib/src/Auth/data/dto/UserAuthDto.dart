

import 'package:equatable/equatable.dart';
import 'package:novocinema/src/Auth/domain/models/UserAuthModel.dart';

import 'LoyaltyInfoDto.dart';


class UserAuthDto extends Equatable {
  final String? userEmail;
  final String? userFirstName;
  final String? userLastName;
  final String? userContact;
  final int? userId;
  final String? userName;
  final String? loyaltyPassword;
  final LoyaltyInfoDto? loyltyInfo;

  const UserAuthDto({
    this.userEmail,
    this.userFirstName,
    this.userLastName,
    this.userContact,
    this.userId,
    this.userName,
    this.loyaltyPassword,
    this.loyltyInfo,
  });

  factory UserAuthDto.fromJson(Map<String, dynamic> json) => UserAuthDto(
    userEmail: json['user_email'] as String? ?? '',
    userFirstName: json['user_first_name'] as String? ?? '',
    userLastName: json['user_last_name'] as String? ?? '',
    userContact: json['user_contact'] as String? ?? '',
    userId: json['user_id'] as int? ?? 0,
    userName: json['user_name'] as String? ?? '',
    loyaltyPassword: json['loyalty_password'] as String? ?? '',
    loyltyInfo: json['loylty_info'] != null
        ? LoyaltyInfoDto.fromJson(json['loylty_info'] as Map<String, dynamic>)
        : LoyaltyInfoDto.fromJson(const <String, dynamic>{}),
  );

  Map<String, dynamic> toJson() => {
    'user_email': userEmail,
    'user_first_name': userFirstName,
    'user_last_name': userLastName,
    'user_contact': userContact,
    'user_id': userId,
    'user_name': userName,
    'loyalty_password': loyaltyPassword,
    'loylty_info': loyltyInfo?.toJson(),
  };

  UserAuthDto copyWith({
    String? userEmail,
    String? userFirstName,
    String? userLastName,
    String? userContact,
    int? userId,
    String? userName,
    String? loyaltyPassword,
    LoyaltyInfoDto? loyltyInfo,
  }) {
    return UserAuthDto(
      userEmail: userEmail ?? this.userEmail,
      userFirstName: userFirstName ?? this.userFirstName,
      userLastName: userLastName ?? this.userLastName,
      userContact: userContact ?? this.userContact,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      loyaltyPassword: loyaltyPassword ?? this.loyaltyPassword,
      loyltyInfo: loyltyInfo ?? this.loyltyInfo,
    );
  }


    static UserAuthModel toDomainModel(UserAuthDto userAuthDto){
    return UserAuthModel(
      userId: userAuthDto.userId,
      userEmail: userAuthDto.userEmail,
      userContact: userAuthDto.userContact,
      loyaltyPassword: userAuthDto.loyaltyPassword,
      loyltyInfo: LoyaltyInfoDto.toDomainModel(userAuthDto.loyltyInfo!),
      userFirstName: userAuthDto.userFirstName,
      userLastName: userAuthDto.userLastName,
      userName: userAuthDto.userName
    );
  }


  @override
  String toString() {
    return 'UserAuthDto(userEmail: $userEmail, userFirstName: $userFirstName, userLastName: $userLastName, userContact: $userContact, userId: $userId, userName: $userName, loyaltyPassword: $loyaltyPassword, loyltyInfo: $loyltyInfo)';
  }

  @override
  List<Object?> get props => [
    userEmail,
    userFirstName,
    userLastName,
    userContact,
    userId,
    userName,
    loyaltyPassword,
    loyltyInfo,
  ];
}
//
// class UserAuthDto extends  Equatable{
//
//   final String? token;
//   final int? userId;
//   final String? userEmail;
//   final String? userContact;
//
//   const UserAuthDto({
//      this.token = '',
//      this.userId = 0,
//      this.userEmail = '',
//      this.userContact = '',
//   });
//
//   // fromJson constructor
//   factory UserAuthDto.fromJson(Map<String, dynamic> json) {
//     return UserAuthDto(
//       token: json['token'] ?? '',
//       userId: json['user_id'] ?? 0,
//       userEmail: json['user_email'] ?? '',
//       userContact: json['user_contact'] ?? '',
//     );
//   }
//
//   // toJson method
//   Map<String, dynamic> toJson() {
//     return {
//       'token': token,
//       'user_id': userId,
//       'user_email': userEmail,
//       'user_contact': userContact,
//     };
//   }
//
//   // copy with method
//   UserAuthDto copyWith({
//     String? token,
//     int? userId,
//     String? userEmail,
//     String? userContact,
//   }) {
//     return UserAuthDto(
//       token: token ?? this.token,
//       userId: userId ?? this.userId,
//       userEmail: userEmail ?? this.userEmail,
//       userContact: userContact ?? this.userContact,
//     );
//   }
//
//   static UserAuthModel toDomainModel(UserAuthDto userAuthDto){
//     return UserAuthModel(
//       token: userAuthDto.token,
//       userId: userAuthDto.userId,
//       userEmail: userAuthDto.userEmail,
//       userContact: userAuthDto.userContact,
//     );
//   }
//
//   @override
//   List<Object?> get props => [token, userId, userEmail, userContact];
//
//   @override
//   String toString() {
//     return 'UserAuthDataDto(token: $token, userId: $userId, userEmail: $userEmail, userContact: $userContact,)';
//   }
//
// }