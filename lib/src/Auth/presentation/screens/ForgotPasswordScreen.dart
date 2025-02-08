import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:novocinema/core/constants/RoutesName.dart';
import 'package:novocinema/core/theams/Utils.dart';

import '../../../../components/ArtBoard.dart';
import '../../../../components/CircularLoader.dart';
import '../../../../components/CustomButton.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/enums.dart';
import '../../../../core/utils/ListnerUtils.dart';
import '../bloc/AuthBloc.dart';
import '../components/AuthTextField.dart';
import 'OtpVerificationScreen.dart';

class ForgotPasswordScreen extends StatelessWidget {
   ForgotPasswordScreen({super.key});

  TextEditingController emailController = TextEditingController();


   @override
   Widget build(BuildContext context) {
     return ArtBoard(
       body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Container(
             margin: const EdgeInsets.symmetric(horizontal: 20),
             padding: const EdgeInsets.symmetric(horizontal: 20),
             decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(12),
                 color: context.colorPalette.backGroundColor,
                 border: Border.all(
                     color: context.colorPalette.accentColor.withOpacity(0.6),
                     width: 0.6)),
             child: Column(
               children: [

                 Container(
                     height: context.getScreenHeight(8),
                     alignment: Alignment.centerLeft,
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Expanded(
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                 "Forgot Password",
                                 overflow: TextOverflow.ellipsis,
                                 style: context.textThemeDecoration.titleLarge,
                               ),
                               Text(
                                 "We’ll send you an OTP on your registered email for verification",
                                 overflow: TextOverflow.ellipsis,
                                 maxLines: 2,
                                 style: context.textThemeDecoration.paragraphLarge.copyWith(
                                     color: context.colorPalette.accentColor
                                 ),
                               ),
                             ],
                           ),
                         ),
                         const SizedBox(width: 15,),
                         GestureDetector(
                             onTap: () {
                               Navigator.pop(context);
                             },
                             child: Icon(
                               Icons.close,
                               color: context.colorPalette.accentColor,
                             ))
                       ],
                     )),
                 SizedBox(
                   height: context.getScreenHeight(5),
                 ),
                 AuthTextField(
                   controller: emailController,
                   keyboardType: TextInputType.emailAddress,
                   width: context.getScreenWidth(100),
                   validateTextField: [ FormBuilderValidators.email(errorText: 'Enter valid email',)],
                   getTextFieldValue: (email) { },
                   lable: 'Enter Your Email', hintText: '',
                 ),

                 SizedBox(
                   height: context.getScreenHeight(5),
                 ),

                 BlocBuilder<AuthBloc, AuthState>(
                   buildWhen: (previous, current) => previous.forgotPasswordState != current.forgotPasswordState,
                   builder: (context, state) {
                     if (state.forgotPasswordState == CurrentAppState.LOADING) {
                       return const CircularLoader();
                     }

                     return CustomButton(
                       height: context.getScreenHeight(6),
                       backgroundColor: context.colorPalette.accentColor,
                       text: 'Send Otp',
                       textColor: Colors.black,
                       onTap: () {
                         final email = emailController.text.toString().trim();
                         context.read<AuthBloc>().add(ForgotPasswordEvent(email: email,
                             onFailure: (AppException error ) {
                               ListnersUtils.showErrorMessage('Please enter valid email id', 'Invalid Email', context);
                             },
                             onSuccess: (){
                               ListnersUtils.showSuccessMessage('Otp is send to yours registered email', 'Success', context);
                               Navigator.push(context, MaterialPageRoute(
                                 settings: const RouteSettings(name: RoutesName.otpVerificationScreen),
                                 builder: (context) {
                                   return OtpVerificationScreen(email: email,
                                     otpVerificationType: OtpVerificationType.FORGOT_PASSWORD,
                                     onOtpVerification: (String email,String token) {
                                       Navigator.pushNamed(context, RoutesName.resetPasswordScreen,arguments: {
                                         'emailId' : email,
                                         'token':token
                                       });
                                     },);
                                 },),
                               );
                             }
                         ));
                       },
                       width: context.getScreenWidth(100),
                     );
                   },
                 ),
                 SizedBox(
                   height: context.getScreenHeight(3),
                 ),

               ],
             ),
           ),
         ],
       ),
     );
   }


}
