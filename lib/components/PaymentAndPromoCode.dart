

import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:novocinema/core/resources/enums.dart';
import 'package:novocinema/core/theams/Utils.dart';
import '../core/theams/TextTheamStyle.dart';
import 'CustomButton.dart';
import 'CustomTextField.dart';

class PaymentAndPromoCode extends StatefulWidget {
  final bool isCodeApplied ;
  final String? errorMessage;
  final String? successMessage;
  final String title ;
  final String subTitle ;
  final String hintText ;
  final CurrentAppState  onCodeAppliedState ;
  final  Function(String) onCodeApplied ;
  final CurrentAppState  onCodeRemovedState ;
  final  Function() onCodeRemoved ;
  const PaymentAndPromoCode({super.key,
    required this.isCodeApplied ,
    required this.onCodeAppliedState ,
    required this.onCodeApplied ,
    required this.onCodeRemovedState ,
    required this.onCodeRemoved ,
    this.errorMessage ,
    required this.title ,
    required this.hintText ,
    this.successMessage, required this.subTitle
  });

  @override
  State<PaymentAndPromoCode> createState() => _PaymentAndPromoCodeState();
}

class _PaymentAndPromoCodeState extends State<PaymentAndPromoCode> {


  TextEditingController promoCode = TextEditingController();

  String? errorMessage;
  String? successMessage;



  @override
  Widget build(BuildContext context) {

    final bool onRemoveCodeStateChange =
        widget.onCodeRemovedState == CurrentAppState.LOADING ? true :false ;

    final bool onApplyCodeStateChange =
        widget.onCodeAppliedState == CurrentAppState.LOADING ? true : false;



    return  Container(
      // height: context.getScreenHeight(18),
      padding: EdgeInsets.all(context.getScreenWidth(3)),
      decoration: BoxDecoration(
          // color: context.colorPalette.backGroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: context.colorPalette.accentColor.withOpacity(0.6), width: 0.4)
      ),
      width: context.getScreenWidth(100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title,
              style: context.textThemeDecoration.subTitleMedium.copyWith(
                  fontFamily: TextThemeDecoration.HamburgerFont
              )
          ),
          const SizedBox(height: 10,),
          Text(widget.subTitle,
              style: context.textThemeDecoration.subTitleMedium.copyWith(
                color:  context.colorPalette.textColor.withOpacity(0.6)
              )
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [


              CustomTextField(
                width: context.getScreenWidth(48),
                height: context.getScreenHeight(5),
                controller: promoCode,
                validateTextField: [
                  FormBuilderValidators.required(errorText: 'Please enter valid discount code')
                ],
                getTextFieldValue: (value) {},
                lable: widget.hintText,
              ),


              if(widget.isCodeApplied)...[
                CustomButton(
                  height: context.getScreenHeight(5),
                  backgroundColor: context.colorPalette.errorColor,
                  textColor: context.colorPalette.whiteColor,
                  disabledBackgroundColor: context.colorPalette.disabledErrorButtonColor,
                  text: onRemoveCodeStateChange ? 'Loading...' : 'Remove',
                  isDisabled: onRemoveCodeStateChange ? true : false,
                  onTap: () async {

                    await widget.onCodeRemoved();




                    // switch(onRemoveCodeStateChange) {
                    //   case CurrentAppState.INITIAL:
                    //   case CurrentAppState.LOADING:
                    //   setState(() {
                    //     removePromoCodeButtonLoading = true;
                    //   });
                    //   case CurrentAppState.SUCCESS:
                    //     setState(() {
                    //       removePromoCodeButtonLoading = false;
                    //     });
                    //   case CurrentAppState.ERROR:
                    //     setState(() {
                    //       removePromoCodeButtonLoading = false;
                    //     });
                    // }






                    // context.read<OffersBloc>().add(RemoveDiscountCodeOffersEvent(
                    //     onFailure: (AppException error) {
                    //       setState(() {
                    //         removePromoCodeButtonLoading = false;
                    //         errorMessage = error.message;
                    //       });
                    //     },
                    //     onSuccess: () {
                    //       setState(() {
                    //         removePromoCodeButtonLoading = false;
                    //         successMessage = null;
                    //       });
                    //     }));
                  },
                  width: context.getScreenWidth(25),
                )

              ]else ...[

                CustomButton(
                  height: context.getScreenHeight(5),
                  backgroundColor: context.colorPalette.accentColor,
                  text: onApplyCodeStateChange ? '...Loading' : 'Apply',
                  isDisabled: onApplyCodeStateChange ? true : false,
                  textColor: context.colorPalette.darkGreyColor,
                  onTap: () async {

                    await widget.onCodeApplied(promoCode.text.toString() ?? '');


                    // switch(onApplyCodeStateChange) {
                    //   case CurrentAppState.INITIAL:
                    //   case CurrentAppState.LOADING:
                    //   setState(() {
                    //     appliedPromoCodeButtonLoading = true;
                    //   });
                    //   case CurrentAppState.SUCCESS:
                    //     setState(() {
                    //       appliedPromoCodeButtonLoading = false;
                    //     });
                    //   case CurrentAppState.ERROR:
                    //     setState(() {
                    //       appliedPromoCodeButtonLoading = false;
                    //     });
                    // }





                    // context.read<OffersBloc>().add(ApplyDiscountCodeOffersEvent(data: {
                    //   "reservationId": context.read<OffersBloc>().state.reservationId,
                    //   "discountCode":promoCode.text.toString().trim(),
                    // }, onFailure: (AppException error) {
                    //   setState(() {
                    //     appliedPromoCodeButtonLoading = false  ;
                    //     errorMessage = '\u2022 ${error.message}' ;
                    //     successMessage = null;
                    //   });
                    //
                    // }, onSuccess: (){
                    //   setState(() {
                    //     appliedPromoCodeButtonLoading = false;
                    //     errorMessage = null ;
                    //     successMessage = 'Congratulations you got discount of QAR ${priceConverter(context.read<OffersBloc>().state.discountPrice!)} 🎉';
                    //   });
                    // }));



                  },
                  width: context.getScreenWidth(25),
                )

              ],

            ],
          ),

          Visibility(
            visible: widget.successMessage != null ? true : false ,
            child:Container(
              width: context.getScreenWidth(100),
              padding:  EdgeInsets.only(top: 10,left: context.getScreenWidth(3.5), right:  context.getScreenWidth(3.5), ),
              child: Text(widget.successMessage ?? 'Offer applied successfully 🎉' , style: context.textThemeDecoration.paragraphLarge.copyWith(
                  color: context.colorPalette.successColor
              ),),
            ),
          ),

          Visibility(
            visible:widget.errorMessage != null ? true : false ,
            child:Container(
              width: context.getScreenWidth(100),
              padding:  EdgeInsets.only(top: 10,left: context.getScreenWidth(3.5), right:  context.getScreenWidth(3.5), ),
              child: Text(widget.errorMessage ?? '\u2022 Invalid promo code ' , style: context.textThemeDecoration.paragraphLarge.copyWith(
                  color: context.colorPalette.errorColor
              ),),
            ),
          ),

        ],
      ),
    );
  }
}
