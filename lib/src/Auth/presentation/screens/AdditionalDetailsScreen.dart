
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:novocinema/core/theams/Utils.dart';
import '../../../../components/ArtBoard.dart';
import '../../../../components/BackButtonNavbar.dart';
import '../../../../components/CircularLoader.dart';
import '../../../../components/CustomButton.dart';
import '../../../../components/customcomp/date_picker.dart';
import '../../../../components/dropdown/coustom_icon_dropdown.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/enums.dart';
import '../../../../core/utils/ListnerUtils.dart';
import '../bloc/AuthBloc.dart';
import '../components/AuthStaticData.dart';
import '../components/AuthTextField.dart';
import 'SigneupScreen.dart';

enum  AuthType {
  GOOGLE,
  FACEBOOK,
  LOGIN,
  GUEST_LOGIN
}

class AdditionalDetailsScreen extends StatefulWidget {
  Function(bool) callback ;
  String token ;
  AuthType authType;
  AdditionalDetailsScreen({super.key, required this.callback, required  this.token , required this.authType });

  @override
  State<AdditionalDetailsScreen> createState() => _AdditionalDetailsScreenState();
}

class _AdditionalDetailsScreenState extends State<AdditionalDetailsScreen> {


  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

  }

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
            child:Form(
              key: _formKey,
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
                                  "User Details",
                                  overflow: TextOverflow.ellipsis,
                                  style: context.textThemeDecoration.titleLarge,
                                ),
                                Text(
                                  "Add Additional User Details",
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<AuthBloc, AuthState>(
                        buildWhen: (previous, current) => previous.phoneNumberCode != current.phoneNumberCode,
                        builder: (BuildContext context, AuthState authState) {
                          return CoustomIconDropDown<Map<String,dynamic>>(
                            borderColor: context.colorPalette.accentColor,
                            bgColor: context.colorPalette.backGroundColor,
                            width: context.getScreenWidth(30),
                            itemWidth:context.getScreenWidth(90) ,
                            textColor: context.colorPalette.textColor,
                            height: context.getScreenHeight(7),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: context.isDarkMode
                                  ? context.colorPalette.accentColor
                                  : context.colorPalette.darkGreyColor,
                            ),
                            selectedTextColor: context.colorPalette.darkGreyColor,
                            selectedDropdownColor: context.colorPalette.accentColor,
                            selectItem:authState.phoneNumberCode,
                            dataList: phoneNoCode.map((value)=> DropDownItemData<Map<String,dynamic>>(value, value['Code'], value['Id'])).toList(),
                            selectedDataOnTap: (DropDownItemData<Map<String,dynamic>> data, Map<String,dynamic> value){
                              context.read<AuthBloc>().add(OnPhoneNumberCountryChanged(data));
                            }, unSelectedTextColor: context.colorPalette.textColor.withOpacity(0.6),
                            placeHolder: 'Code',
                          );
                        },
                      ),

                      AuthTextField(
                        width: context.getScreenWidth(50),
                        keyboardType: TextInputType.number,
                        validateTextField: [
                          FormBuilderValidators.phoneNumber(errorText: 'Enter valid phone number')
                        ],
                        getTextFieldValue: (phoneNo) {
                          context.read<AuthBloc>().add(OnPhoneNumberChanged(phoneNo));
                        },
                        lable: 'Enter Your Phone Number ',
                        hintText: '',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: context.getScreenHeight(2),
                  ),
                  CoustomDatePicker<String>(
                    borderColor: context.colorPalette.accentColor,
                    bgColor: context.colorPalette.backGroundColor,
                    width: context.getScreenWidth(90),
                    height: context.getScreenHeight(7),
                    icon: Icon(
                      Icons.date_range,
                      color: context.isDarkMode
                          ? context.colorPalette.accentColor
                          : context.colorPalette.darkGreyColor,
                    ),
                    selectedTextColor: context.colorPalette.textColor,
                    unSelectedTextColor: context.colorPalette.textColor.withOpacity(0.6),
                    placeHolder: 'Select Your Birthdate', pickedDate: (DateTime value){
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
                          children: List.generate(gender.length,(index) {
                            final myGender = gender[index];
                            return GestureDetector(
                              onTap: () {
                                context.read<AuthBloc>().add(OnGenderChanged(myGender!));
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: context.getScreenWidth(2),
                                    right: context.getScreenWidth(7)),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.4,
                                        color: context.colorPalette.accentColor),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Radio(
                                      value: myGender,
                                      activeColor:context.colorPalette.accentColor,
                                      groupValue: authState.gender,
                                      visualDensity: VisualDensity.compact,
                                      onChanged: (value) {},
                                    ),
                                    Text(
                                      myGender,
                                      style: context .textThemeDecoration.subTitleMedium,
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


                  SizedBox(height: context.getScreenHeight(5),),

                  BlocBuilder<AuthBloc, AuthState>(
                    buildWhen: (previous, current) =>previous.googleLoginState != current.googleLoginState
                        ||previous.faceBookLoginState != current.faceBookLoginState ||
                        previous.gender != current.gender || previous.dateOfBirth != current.dateOfBirth
                        || previous.phoneNumberCode != current.phoneNumberCode,
                    builder: (context, authState) {
                      if (
                      authState.googleLoginState == CurrentAppState.LOADING ||
                          authState.faceBookLoginState == CurrentAppState.LOADING
                      ) {
                        return const CircularLoader();
                      }

                      return CustomButton(
                        height: context.getScreenHeight(6),
                        backgroundColor: context.colorPalette.accentColor,
                        text: 'Signe Up',
                        textColor: Colors.black,
                        onTap: () {

                          signeUp(context,authState,_formKey,(){
                            widget.callback(true);
                          },widget.authType, widget.token);


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
          ),
        ],
      ),
    );
  }

}




void signeUp(BuildContext context , AuthState authState ,GlobalKey<FormState> formKey, Function onSuccess,AuthType authType, String token  ){

  if(authState.phoneNumberCode == null){
    ListnersUtils.showErrorMessage('Phone number country code should not be empty ${authState.phoneNumberCode}', 'Enter Valid Data', context);
  }

  else if(authState.dateOfBirth == null){
    ListnersUtils.showErrorMessage('Birthdate should not be empty ${authState.dateOfBirth}', 'Enter Valid Data', context);
  }

  else{

    if (formKey.currentState?.validate() == true) {

      if(authType == AuthType.GOOGLE){
        context.read<AuthBloc>().add(GoogleSigneUpEvent(
          onFailure: (AppException error) {
            ListnersUtils.showErrorMessage(error.message, 'Google SigneUn Error', context);
          }, onSuccess: () {
          onSuccess();
        },
          token: token,
        )
        );
      }

      if(authType == AuthType.FACEBOOK){
        context.read<AuthBloc>().add(FacebookSigneUpEvent(
          onFailure: (AppException error) {
            ListnersUtils.showErrorMessage(error.message, 'Facebook SigneUn Error', context);
          }, onSuccess: () {
          onSuccess();
        },
          token: token,
        )
        );
      }
      else {}
    }
  }
}
