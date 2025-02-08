import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/core/resources/AppException.dart';
import 'package:novocinema/core/theams/Utils.dart';

import '../../../../components/ArtBoard.dart';
import '../../../../components/BackButtonNavbar.dart';
import '../../../../components/CircularLoader.dart';
import '../../../../components/CustomButton.dart';
import '../../../../components/customcomp/otp_textfield.dart';
import '../../../../core/constants/ApiUrlConstants.dart';
import '../../../../core/constants/RoutesName.dart';
import '../../../../core/resources/enums.dart';
import '../../../../core/utils/ListnerUtils.dart';
import '../bloc/AuthBloc.dart';

enum OtpVerificationType{
  SIGN_UP('Email Verification','Enter the otp for verification',ApiUrlConstants.verifyEmailOtp),
  FORGOT_PASSWORD('Forgot Password','Enter the otp for verification',ApiUrlConstants.validateResetOtp);

  const OtpVerificationType(this.title,this.subTitle,this.apiPathParam);

  final String title;
  final String subTitle ;
  final String apiPathParam ;
}

class OtpVerificationScreen extends StatelessWidget {
  String email;
  OtpVerificationType otpVerificationType;
  Function(String ,String) onOtpVerification;
  OtpVerificationScreen({super.key, required this.email, required this.otpVerificationType,required this.onOtpVerification});

  String? Otp;


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
            child:Column(
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
                                otpVerificationType.title,
                                overflow: TextOverflow.ellipsis,
                                style: context.textThemeDecoration.titleLarge,
                              ),
                              Text(
                                otpVerificationType.subTitle,
                                overflow: TextOverflow.ellipsis,
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
                OtpTextField(
                  height: context.getScreenHeight(8),
                  width: context.getScreenWidth(100),
                  getOtpTextFieldValue: (otp) {
                    Otp = otp ;
                  },
                  validateTextField: (value) {},
                ),
                SizedBox(
                  height: context.getScreenHeight(5),
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (previous, current) =>previous.verifyOtpState != current.verifyOtpState,
                  builder: (context, state) {
                    if (state.verifyOtpState == CurrentAppState.LOADING) {
                      return const CircularLoader();
                    }

                    return CustomButton(
                      height: context.getScreenHeight(6),
                      backgroundColor: context.colorPalette.accentColor,
                      text: 'Verify Otp',
                      textColor: Colors.black,
                      onTap: () {

                        if(Otp != null){
                          context.read<AuthBloc>().add(VerifyOtpEvent(
                              data:  <String, dynamic>{
                                "otp": Otp ?? '',
                                "email": email
                              },
                              onFailure: (AppException error) {
                                ListnersUtils.showErrorMessage(error.message, 'Invalid Otp', context);
                              },
                              onSuccess: (String token) {
                                onOtpVerification(email , token);
                              }, otpVerificationType: otpVerificationType));
                        }
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
