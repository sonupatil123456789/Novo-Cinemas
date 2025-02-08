import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/core/utils/ListnerUtils.dart';
import '../../../../components/ArtBoard.dart';
import '../../../../components/BackButtonNavbar.dart';
import '../../../../components/CircularLoader.dart';
import '../../../../components/CustomButton.dart';
import '../../../../components/dropdown/coustom_icon_dropdown.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/enums.dart';
import '../bloc/AuthBloc.dart';
import '../components/AuthStaticData.dart';
import '../components/AuthTextField.dart';

class GuestLoginScreen extends StatefulWidget {
  Function(bool) callback;
  GuestLoginScreen({super.key, required this.callback});

  @override
  State<GuestLoginScreen> createState() => _GuestLoginScreenState();
}




class _GuestLoginScreenState extends State<GuestLoginScreen> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();



  @override
  void initState() {
    super.initState();
    firstName.text = context.read<AuthBloc>().state.firstName.toString().trim();
    lastName.text = context.read<AuthBloc>().state.lastName.toString().trim();
    phoneNumber.text =context.read<AuthBloc>().state.phoneNumber.toString().trim();
    email.text = context.read<AuthBloc>().state.email.toString().trim();
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    phoneNumber.dispose();
    email.dispose();
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
                                  "Guest User Details",
                                  overflow: TextOverflow.ellipsis,
                                  style: context.textThemeDecoration.titleLarge,
                                ),
                                Text(
                                  "Please fill in the details before proceeding",
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
                      AuthTextField(
                        controller: firstName,
                        keyboardType: TextInputType.name,
                        width: context.getScreenWidth(35),
                        validateTextField: [
                          FormBuilderValidators.firstName(errorText: 'Enter valid FirstName')
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
                          FormBuilderValidators.lastName(errorText: 'Enter valid LastName')
                        ],
                        getTextFieldValue: (lastName) {
                          context.read<AuthBloc>().add(OnLastNameChanged(lastName));
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
                    keyboardType: TextInputType.emailAddress,
                    width: context.getScreenWidth(100),
                    validateTextField: [
                      FormBuilderValidators.email(errorText: 'Enter valid email',)
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
                        buildWhen: (previous, current) => previous.phoneNumberCode != current.phoneNumberCode,
                        builder: (BuildContext context, AuthState authState) {
                          return CoustomIconDropDown<Map<String,dynamic>>(
                            borderColor: context.colorPalette.accentColor,
                            bgColor: context.colorPalette.backGroundColor,
                            width: context.getScreenWidth(28),
                            itemWidth:context.getScreenWidth(90) ,
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
                        controller: phoneNumber,
                        keyboardType: TextInputType.number,
                        width: context.getScreenWidth(46),
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
                  SizedBox(height: context.getScreenHeight(5),),

                  BlocBuilder<AuthBloc, AuthState>(
                    buildWhen: (previous, current) =>previous.guestLoginState != current.guestLoginState ||
                        previous.phoneNumberCode != current.phoneNumberCode,
                    builder: (context, authState) {
                      if (authState.guestLoginState == CurrentAppState.LOADING) {
                        return const CircularLoader();
                      }

                      return CustomButton(
                        height: context.getScreenHeight(6),
                        backgroundColor: context.colorPalette.accentColor,
                        text: 'Continue As Guest',
                        textColor: Colors.black,
                        onTap: () {

                          guestLogin(context, authState, _formKey, (){
                            widget.callback(true);
                          });


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






void guestLogin(BuildContext context , AuthState authState ,GlobalKey<FormState> formKey, Function onSuccess ){

  if(authState.phoneNumberCode == null){
    ListnersUtils.showErrorMessage('Phone number country code should not be empty', 'Enter Valid Data', context);
  }

  else{

    if (formKey.currentState?.validate() == true) {

      context.read<AuthBloc>().add(LoginAsGuestEvent(
        onFailure: (AppException error) {
          ListnersUtils.showErrorMessage(error.message, 'Login As Guest Error', context);
        }, onSuccess: () {
        onSuccess();
      }, ));

    }
  }
}





