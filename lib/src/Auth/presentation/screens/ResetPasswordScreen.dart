import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/core/constants/RoutesName.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/Auth/presentation/components/PasswordTextField.dart';

import '../../../../components/ArtBoard.dart';
import '../../../../components/BackButtonNavbar.dart';
import '../../../../components/CircularLoader.dart';
import '../../../../components/CustomButton.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/enums.dart';
import '../../../../core/utils/ListnerUtils.dart';
import '../bloc/AuthBloc.dart';


class ResetPasswordScreen extends StatelessWidget {
  String token ;
  String email ;

   ResetPasswordScreen({super.key, required this.email, required this.token});



  TextEditingController passwordController = TextEditingController();

  TextEditingController cPasswordController = TextEditingController();

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
                                'Reset your Password',
                                overflow: TextOverflow.ellipsis,
                                style: context.textThemeDecoration.titleLarge,
                              ),
                              Text(
                                'Please enter a new password. Your new password must be different from your old password',
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
                PasswordTextField(
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  width: context.getScreenWidth(100),
                  getTextFieldValue: (email) {},
                  lable: 'Enter Your New Password',
                  hintText: '',
                ),
                SizedBox(
                  height: context.getScreenHeight(2),
                ),
                PasswordTextField(
                  controller: cPasswordController,
                  keyboardType: TextInputType.text,
                  width: context.getScreenWidth(100),
                  getTextFieldValue: (email) {},
                  lable: 'Enter Your New Password',
                  hintText: '',
                ),

                SizedBox(
                  height: context.getScreenHeight(5),
                ),

                BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (previous, current) => previous.changePasswordState != current.changePasswordState,
                  builder: (context, state) {
                    if (state.changePasswordState == CurrentAppState.LOADING) {
                      return const CircularLoader();
                    }

                    return CustomButton(
                      height: context.getScreenHeight(6),
                      backgroundColor: context.colorPalette.accentColor,
                      text: 'Send Otp',
                      textColor: Colors.black,

                      isDisabled: passwordController.text.toString().trim().isEmpty ? true :false ,
                      onTap: () {
                        final password = passwordController.text.toString().trim();
                        final confirmPassword = cPasswordController.text.toString().trim();

                        if(password == confirmPassword){
                          context.read<AuthBloc>().add(ResetPasswordEvent(
                              data: <String,dynamic>{
                                "token": token,
                                "newPassword": passwordController.text.toString().trim(),
                                "email": email
                              },
                              onFailure: (AppException error ) {
                                ListnersUtils.showErrorMessage(error.message, 'Forgot password Error', context);
                              },
                              onSuccess: (){
                                Navigator.popUntil(context, (route) => route.settings.name == RoutesName.loginScreen,);
                              }
                          ));
                        }else{
                          ListnersUtils.showErrorMessage('Please enter correct confirm password', 'Incorrect  Password', context);
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

