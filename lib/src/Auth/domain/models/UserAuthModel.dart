import 'package:equatable/equatable.dart';

import 'LoyaltyInfoModel.dart';


class UserAuthModel extends Equatable {
  final String? userEmail;
  final String? userFirstName;
  final String? userLastName;
  final String? userContact;
  final int? userId;
  final String? userName;
  final String? loyaltyPassword;
  final LoyaltyInfoModel? loyltyInfo;

  const UserAuthModel({
    this.userEmail,
    this.userFirstName,
    this.userLastName,
    this.userContact,
    this.userId,
    this.userName,
    this.loyaltyPassword,
    this.loyltyInfo,
  });



  UserAuthModel copyWith({
    String? userEmail,
    String? userFirstName,
    String? userLastName,
    String? userContact,
    int? userId,
    String? userName,
    String? loyaltyPassword,
    LoyaltyInfoModel? loyltyInfo,
  }) {
    return UserAuthModel(
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



  @override
  String toString() {
    return 'UserAuthModel(userEmail: $userEmail, userFirstName: $userFirstName, userLastName: $userLastName, userContact: $userContact, userId: $userId, userName: $userName, loyaltyPassword: $loyaltyPassword, loyltyInfo: $loyltyInfo)';
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

// class UserAuthModel extends Equatable {
//
//   final String? token;
//   final int? userId;
//   final String? userEmail;
//   final String? userContact;
//
//   const UserAuthModel({
//     this.token = '',
//     this.userId = 0,
//     this.userEmail = '',
//     this.userContact = '',
//   });
//
//
//   // copy with method
//   UserAuthModel copyWith({
//     String? token,
//     int? userId,
//     String? userEmail,
//     String? userContact,
//   }) {
//     return UserAuthModel(
//       token: token ?? this.token,
//       userId: userId ?? this.userId,
//       userEmail: userEmail ?? this.userEmail,
//       userContact: userContact ?? this.userContact,
//     );
//   }
//
//   @override
//   List<Object?> get props => [token, userId, userEmail, userContact];
//
//   @override
//   String toString() {
//     return 'UserAuthModel(token: $token, userId: $userId, userEmail: $userEmail, userContact: $userContact,)';
//   }
//
// }