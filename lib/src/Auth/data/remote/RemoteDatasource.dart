
import 'package:firebase_auth/firebase_auth.dart';
import 'package:novocinema/core/constants/ApiUrlConstants.dart';
import 'package:novocinema/core/restServices/BaseApi.dart';
import 'package:novocinema/src/Auth/presentation/screens/OtpVerificationScreen.dart';
import '../dto/UserAuthDto.dart';
import '../../../../core/resources/ResponseDto.dart';

 abstract interface class AuthRemoteDatasource {



   Future<ResponseDto<Map<String,dynamic>>> signeUp(Map<String,dynamic> customer);

   Future<ResponseDto<Map<String,dynamic>>> logIn(String email, String password);

   Future<ResponseDto<UserAuthDto>> getUserDetails();

   Future<ResponseDto<Map<String,dynamic>>?> googleLogIn();

   Future<ResponseDto<Map<String,dynamic>>> googleSigneUp(Map<String,dynamic> data);

   Future<UserCredential> logInWithApple();

   Future<ResponseDto<Map<String,dynamic>>> forgotPassword(String emailId);

   Future<ResponseDto<Map<String,dynamic>>> emailVerification(String emailId);

   Future<ResponseDto<Map<String,dynamic>>> verifyOtp(Map<String,dynamic> data, OtpVerificationType otpVerificationType);

   Future<ResponseDto<Map<String,dynamic>>> resetPassword(Map<String,dynamic> data);

   Future<ResponseDto<List<Map<String,dynamic>>>> getAllNationality();

   Future<ResponseDto<Map<String,dynamic>>?> facebookLogIn();

   Future<ResponseDto<Map<String,dynamic>>> facebookSigneUp(Map<String,dynamic> data);

   Future<ResponseDto<Map<String,dynamic>>> loginAsGuest(Map<String,dynamic> data);



}