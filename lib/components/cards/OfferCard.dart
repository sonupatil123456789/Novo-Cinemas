import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:novocinema/core/resources/enums.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/core/utils/CurrencyFormater.dart';
import 'package:novocinema/core/utils/ListnerUtils.dart';
import 'package:novocinema/src/Offers/domain/models/BankOfferModel.dart';
import 'package:novocinema/src/Offers/presentation/bloc/OffersBloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/constants/ImageConstants.dart';
import '../../core/resources/AppException.dart';
import '../../dartassets/novoHeaderLogo.dart';
import '../../src/Offers/presentation/screens/OffersScreen.dart';
import '../CustomButton.dart';
import '../CustomTextField.dart';

enum OfferType {
  BANK_OFFER('bin'),
  NORMAL_OFFER('normal');

  final String value;

  const OfferType(this.value);
}

class ExpandableOfferCard extends StatefulWidget {
  final OfferDetailsModel? bankOffers;
  final OffersState offerState;
  final OfferType offerType;

  ExpandableOfferCard(
      {Key? key,
      required this.bankOffers,
      required this.offerState,
      required this.offerType})
      : super(key: key);

  @override
  State<ExpandableOfferCard> createState() => _ExpandableOfferCardState();
}

class _ExpandableOfferCardState extends State<ExpandableOfferCard> {
  final BorderRadius borderRadius = BorderRadius.circular(12);

  TextEditingController cardNumber = TextEditingController();

  bool removeOffer = false;
  bool appliedOfferButtonLoading = false;
  bool removeOfferButtonLoading = false;
  bool toggleTermsAndConditions = false;

  String? errorMessage;
  String? successMessage;



  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      width: context.getScreenWidth(100),
      child: ExpansionTile(
          title: Text(
            widget.bankOffers?.displayName ?? 'Random offer',
            style: context.textThemeDecoration.subTitleMedium,
          ),
          leading: ClipRRect(
            borderRadius: borderRadius,
            child: CachedNetworkImage(
              imageUrl: widget.bankOffers?.offerImage1 ?? '',
              width: context.getScreenWidth(8),
              height: context.getScreenWidth(8),
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) {
                return Shimmer.fromColors(
                    baseColor: context.colorPalette.shimmerBaseColor,
                    highlightColor: context.colorPalette.shimmerHighLightColor,
                    enabled: true,
                    child: Container(
                      color: context.colorPalette.accentColor,
                    ));
              },
              errorWidget: (context, url, error) => SvgPicture.string(
                novoHeaderLogo(context),
              ),
            ),
          ),
          minTileHeight: context.getScreenHeight(6),
          enableFeedback: true,
          collapsedIconColor: context.colorPalette.accentColor,
          iconColor: context.colorPalette.accentColor,
          childrenPadding: const EdgeInsets.all(15),
          collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                  width: 0.5,
                  color: context.colorPalette.accentColor.withOpacity(0.6))),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                  width: 0.6, color: context.colorPalette.accentColor)),
          clipBehavior: Clip.antiAlias,
          children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextField(
                  isReadOnly: widget.offerState.isOffersApplied,
                  width: context.getScreenWidth(100),
                  height: context.getScreenHeight(5),
                  validateTextField: [
                    FormBuilderValidators.required(errorText: 'Please enter valid card details')
                  ],
                  controller: cardNumber,
                  getTextFieldValue: (value) {},
                  lable: 'Enter Card Number',
                ),

                const SizedBox(height: 12,),

                handelApplyOffers(offerType: widget.offerType)

              ],
            ),
            Visibility(
              visible: successMessage != null ? true : false ,
                child:Container(
                  width: context.getScreenWidth(100),
                  padding: const EdgeInsets.only(top: 10,left: 5),
                  child: Text(successMessage ?? 'Offer applied successfully 🎉' , style: context.textThemeDecoration.paragraphLarge.copyWith(
                      color: context.colorPalette.successColor
                  ),),
                ),
            ),

            Visibility(
              visible: errorMessage != null ? true : false ,
              child:Container(
                width: context.getScreenWidth(100),
                padding: const EdgeInsets.only(top: 10,left: 5),
                child: Text(errorMessage ?? '\u2022 Invalid promo code ' , style: context.textThemeDecoration.paragraphLarge.copyWith(
                    color: context.colorPalette.errorColor
                ),),
              ),
            ),



            if((widget.bankOffers?.offerDesc ?? '').isNotEmpty)...[
              const SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    toggleTermsAndConditions = !toggleTermsAndConditions ;
                  });
                },
                child: SizedBox(
                  width: context.getScreenWidth(100),
                  child: Text('Terms & Conditions',textAlign: TextAlign.left,
                    style: context.textThemeDecoration.paragraphLarge.copyWith(
                      color: context.colorPalette.accentColor,
                      decoration: TextDecoration.underline,),

                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                  visible: errorMessage == null ? false :true,
                  child: SizedBox(
                      width: context.getScreenWidth(100),
                      child: Text(widget.bankOffers?.offerDesc ?? '', style: context.textThemeDecoration.subTitleSmall,)
                  )
              )
            ]

          ]),
    );
  }

  Widget handelApplyOffers({required OfferType offerType}) {

      if (removeOffer) {
        return CustomButton(
          height: context.getScreenHeight(5),
          backgroundColor: context.colorPalette.errorColor,
          textColor: context.colorPalette.whiteColor,
          disabledBackgroundColor: context.colorPalette.disabledErrorButtonColor,
          text: removeOfferButtonLoading ? 'Loading...' : 'Remove',
          isDisabled: removeOfferButtonLoading ? true : false,
          onTap: () {
            setState(() {
              errorMessage = null;
              removeOfferButtonLoading = true;
            });
            context.read<OffersBloc>().add(RemoveAppliedBankOffersEvent(
                onFailure: (AppException error) {
                  setState(() {
                     removeOfferButtonLoading = false;
                     errorMessage = error.message;
                  });
                },
                onSuccess: () {
                  setState(() {
                    removeOffer = false;
                    removeOfferButtonLoading = false;
                    successMessage = null;
                  });
                  return widget.bankOffers!;
                }));
          },
          width: context.getScreenWidth(100),
        );
      } else {
        return CustomButton(
          height: context.getScreenHeight(5),
          backgroundColor: context.colorPalette.accentColor,
          text: appliedOfferButtonLoading ? 'Loading...' : 'Apply',
          isDisabled: appliedOfferButtonLoading ? true : false,
          textColor: context.colorPalette.darkGreyColor,
          onTap: () {
            setState(() {
              appliedOfferButtonLoading = true;
              errorMessage = null ;
              successMessage = null;
            });

            if(offerType ==OfferType.BANK_OFFER ){
              applyBankOffers();
            }else {
              applyNormalOffers();
            }

          },
          width: context.getScreenWidth(100),
        );
      }
  }

  void applyBankOffers(){
    context.read<OffersBloc>().add(ValidateBankOffersEvent(
      data: {
        "cardNumber": cardNumber.text.toString().trim(),
        "ticketTypeCode": widget.bankOffers?.vistaTicketTypeCode ?? ''
      },
      onFailure: (AppException error) {
        setState(() {
          appliedOfferButtonLoading = false  ;
        });
        if (error.errorCode == ErrorCode.INVALID_DATA_ERROE) {
          errorMessage = '\u2022 ${error.message}' ;
        } else {
          errorMessage = '\u2022 ${error.message}' ;
        }
      },
      onSuccess: () {
        context.read<OffersBloc>().add(ApplyBankOffersEvent(
          data: {
            "reservationId": widget.offerState.reservationId,
            "type": widget.offerType.value,
            "ticketTypeCode":widget.bankOffers?.vistaTicketTypeCode ?? ''
          },
          onFailure: (AppException error) {
            setState(() {
              appliedOfferButtonLoading = false  ;
              errorMessage = '\u2022 ${error.message}' ;
            });
          },
          onSuccess: () {
            setState(() {
              removeOffer = true;
              appliedOfferButtonLoading = false;
              errorMessage = null ;
              successMessage = 'Congratulations you got discount of QAR ${priceConverter(context.read<OffersBloc>().state.discountPrice!)} 🎉';
            });
            return widget.bankOffers!;
          },
        ),
        );
      },
    ));

  }

  void applyNormalOffers(){
            context.read<OffersBloc>().add(ApplyBankOffersEvent(data: {
              "reservationId": widget.offerState.reservationId,
              "type":widget.offerType.value,
              "ticketTypeCode" : widget.bankOffers?.vistaTicketTypeCode ?? ''
            }, onFailure: (AppException error) {
              setState(() {
                appliedOfferButtonLoading = false  ;
              });
              if(error.errorCode == ErrorCode.INVALID_DATA_ERROE){
                errorMessage = '\u2022 ${error.message}' ;
              }else {
                errorMessage = '\u2022 ${error.message}' ;
              }
            }, onSuccess: (){
              setState(() {
                removeOffer = true;
                appliedOfferButtonLoading = false;
                errorMessage = null ;
                successMessage = 'Congratulations you got discount of QAR ${priceConverter(context.read<OffersBloc>().state.discountPrice!)} 🎉';
              });

              return widget.bankOffers!;
            }));

  }




}
