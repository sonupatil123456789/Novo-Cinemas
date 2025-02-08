import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/core/utils/ListnerUtils.dart';
import 'package:novocinema/src/Auth/presentation/screens/OtpVerificationScreen.dart';
import '../../../../components/ArtBoard.dart';
import '../../../../components/BackButtonNavbar.dart';
import '../../../../components/CircularLoader.dart';
import '../../../../components/CustomButton.dart';
import '../../../../components/customcomp/date_picker.dart';
import '../../../../components/dropdown/coustom_icon_dropdown.dart';
import '../../../../core/constants/RoutesName.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/enums.dart';
import '../bloc/AuthBloc.dart';
import '../components/AuthStaticData.dart';
import '../components/AuthTextField.dart';
import '../components/PasswordTextField.dart';

class SigneUpScreen extends StatefulWidget {
  Function(bool) onSignein;
  SigneUpScreen({super.key, required this.onSignein});

  @override
  State<SigneUpScreen> createState() => _SigneUpScreenState();
}

class _SigneUpScreenState extends State<SigneUpScreen> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController referralCode = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(const GetAllNationalityEvent());

    firstName.text = context.read<AuthBloc>().state.firstName.toString().trim();
    lastName.text = context.read<AuthBloc>().state.lastName.toString().trim();
    phoneNumber.text =
        context.read<AuthBloc>().state.phoneNumber.toString().trim();
    email.text = context.read<AuthBloc>().state.email.toString().trim();
    password.text = context.read<AuthBloc>().state.password.toString().trim();
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    phoneNumber.dispose();
    email.dispose();
    password.dispose();
    referralCode.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

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
                                "Sign Up",
                                overflow: TextOverflow.ellipsis,
                                style: context.textThemeDecoration.titleLarge,
                              ),
                              Text(
                                "TO NOVO PREMIER CLUB",
                                overflow: TextOverflow.ellipsis,
                                style: context
                                    .textThemeDecoration.paragraphLarge
                                    .copyWith(
                                        color:
                                            context.colorPalette.accentColor),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 15,
                          ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AuthTextField(
                        controller: firstName,
                        keyboardType: TextInputType.name,
                        width: context.getScreenWidth(35),
                        validateTextField: [
                          FormBuilderValidators.firstName(
                              errorText: 'Enter valid FirstName')
                        ],
                        getTextFieldValue: (firstname) {
                          context
                              .read<AuthBloc>()
                              .add(OnFirstNameChanged(firstname));
                        },
                        lable: 'First Name',
                        hintText: '',
                      ),
                      AuthTextField(
                        controller: lastName,
                        keyboardType: TextInputType.name,
                        width: context.getScreenWidth(35),
                        validateTextField: [
                          FormBuilderValidators.lastName(
                              errorText: 'Enter valid LastName')
                        ],
                        getTextFieldValue: (lastName) {
                          context
                              .read<AuthBloc>()
                              .add(OnLastNameChanged(lastName));
                        },
                        lable: 'Last Name',
                        hintText: '',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: context.getScreenHeight(2),
                  ),
                  AuthTextField(
                    controller: email,
                    width: context.getScreenWidth(100),
                    keyboardType: TextInputType.emailAddress,
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
                    height: context.getScreenHeight(2),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<AuthBloc, AuthState>(
                        buildWhen: (previous, current) =>
                            previous.phoneNumberCode != current.phoneNumberCode,
                        builder: (BuildContext context, AuthState authState) {
                          return CoustomIconDropDown<Map<String, dynamic>>(
                            borderColor: context.colorPalette.accentColor,
                            bgColor: context.colorPalette.backGroundColor,
                            width: context.getScreenWidth(28),
                            itemWidth: context.getScreenWidth(90),
                            textColor: context.colorPalette.textColor,
                            height: context.getScreenHeight(6),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: context.isDarkMode
                                  ? context.colorPalette.accentColor
                                  : context.colorPalette.darkGreyColor,
                            ),
                            selectedTextColor:
                                context.colorPalette.darkGreyColor,
                            selectedDropdownColor:
                                context.colorPalette.accentColor,
                            selectItem: authState.phoneNumberCode,
                            dataList: phoneNoCode
                                .map((value) =>
                                    DropDownItemData<Map<String, dynamic>>(
                                        value, value['Code'], value['Id']))
                                .toList(),
                            selectedDataOnTap:
                                (DropDownItemData<Map<String, dynamic>> data,
                                    Map<String, dynamic> value) {
                              context
                                  .read<AuthBloc>()
                                  .add(OnPhoneNumberCountryChanged(data));
                            },
                            unSelectedTextColor:
                                context.colorPalette.textColor.withOpacity(0.6),
                            placeHolder: 'Code',
                          );
                        },
                      ),
                      AuthTextField(
                        controller: phoneNumber,
                        keyboardType: TextInputType.number,
                        width: context.getScreenWidth(46),
                        validateTextField: [
                          FormBuilderValidators.phoneNumber(
                            errorText: 'Enter valid phone number',
                          )
                        ],
                        getTextFieldValue: (phoneNo) {
                          context
                              .read<AuthBloc>()
                              .add(OnPhoneNumberChanged(phoneNo));
                        },
                        lable: 'Enter Your Phone Number ',
                        hintText: '',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: context.getScreenHeight(2),
                  ),
                  PasswordTextField(
                    controller: password,
                    keyboardType: TextInputType.text,
                    width: context.getScreenWidth(100),
                    getTextFieldValue: (password) {
                      context.read<AuthBloc>().add(OnPasswordChanged(password));
                    },
                    lable: 'Enter Your Password',
                    hintText: '',
                  ),
                  SizedBox(
                    height: context.getScreenHeight(2),
                  ),
                  BlocBuilder<AuthBloc, AuthState>(
                    buildWhen: (previous, current) =>
                        previous.nationalityState != current.nationalityState ||
                        previous.selectedNationality !=
                            current.selectedNationality,
                    builder: (BuildContext context, AuthState authState) {
                      return CoustomIconDropDown<Map<String, dynamic>>(
                        borderColor: context.colorPalette.accentColor,
                        bgColor: context.colorPalette.backGroundColor,
                        width: context.getScreenWidth(90),
                        itemWidth: context.getScreenWidth(90),
                        textColor: context.colorPalette.textColor,
                        height: context.getScreenHeight(6),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: context.isDarkMode
                              ? context.colorPalette.accentColor
                              : context.colorPalette.darkGreyColor,
                        ),
                        selectedTextColor: context.colorPalette.darkGreyColor,
                        selectedDropdownColor: context.colorPalette.accentColor,
                        selectItem: authState.selectedNationality,
                        dataList: authState.nationalityList
                            .map((value) => DropDownItemData(
                                value, value['label'], value.toString()))
                            .toList(),
                        selectedDataOnTap:
                            (DropDownItemData<Map<String, dynamic>> data,
                                Map<String, dynamic> value) {
                          context
                              .read<AuthBloc>()
                              .add(OnNationalityChanged(data));
                        },
                        unSelectedTextColor:
                            context.colorPalette.textColor.withOpacity(0.6),
                        placeHolder: 'Select Your Nationality',
                      );
                    },
                  ),
                  SizedBox(
                    height: context.getScreenHeight(2),
                  ),
                  CoustomDatePicker<String>(
                    borderColor: context.colorPalette.accentColor,
                    bgColor: context.colorPalette.backGroundColor,
                    width: context.getScreenWidth(90),
                    height: context.getScreenHeight(6),
                    icon: Icon(
                      Icons.date_range,
                      color: context.isDarkMode
                          ? context.colorPalette.accentColor
                          : context.colorPalette.darkGreyColor,
                    ),
                    selectedTextColor: context.colorPalette.textColor,
                    unSelectedTextColor:
                        context.colorPalette.textColor.withOpacity(0.6),
                    placeHolder: 'Select Your Birthdate',
                    pickedDate: (DateTime value) {
                      context.read<AuthBloc>().add(OnDateChanged(value));
                    },
                  ),
                  SizedBox(
                    height: context.getScreenHeight(2),
                  ),
                  SizedBox(
                    width: context.getScreenWidth(100),
                    height: context.getScreenHeight(7),
                    child: BlocBuilder<AuthBloc, AuthState>(
                      buildWhen: (previous, current) =>
                          previous.gender != current.gender,
                      builder: (BuildContext context, AuthState authState) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            gender.length,
                            (index) {
                              final myGender = gender[index];
                              return GestureDetector(
                                onTap: () {
                                  context
                                      .read<AuthBloc>()
                                      .add(OnGenderChanged(myGender!));
                                },
                                child: Container(
                                  height: context.getScreenHeight(6),
                                  padding: EdgeInsets.only(
                                      left: context.getScreenWidth(2),
                                      right: context.getScreenWidth(7)),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.4,
                                          color:
                                              context.colorPalette.accentColor),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Radio(
                                        value: myGender,
                                        activeColor:
                                            context.colorPalette.accentColor,
                                        groupValue: authState.gender,
                                        visualDensity: VisualDensity.compact,
                                        onChanged: (value) {},
                                      ),
                                      Text(
                                        myGender,
                                        style: context
                                            .textThemeDecoration.subTitleMedium,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: context.getScreenHeight(2),
                  ),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, authState) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (authState.createAccountState ==
                              CurrentAppState.LOADING) ...[
                            const CircularLoader()
                          ] else ...[
                            CustomButton(
                              height: context.getScreenHeight(6),
                              backgroundColor: context.colorPalette.accentColor,
                              text: 'Sign Up',
                              textColor: Colors.black,
                              onTap: () {
                                signeUp(context, authState, _formKey, () {
                                  widget.onSignein(true);
                                });
                              },
                              width: context.getScreenWidth(90),
                            )
                          ],
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: context.getScreenHeight(2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // footer: BlocBuilder<AuthBloc, AuthState>(
      //   builder: (context, authState) {
      //     return Container(
      //       color: context.colorPalette.backGroundColor,
      //       width: context.getScreenWidth(100),
      //       height: context.getScreenHeight(8),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           if (authState.createAccountState ==CurrentAppState.LOADING) ...[
      //             const CircularLoader()
      //           ] else ...[
      //             CustomButton(
      //               height: context.getScreenHeight(6),
      //               backgroundColor: context.colorPalette.accentColor,
      //               text: 'Sign Up',
      //               textColor: Colors.black,
      //               onTap: () {
      //                 signeUp(context, authState, _formKey, () {
      //                   widget.onSignein(true);
      //                 });
      //               },
      //               width: context.getScreenWidth(90),
      //             )
      //           ],
      //         ],
      //       ),
      //     );
      //   },
      // )
    );
  }
}

void signeUp(BuildContext context, AuthState authState,
    GlobalKey<FormState> formKey, Function onSigneup) {
  if (authState.phoneNumberCode == null) {
    ListnersUtils.showErrorMessage(
        'Phone number country code should not be empty',
        'Enter Valid Data',
        context);
  } else if (authState.selectedNationality == null) {
    ListnersUtils.showErrorMessage(
        'Nationality should not be empty', 'Enter Valid Data', context);
  } else if (authState.dateOfBirth == null) {
    ListnersUtils.showErrorMessage(
        'Birthdate should not be empty ${authState.dateOfBirth}',
        'Enter Valid Data',
        context);
  } else {
    if (formKey.currentState?.validate() == true) {
      context
          .read<AuthBloc>()
          .add(SigneUpEvent(onFailure: (AppException error) {
            ListnersUtils.showErrorMessage(
                error.message, 'Sign In Error', context);
          }, onSuccess: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  settings: const RouteSettings(
                      name: RoutesName.otpVerificationScreen),
                  builder: (context) {
                    return OtpVerificationScreen(
                      email: authState.email,
                      otpVerificationType: OtpVerificationType.SIGN_UP,
                      onOtpVerification: (String email, String token) {
                        context.read<AuthBloc>().add(GetUserDetailsEvent(
                            onFailure: (AppException error) {
                              ListnersUtils.showErrorMessage(
                                  error.message, 'Sign In Error', context);
                            },
                            onSuccess: onSigneup));
                      },
                    );
                  },
                ));
          }));
    }
  }
}
