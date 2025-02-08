import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:novocinema/core/resources/AppException.dart';
import 'package:novocinema/core/resources/enums.dart';

import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../core/constants/ApiUrlConstants.dart';
import '../../../../core/resources/ResponseDto.dart';
import '../../../../core/restServices/BaseApi.dart';
import '../../presentation/screens/OtpVerificationScreen.dart';
import '../dto/UserAuthDto.dart';
import 'RemoteDatasource.dart';

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  late final BaseApi responseData;
  late final FirebaseAuth _auth;
  late final GoogleSignIn _googleSignIn;
  late final FacebookAuth _facebookAuth;
  AuthRemoteDatasourceImpl(this.responseData , this._auth , this._googleSignIn ,this._facebookAuth);

  String? verificationUid;

  @override
  Future<ResponseDto<Map<String,dynamic>>> signeUp(Map<String,dynamic>  customer) async {
    try {
      Response response = await responseData.post(ApiUrlConstants.register, customer, null, null);

      final dtoResponse =ResponseDto<Map<String,dynamic>>.fromJson(response.data, (value) {
        return value ?? <String,dynamic>{};
      });

      return dtoResponse;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<ResponseDto<Map<String,dynamic>>> logIn(String email, String password) async {
    try {
      Map<String, dynamic> loginCred = {"user_email": email, "user_password": password};

      final response = await responseData.post(ApiUrlConstants.login, loginCred, null, null);

      final dtoResponse =ResponseDto<Map<String,dynamic>>.fromJson(response.data, (value) {
        return value ?? <String,dynamic>{};
      });

      return dtoResponse;
    } catch (error) {
      rethrow;
    }
  }


  @override
  Future<UserCredential> logInWithApple() async{
    try{
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );
      return await _auth.signInWithCredential(oauthCredential);

    } catch (error){
       rethrow;
    }
  }
  

  @override
  Future<ResponseDto<UserAuthDto>> getUserDetails() async{
    try {

      final response = await responseData.get(ApiUrlConstants.getUserDetails, null, null);

      final dtoResponse =ResponseDto<UserAuthDto>.fromJson(response.data, (value) {
        return UserAuthDto.fromJson(value);
      });

      return dtoResponse;
    } catch (error) {
      rethrow;
    }

  }

  @override
  Future<ResponseDto<Map<String,dynamic>>> forgotPassword(String emailId) async{
    try {
      final response = await responseData.post(ApiUrlConstants.forgotPassword,{
        'email':emailId
      }, null, null);

      final dtoResponse = ResponseDto<Map<String, dynamic>>.fromJson(response.data, (value) {
        return value ?? <String, dynamic>{};
      });

      return dtoResponse;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<ResponseDto<Map<String,dynamic>>> resetPassword(Map<String, dynamic> data) async{
    try {

      final response = await responseData.post(ApiUrlConstants.resetPassword,data, null, null);

      final dtoResponse =ResponseDto<Map<String, dynamic>>.fromJson(response.data, (value) {
        return value ?? <String, dynamic>{};
      });

      return dtoResponse;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<ResponseDto<Map<String,dynamic>>> verifyOtp(Map<String, dynamic> data, OtpVerificationType otpVerificationType) async {
    try {

      final response = await responseData.post(otpVerificationType.apiPathParam,data, null, null);

      final dtoResponse =ResponseDto<Map<String, dynamic>>.fromJson(response.data, (value) {
        return value ?? <String, dynamic>{};
      });

      return dtoResponse;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<ResponseDto<Map<String, dynamic>>?> googleLogIn() async {
    try{
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;

      if(googleSignInAuthentication != null){
        final response = await responseData.post(ApiUrlConstants.googleLogin, <String,dynamic>{
          'idToken' :googleSignInAuthentication.accessToken
        }, null, null);

        final dtoResponse = ResponseDto<Map<String,dynamic>>.fromJson(response.data, (value) {
          return value ?? <String,dynamic>{};
        });

        return dtoResponse;
      }

      return null ;
    } catch (error){
      rethrow ;
    }
  }

  @override
  Future<ResponseDto<Map<String, dynamic>>> googleSigneUp(Map<String,dynamic> data) async{
    try {

      final response = await responseData.post(ApiUrlConstants.googleSignup,data, null, null);

      final dtoResponse =ResponseDto<Map<String, dynamic>>.fromJson(response.data, (value) {
        return value ?? <String, dynamic>{};
      });

      return dtoResponse;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<ResponseDto<List<Map<String,dynamic>>>> getAllNationality() async{
    try {

      final response = await responseData.get(ApiUrlConstants.nationalities, null, null);

      final dtoResponse =ResponseDto<List<Map<String,dynamic>>>.fromJson(response.data, (value) {
        if (value == null) return [];
        return List<Map<String, dynamic>>.from(value as List);
      });

      return dtoResponse;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<ResponseDto<Map<String, dynamic>>?> facebookLogIn() async {

    try {

      final LoginResult result = await _facebookAuth.login();

      if(result.status == LoginStatus.success){
        final response = await responseData.post(ApiUrlConstants.facebookLogin, <String,dynamic>{
          'idToken' :result.accessToken?.tokenString
        }, null, null);

        final dtoResponse = ResponseDto<Map<String,dynamic>>.fromJson(response.data, (value) {
          return value ?? <String,dynamic>{};
        });
        return dtoResponse;
      }
      if(result.status == LoginStatus.failed){
         throw AppException(message: result.message ?? "Error occured during facebook login", errorCode: ErrorCode.UNKNOWN_ERROR);
      }
      return null ;
    } catch (error) {
      rethrow;
    }

  }

  @override
  Future<ResponseDto<Map<String, dynamic>>> facebookSigneUp(Map<String, dynamic> data) async {
    try {

      final response = await responseData.post(ApiUrlConstants.facebookSignup,data, null, null);

      final dtoResponse =ResponseDto<Map<String, dynamic>>.fromJson(response.data, (value) {
        return value ?? <String, dynamic>{};
      });

      return dtoResponse;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<ResponseDto<Map<String, dynamic>>> loginAsGuest(Map<String, dynamic> data) async {
    try {

      final response = await responseData.post(ApiUrlConstants.guestUser,data, null, null);

      final dtoResponse =ResponseDto<Map<String, dynamic>>.fromJson(response.data, (value) {
        return value ?? <String, dynamic>{};
      });

      return dtoResponse;
    } catch (error) {
      rethrow;
    }

  }

  @override
  Future<ResponseDto<Map<String, dynamic>>> emailVerification(String emailId) async {
    try {
      final response = await responseData.post(ApiUrlConstants.emailVerification,{
        'email':emailId
      }, null, null);

      final dtoResponse = ResponseDto<Map<String, dynamic>>.fromJson(response.data, (value) {
        return value ?? <String, dynamic>{};
      });

      return dtoResponse;
    } catch (error) {
      rethrow;
    }
  }


  //
  // @override
  // Future<void> verifyPhoneNumber(String phoneNumber) async{
  //   try{
  //     await _auth.verifyPhoneNumber(
  //       phoneNumber: phoneNumber,
  //       timeout: const Duration(seconds: 40),
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         final data =  await _auth.signInWithCredential(credential);
  //       },
  //       verificationFailed: (FirebaseAuthException e) {
  //         throw e;
  //       },
  //       codeSent: (String verificationId, int? resendToken) {
  //         verificationUid = verificationId;
  //       },
  //       codeAutoRetrievalTimeout: (String verificationId) {
  //       },
  //     );
  //   } on FirebaseAuthException catch (error){
  //     rethrow;
  //   }
  // }
  //
  // @override
  // Future<UserCredential> logInWithPhoneNumber(String Otp) async {
  //   try{
  //     final PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: verificationUid!,
  //       smsCode: Otp,
  //     );
  //
  //     return await _auth.signInWithCredential(credential);
  //
  //   } catch (error){
  //     rethrow;
  //   }
  // }


  // @override
  // Future<UserCredential> logInWithGoogle() async {
  //   try{
  //     final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
  //
  //     final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
  //
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );
  //
  //     Logger.customLogData('Google auth data ', googleSignInAuthentication.accessToken);
  //
  //     return await _auth.signInWithCredential(credential);
  //   } catch (error){
  //     rethrow ;
  //   }
  // }
  
}
