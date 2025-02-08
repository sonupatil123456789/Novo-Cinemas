
import 'package:novocinema/core/resources/AppException.dart';
import 'package:novocinema/core/resources/DataResult.dart';
import 'package:novocinema/core/resources/enums.dart';
import 'package:novocinema/core/utils/Logger.dart';
import 'package:novocinema/src/Auth/data/dto/UserAuthDto.dart';
import 'package:novocinema/src/Auth/data/local/LocalDatasource.dart';
import 'package:novocinema/src/Auth/data/remote/RemoteDatasource.dart';
import 'package:novocinema/src/Auth/domain/models/UserAuthModel.dart';

import '../../../../core/constants/DatabaseKeyConstants.dart';
import '../../../../core/resources/SeassionManager.dart';
import '../../domain/Repository/Repository.dart';
import '../../presentation/screens/OtpVerificationScreen.dart';

class AuthRepositoryImpl implements AuthRepository {
  late final AuthRemoteDatasource remoteDatasource;
  late final AuthLocalDatasource localDatasource;
  late final SeassionManager session ;
  AuthRepositoryImpl(this.remoteDatasource, this.localDatasource, this.session);

  @override
  Future<DataResult<bool>> logIn(String email, String password) async {
    try {
      final userData = await remoteDatasource.logIn(email, password);

      if(userData.success == true){
        final isUserSaved = await session.setAccessToken(TOKEN, userData.data['token']);
        if (isUserSaved == true) {
          return DataResult.success(true);
        }
      }
      throw AppException(message: 'An unexpected error occurred. During Login account. please try after some time.', errorCode: ErrorCode.UNKNOWN_ERROR);
    } on AppException catch (error,stack) {
      Logger.customLogError("logIn", error, stack);
      return DataResult.error(error, false);
    }
  }


  @override
  Future<DataResult<Map<String,dynamic>>> googleLogIn() async {
    try {
      final userData = await remoteDatasource.googleLogIn();

      if(userData != null && userData.success == true){

        if(userData.data['new_user'] == false){
          final isUserSaved = await session.setAccessToken(TOKEN, userData.data['token']);
          if (isUserSaved == true) {
            return DataResult.success(userData.data);
          }
        }
        return DataResult.success(userData.data);

      }
      return DataResult.error(AppException(message: 'Google login Cancelled', errorCode: ErrorCode.CANCEL), null);
    } on AppException catch (error, stack) {
      Logger.customLogError("googleLogIn", error, stack);
      return DataResult.error(error, null);
    }
  }

  @override
  Future<DataResult<bool>> signeUp(Map<String,dynamic> customer) async {
    try {
      final userData = await remoteDatasource.signeUp(customer);
      if (userData.success == true) {
        return DataResult.success(true);
        // final isUserSaved = await session.setAccessToken(TOKEN, userData.data['token']);
        // if (isUserSaved == true) {
        //   return DataResult.success(true);
        // }
      }
      throw AppException(message: 'An unexpected error occurred. During account creation. please try after some time.', errorCode: ErrorCode.UNKNOWN_ERROR);
    } on AppException catch (error, stack) {
      Logger.customLogError("signeUp", error, stack);
      return DataResult.error(error, false);
    }
  }

  @override
  Future<DataResult<Map<String,dynamic>>> googleSigneUp(Map<String, dynamic> data) async{
    try {
      final userData = await remoteDatasource.googleSigneUp(data);

      if(userData.success == true){
        final isUserSaved = await session.setAccessToken(TOKEN, userData.data['token']);
        if (isUserSaved == true) {
          return DataResult.success(userData.data);
        }
      }
      throw AppException(message: 'An unexpected error occurred. During google signe up. please try after some time.', errorCode: ErrorCode.UNKNOWN_ERROR);
    } on AppException catch (error,stack) {
      Logger.customLogError("googleSigneUp", error, stack);
      return DataResult.error(error, null);
    }
  }



  @override
  Future<DataResult<bool>> logInWithApple() async {
    try {
      final data = await remoteDatasource.logInWithApple();
      Logger.customLogData("logInWithApple",data.toString());
      return DataResult.success(true);
    } on AppException catch (error, stack) {
      Logger.customLogError("logInWithApple", error, stack);
      return DataResult.error(error, null);
    }
  }



  @override
  Future<DataResult<String?>> authenticateUser() async {
    try {
      final token = await session.getAccessToken(TOKEN);
      final guestToken = await session.getAccessToken(GUEST_TOKEN);

      if(token != null &&  token.isNotEmpty == true || guestToken != null &&  guestToken.isNotEmpty == true){
         return DataResult.success(token);
      }
      return DataResult.error(AppException(message: 'Unauthorized access', errorCode: ErrorCode.UNAUTORISED_ERROR), null);
    } on AppException catch (error,stack) {
      Logger.customLogError("authenticateUser", error, stack);
      return DataResult.error(error, null);
    }
  }

  @override
  Future<DataResult<UserAuthModel>> getUserDetails()async {
    try {
      final userData = await remoteDatasource.getUserDetails();
      if(userData.success == true ){

       final localUser = await localDatasource.setUserData(userData.data);
       if(localUser == true){
         return DataResult.success(UserAuthDto.toDomainModel(userData.data));
       }
       throw AppException(message: 'Error occured during getting user details', errorCode: ErrorCode.UNAUTORISED_ERROR);
      }
      throw AppException(message: 'Unauthorized access', errorCode: ErrorCode.UNAUTORISED_ERROR);
    } on AppException catch (error, stack) {
      Logger.customLogError("getUserDetails", error, stack);
      return DataResult.error(error, null);
    }


  }

  @override
  Future<DataResult<bool>> logOut() async {
    try {
      final token = await session.removeAccessToken(TOKEN);
      final isUserDeleted = await localDatasource.removeUserData();

      if(isUserDeleted == true &&  isUserDeleted == true){
        return DataResult.success(token);
      }
      return DataResult.error(AppException(message: 'Logout failed', errorCode: ErrorCode.UNAUTORISED_ERROR), false);
    } on AppException catch (error,stack) {
      Logger.customLogError("logOut", error, stack);
      return DataResult.error(error, false);
    }
  }

  @override
  Future<DataResult<bool>> forgotPassword(String emailId) async {
    try {
      final data = await remoteDatasource.forgotPassword(emailId);
      if(data.success == true){
        return DataResult.success(true);
      }
      throw AppException(message: 'Unable to send otp. please try after some time.', errorCode: ErrorCode.UNKNOWN_ERROR);
    } on AppException catch (error,stack) {
      Logger.customLogError("forgotPassword", error, stack);
      return DataResult.error(error, false);
    }
  }

  @override
  Future<DataResult<bool>> resetPassword(Map<String, dynamic> data) async {
    try {
      final updatePasswordData = await remoteDatasource.resetPassword(data);
      if(updatePasswordData.success == true){
        return DataResult.success(true);
      }
      throw AppException(message: 'Unable to reset password. please try after some time.', errorCode: ErrorCode.UNKNOWN_ERROR);
    } on AppException catch (error,stack) {
      Logger.customLogError("resetPassword", error, stack);
      return DataResult.error(error, false);
    }
  }

  @override
  Future<DataResult<String>> verifyOtp(Map<String, dynamic> data, OtpVerificationType otpVerificationType) async {
    try {
      final verifyData = await remoteDatasource.verifyOtp(data,otpVerificationType);

      if(verifyData.success == true){

        switch(otpVerificationType) {
          case OtpVerificationType.SIGN_UP:
            final isUserSaved = await session.setAccessToken(TOKEN, verifyData.data['token']);
            if (isUserSaved == true) {
              return DataResult.success(verifyData.data['token']);
            }
          break ;
          case OtpVerificationType.FORGOT_PASSWORD:
            return DataResult.success(verifyData.data['token']);
        }
      }
      throw AppException(message: 'Otp Verification failed', errorCode: ErrorCode.UNKNOWN_ERROR);
    } on AppException catch (error,stack) {
      Logger.customLogError("verifyOtp", error, stack);
      return DataResult.error(error, null);
    }
  }

  @override
  Future<DataResult<List<Map<String,dynamic>>>> getAllNationality() async{
    try {
      final nationalityData = await remoteDatasource.getAllNationality();

      if(nationalityData.success == true){
        return DataResult.success(nationalityData.data);
      }
      throw AppException(message: nationalityData.message, errorCode: ErrorCode.UNKNOWN_ERROR);
    } on AppException catch (error,stack) {
      Logger.customLogError("getAllNationality", error, stack);
      return DataResult.error(error, null);
    }
  }

  @override
  Future<DataResult<Map<String, dynamic>>> facebookLogIn() async {
    try {
      final userData = await remoteDatasource.facebookLogIn();

      if(userData != null && userData.success == true){
        if(userData.data['new_user'] == false){
          final isUserSaved = await session.setAccessToken(TOKEN, userData.data['token']);
          if (isUserSaved == true) {
            return DataResult.success(userData.data);
          }
        }
        return DataResult.success(userData.data);
      }
      return DataResult.error(AppException(message: 'Facebook login Cancelled', errorCode: ErrorCode.CANCEL), null);
    } on AppException catch (error, stack) {
      Logger.customLogError("facebookLogIn", error, stack);
      return DataResult.error(error, null);
    }

  }

  @override
  Future<DataResult<Map<String, dynamic>>> facebookSigneUp(Map<String, dynamic> data) async {
    try {
      final userData = await remoteDatasource.facebookSigneUp(data);

      if(userData.success == true){
        final isUserSaved = await session.setAccessToken(TOKEN, userData.data['token']);
        if (isUserSaved == true) {
          return DataResult.success(userData.data);
        }
      }
      throw AppException(message: 'An unexpected error occurred. During facebook signe up. please try after some time.', errorCode: ErrorCode.UNKNOWN_ERROR);
    } on AppException catch (error,stack) {
      Logger.customLogError("facebookSigneUp", error, stack);
      return DataResult.error(error, null);
    }

  }

  @override
      Future<DataResult<bool>> loginAsGuest(Map<String, dynamic> data) async{
    try {
      final userData = await remoteDatasource.loginAsGuest(data);

      if(userData.success == true){
        final isUserSaved = await session.setAccessToken(GUEST_TOKEN, userData.data['token']);
        if (isUserSaved == true) {
          return DataResult.success(true);
        }
      }
      throw AppException(message: 'An unexpected error occurred. During Guest Login account. please try after some time.', errorCode: ErrorCode.UNKNOWN_ERROR);
    } on AppException catch (error,stack) {
      Logger.customLogError("loginAsGuest", error, stack);
      return DataResult.error(error, false);
    }
  }

  @override
  Future<DataResult<bool>> emailVerification(String emailId) async {
    try {
      final data = await remoteDatasource.emailVerification(emailId);
      if(data.success == true){
        return DataResult.success(true);
      }
      throw AppException(message: 'Unable to send otp. please try after some time.', errorCode: ErrorCode.UNKNOWN_ERROR);
    } on AppException catch (error,stack) {
      Logger.customLogError("emailVerification", error, stack);
      return DataResult.error(error, false);
    }
  }




  // @override
  // Future<DataResult<bool>> logInWithGoogle() async {
  //   try {
  //     final data = await remoteDatasource.logInWithGoogle();
  //     Logger.customLogData("logInWithGoogle",data.toString());
  //     return DataResult.success(true);
  //   } on AppException catch (error, stack) {
  //     Logger.customLogError("logInWithGoogle", error, stack);
  //     return DataResult.error(error, null);
  //   }
  // }

}


