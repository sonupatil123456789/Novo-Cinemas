import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:novocinema/components/ArtBoard.dart';
import 'package:novocinema/core/constants/RoutesName.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/core/utils/ListnerUtils.dart';
import 'package:novocinema/core/utils/Logger.dart';
import 'package:novocinema/di.dart';
import 'package:novocinema/src/Auth/presentation/screens/GuestLoginScreen.dart';
import 'package:novocinema/src/Auth/presentation/screens/SigneupScreen.dart';
import '../../../../bloc/ApplicationBloc.dart';
import '../../../../components/BackButtonNavbar.dart';
import '../../../../components/CircularLoader.dart';
import '../../../../components/CustomButton.dart';
import '../../../../core/constants/ImageConstants.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/enums.dart';
import '../bloc/AuthBloc.dart';
import '../components/AuthTextField.dart';
import '../components/PasswordTextField.dart';
import 'AdditionalDetailsScreen.dart';
import 'OtpVerificationScreen.dart';

class LogInScreen extends StatefulWidget {
  Function(bool) onLogin;
  LogInScreen({super.key, required this.onLogin});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController.text = context.read<AuthBloc>().state.email.toString().trim();
    passwordController.text =  context.read<AuthBloc>().state.password.toString().trim();
  }

  @override
  Widget build(BuildContext context) {
    return ArtBoard(
        body: Stack(
        children: [
        Column(
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                        height: context.getScreenHeight(8),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Sign In",
                                  overflow: TextOverflow.ellipsis,
                                  style: context.textThemeDecoration.titleLarge,
                                ),
                                Text(
                                  "TO NOVO PREMIER CLUB",
                                  overflow: TextOverflow.ellipsis,
                                  style: context.textThemeDecoration.paragraphLarge.copyWith(
                                    color: context.colorPalette.accentColor
                                  ),
                                ),
                              ],
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
                      height: context.getScreenHeight(2),
                    ),
                    AuthTextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      width: context.getScreenWidth(100),
                      validateTextField: [
                        FormBuilderValidators.email(
                          errorText: 'Enter valid email',
                        )
                      ],
                      getTextFieldValue: (email) {
                        context.read<AuthBloc>().add(OnEmailChanged(email));
                      },
                      lable: 'Enter Your EmailId',
                      hintText: '',
                    ),
                    SizedBox(
                      height: context.getScreenHeight(3),
                    ),
                    PasswordTextField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      width: context.getScreenWidth(100),
                      getTextFieldValue: (password) {
                        context.read<AuthBloc>().add(OnPasswordChanged(password));
                      },
                      lable: 'Enter Your Password',
                      hintText: '',
                    ),
                    SizedBox(
                      height: context.getScreenHeight(3),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.forgotPasswordScreen);
                      },
                      child: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          "Forgot Password?",
                          style: context.textThemeDecoration.subTitleMedium,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: context.getScreenHeight(3),
                    ),
                    BlocBuilder<AuthBloc, AuthState>(
                      buildWhen: (previous, current) => previous.loginState != current.loginState|| current.email != previous.email || current.password != previous.password,
                      builder: (context, authState) {
                        if (authState.loginState == CurrentAppState.LOADING) {
                          return const CircularLoader();
                        }

                        return CustomButton(
                          height: context.getScreenHeight(6),
                          backgroundColor: context.colorPalette.accentColor,
                          text: 'Sign In',
                          textColor: Colors.black,
                          onTap: () {


                            if (_formKey.currentState?.validate() == true) {
                              context.read<AuthBloc>().add(LoginEvent(
                                      onFailure: (AppException error) {
                                        if(error.errorCode == ErrorCode.FORBIDDEN_ERROR){

                                          context.read<AuthBloc>().add(EmailVerificationEvent(
                                              email: authState.email,
                                              onFailure: (AppException error) {
                                                ListnersUtils.showErrorMessage( error.message, 'LogIn Error', context);
                                              },
                                              onSuccess: (){
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                      settings: const RouteSettings( name: RoutesName.otpVerificationScreen),
                                                      builder: (context) {
                                                        return OtpVerificationScreen(
                                                          email: authState.email,
                                                          otpVerificationType: OtpVerificationType.SIGN_UP,
                                                          onOtpVerification: (String email, String token) {
                                                            context.read<AuthBloc>().add(GetUserDetailsEvent(
                                                                onFailure: (AppException error) {
                                                                  ListnersUtils.showErrorMessage(error.message, 'LogIn Error', context);
                                                                },
                                                                onSuccess: (){
                                                                  context.read<ApplicationBloc>().add(const SetIsUserLogInEvent(true));
                                                                  widget.onLogin(true);
                                                                }));
                                                          },
                                                        );
                                                      },
                                                    ));
                                              }));
                                        }else{
                                          ListnersUtils.showErrorMessage( error.message, 'LogIn Error', context);
                                        }


                                  }, onSuccess: () {
                                    context.read<ApplicationBloc>().add(const SetIsUserLogInEvent(true));
                                    widget.onLogin(true);
                                  }));
                            }
                          },
                          width: context.getScreenWidth(100),
                        );
                      },
                    ),
                    SizedBox(
                      height: context.getScreenHeight(3),
                    ),
                    Container(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          ImageConstants.orDevider,
                          colorFilter: ColorFilter.mode(context.isDarkMode? context.colorPalette.accentColor : context.colorPalette.darkGreyColor, BlendMode.srcIn),
                        )),
                    SizedBox(
                      height: context.getScreenHeight(3),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BlocBuilder<AuthBloc, AuthState>(
                          buildWhen: (previous, current) =>previous.googleLoginState !=  current.googleLoginState,
                          builder: (context, authState) {
                            if (authState.loginState == CurrentAppState.LOADING) {
                              return const CircularLoader();
                            }

                            return CustomButton(
                              type: ButtonType.ICON_BUTTON,
                              iconSpacing: context.getScreenWidth(3),
                              icon: ImageConstants.signeInWIthGoogle,
                              height: context.getScreenHeight(6),
                              backgroundColor:
                                  context.colorPalette.transparentColor,
                              text: 'Google',
                              textColor: context.colorPalette.textColor,
                              onTap: () {
                                context.read<AuthBloc>().add(GoogleLogInEvent( onFailure: (AppException error) {
                                        ListnersUtils.showErrorMessage( error.message,'Google SigneIn Error',context);
                                      },
                                      onSuccess:(bool isNewUser, String token) {
                                        if (isNewUser == true) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  settings: const RouteSettings(name: RoutesName.additionalDetailsScreen),
                                                  builder: (context) {
                                                    return AdditionalDetailsScreen(
                                                      callback:(bool isUpdated) {
                                                        context.read<ApplicationBloc>().add(const SetIsUserLogInEvent(true));
                                                        widget.onLogin(isUpdated);
                                                      },
                                                      token: token,
                                                      authType: AuthType.GOOGLE,
                                                    );
                                                  }));
                                        } else {
                                          context.read<ApplicationBloc>().add(const SetIsUserLogInEvent(true));
                                          widget.onLogin(true);
                                        }
                                      },
                                    ));
                              },
                              borderColor: Border.all(
                                  color: context.colorPalette.accentColor,
                                  width: 1.0),
                              width: context.getScreenWidth(34),
                            );
                          },
                        ),
                        CustomButton(
                          type: ButtonType.ICON_BUTTON,
                          iconSpacing: context.getScreenWidth(3),
                          iconSize: context.getScreenWidth(6),
                          icon: ImageConstants.signeInWIthFacebook,
                          height: context.getScreenHeight(6),
                          backgroundColor:
                              context.colorPalette.transparentColor,
                          text: 'FACEBOOK',
                          textColor: context.colorPalette.textColor,
                          onTap: () async {
                            context.read<AuthBloc>().add(FacebookLogInEvent(
                                  onFailure: (AppException error) {
                                    ListnersUtils.showErrorMessage(
                                        error.message,
                                        'Facebook SigneIn Error',
                                        context);
                                  },
                                  onSuccess: (bool isNewUser, String token) {
                                    if (isNewUser == true) {
                                      Navigator.push(
                                          context,MaterialPageRoute(settings: const RouteSettings( name: RoutesName .additionalDetailsScreen),
                                              builder: (context) {
                                                return AdditionalDetailsScreen(
                                                  callback: (bool isUpdated) {
                                                    context.read<ApplicationBloc>().add(const SetIsUserLogInEvent(true));
                                                    widget.onLogin(isUpdated);
                                                  },
                                                  token: token,
                                                  authType: AuthType.FACEBOOK,
                                                );
                                              }));
                                    } else {
                                      context.read<ApplicationBloc>().add(const SetIsUserLogInEvent(true));
                                      widget.onLogin(true);
                                    }
                                  },
                                ));
                          },
                          borderColor: Border.all(
                              color: context.colorPalette.accentColor,
                              width: 1.0),
                          width: context.getScreenWidth(34),
                        )
                      ],
                    ),
                    SizedBox(
                      height: context.getScreenHeight(3),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              settings: const RouteSettings(
                                  name: RoutesName.signeUpScreen),
                              builder: (context) {
                                return SigneUpScreen(
                                  onSignein: (bool isSigneIn) {
                                    widget.onLogin(isSigneIn);
                                  },
                                );
                              },
                            ));
                      },
                      child: Container(
                          alignment: Alignment.center,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Don’t have an account? ',
                                    style: context.textThemeDecoration.subTitleMedium),
                                TextSpan(
                                  text: 'Sign Up',
                                  style: context .textThemeDecoration.subTitleMedium.copyWith(color: context.colorPalette.accentColor),
                                )
                              ],
                            ),
                          )),
                    ),
                    SizedBox(
                      height: context.getScreenHeight(3),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(settings: const RouteSettings(  name: RoutesName.guestLoginScreen),
                              builder: (context) {
                                return GuestLoginScreen(
                                  callback: (bool isGuestLogIn) {
                                    context.read<ApplicationBloc>().add(const SetIsUserLogInEvent(true));
                                    widget.onLogin(isGuestLogIn);
                                  },
                                );
                              },
                            ));
                      },
                      child: Container(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Continue as guest',
                                style: context
                                    .textThemeDecoration.subTitleMedium
                                    .copyWith(
                                        color:
                                            context.colorPalette.accentColor),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Icon(
                                Icons.arrow_circle_right,
                                color: context.colorPalette.accentColor,
                                size: context.getScreenWidth(5),
                              )
                            ],
                          )),
                    ),
                    SizedBox(
                      height: context.getScreenHeight(3),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            if (authState.faceBookLoginState == CurrentAppState.LOADING || authState.googleLoginState == CurrentAppState.LOADING) {
              return AbsorbPointer(
                absorbing: true,
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 6,
                    sigmaY: 6,
                  ),
                  // child: const SizedBox()
                  child: const Center(child: CircularLoader()),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        )
      ],
    ));
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }
}

