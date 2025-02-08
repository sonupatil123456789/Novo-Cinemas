import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/core/utils/CurrencyFormater.dart';
import 'package:novocinema/src/F&B/presentation/components/SIngleItemCartPopup.dart';
import '../../core/constants/ImageConstants.dart';
import '../../src/F&B/domain/models/ConcessionItemModel.dart';
import '../../src/F&B/presentation/bloc/F&BBloc.dart';
import '../../src/F&B/presentation/components/F&BDetailsPopupModel.dart';
import '../../src/F&B/presentation/components/IncDecCounter.dart';
import '../CustomButton.dart';

class FAndBCard extends StatelessWidget {
  ConcessionItemModel fAndBItem;
  FAndBState fAndBState;
  num quantity;
  // void Function(BuildContext context, MovieModel movie) onPressEvent;

  FAndBCard(
      {super.key,
      required this.fAndBItem,
      required this.fAndBState,
      required this.quantity});

  final BorderRadius borderRadius = BorderRadius.circular(12);

  // num quantity = 0;

  Map<String, dynamic> concession = {};

  @override
  Widget build(BuildContext context) {


    final cardWidth = context.getScreenWidth(42.2);
    final cardHeight = context.getScreenHeight(32);

    return SizedBox(
      height: cardHeight,
      width: cardWidth,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: borderRadius,
            child: CachedNetworkImage(
              imageUrl: fAndBItem.concessionImageUrl ?? '',
              height: cardWidth,
              width: cardWidth,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Image.asset(
                ImageConstants.fallBackFnb,
                height: cardHeight,
                width: cardWidth,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              width: cardWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Text(fAndBItem.concessionItemName ?? '',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: context.textThemeDecoration.subTitleMedium),
                  Text(fAndBItem.itemClassCode ?? '',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: context.textThemeDecoration.paragraphLarge
                          .copyWith(
                              color: context.isDarkMode
                                  ? context.colorPalette.lightGreyColor
                                  : context.colorPalette.darkGreyColor)),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text('${currencyCode()} ${fAndBItem.priceInCents! / 100}',
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              style: context.textThemeDecoration.subTitleMedium.copyWith(color: context.isDarkMode ? context.colorPalette.accentColor   : context.colorPalette.blackColor)),
                        ),
                      ),
                      if (quantity > 0) ...[
                        IncDecCounter(
                          fontSize: context.getScreenWidth(4),
                          disabledAddButton: false,
                          width: 20,
                          height: 8,
                          initialCount: quantity.toInt(),
                          onClickPlus: (int plus) {

                            concession = {
                              "Id": fAndBItem.vistaConcessionId,
                              "Quantity": 1,
                              "Price": fAndBItem.priceInCents,
                              "Name": fAndBItem.concessionItemName,
                              "HeadOfficeItemCode":
                              fAndBItem.headOfficeItemCode,
                              'Modifiers': []
                            };

                            if (fAndBItem.modifierGroups!.isNotEmpty) {
                              showModalBottomSheet<void>(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return SingleItemCartPopup(
                                    groupId: fAndBItem.vistaConcessionId!,
                                  );
                                },
                              );
                            } else {
                              context.read<FAndBBloc>().add(IncrementDecrementConcessionItemEvent( concession: concession,isIncrement: true));
                            }




                            // concession = {
                            //   "Id": fAndBItem.vistaConcessionId,
                            //   "Quantity": 0,
                            //   "Price": fAndBItem.priceInCents,
                            //   "Name": fAndBItem.concessionItemName,
                            //   "HeadOfficeItemCode":fAndBItem.headOfficeItemCode,
                            //   'Modifiers': []
                            // };
                            //
                            // if (fAndBItem.modifierGroups!.isNotEmpty) {
                            //   final cartItemLength = fAndBState.addConcessionItemList.where((where) =>fAndBItem.vistaConcessionId== where['Id']).toList();
                            //
                            //   // print(cartItemLength);
                            //
                            //   if(cartItemLength.length > 1){
                            //     showModalBottomSheet<void>(
                            //       context: context,
                            //       isScrollControlled: true,
                            //       builder: (BuildContext context) {
                            //         return SingleItemCartPopup(
                            //           groupId: fAndBItem.vistaConcessionId!,
                            //         );
                            //       },
                            //     );
                            //   }else{
                            //     context.read<FAndBBloc>().add(IncrementDecrementConcessionItemEvent(concession: cartItemLength.first,isIncrement: true));
                            //   }
                            //
                            // } else {
                            //   context.read<FAndBBloc>().add(IncrementDecrementConcessionItemEvent(concession: concession,isIncrement: true));
                            // }
                          },
                          onClickMinus: (int minus) {

                            print(minus);


                            concession = {
                              "Id": fAndBItem.vistaConcessionId,
                              "Quantity": 0,
                              "Price": fAndBItem.priceInCents,
                              "Name": fAndBItem.concessionItemName,
                              "HeadOfficeItemCode":fAndBItem.headOfficeItemCode,
                              'Modifiers': []
                            };

                            if (fAndBItem.modifierGroups!.isNotEmpty) {
                              final cartItemLength = fAndBState.addConcessionItemList.where((where) =>fAndBItem.vistaConcessionId== where['Id']).toList();

                              // print(cartItemLength);

                              if(cartItemLength.length > 1){
                                showModalBottomSheet<void>(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return SingleItemCartPopup(
                                      groupId: fAndBItem.vistaConcessionId!,
                                    );
                                  },
                                );
                              }else{
                                context.read<FAndBBloc>().add(IncrementDecrementConcessionItemEvent(concession: cartItemLength.first,isIncrement: false));
                              }

                            } else {
                              context.read<FAndBBloc>().add(IncrementDecrementConcessionItemEvent(concession: concession,isIncrement: false));
                            }
                          },
                          disabledRemoveButton:  false,
                          // disabledRemoveButton: quantity == 1 ? true : false,
                        ),
                      ] else ...[
                        CustomButton(
                          height: context.getScreenHeight(4),
                          backgroundColor:
                              context.colorPalette.transparentColor,
                          text: quantity > 0 ? quantity.toString() : 'Add',
                          textColor: context.colorPalette.accentColor,
                          onTap: () async {
                            if (fAndBItem.modifierGroups!.isNotEmpty) {
                              final value = await showModalBottomSheet<Map<String, dynamic>>(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return FAndBPopupModel(fAndBItem: fAndBItem);
                                },
                              );

                              if (value != null) {
                                concession = value;
                                context.read<FAndBBloc>().add(AddConcessionItemWithPriceEvent(
                                    addConcession: concession,
                                    price: fAndBItem.priceInCents!,
                                    onItemAdded: (getConcession) {}));
                              }
                            } else {
                              concession = {
                                "Id": fAndBItem.vistaConcessionId,
                                "Quantity": 1,
                                "Price": fAndBItem.priceInCents,
                                "Name": fAndBItem.concessionItemName,
                                "HeadOfficeItemCode":
                                    fAndBItem.headOfficeItemCode,
                                'Modifiers': []
                              };

                              context.read<FAndBBloc>().add(AddConcessionItemWithPriceEvent(
                                  addConcession: concession,
                                  price: fAndBItem.priceInCents!,
                                  onItemAdded: (getConcession) {}));
                            }

                          },
                          borderColor: Border.all(
                              color: context.colorPalette.accentColor,
                              width: 0.5),
                          width: context.getScreenWidth(20),
                        ),
                      ]
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

num getTotalQuantityForId(List<Map<String, dynamic>> items, vistaConcessionId) {
  return items
      .where((item) => item['Id'] == vistaConcessionId)
      .fold<num>(0, (sum, item) => sum + item['Quantity']);
}

// Map data = {
//   "reservationId": "ABCD12345",
//   "cinemaId": "30",
//   "sessionId": "345319",
//   "LinkedBookingId": "LK12345678",
//   "Concessions": [
//     {
//       "Id": "CON12345",
//       "Quantity": 2,
//       "HeadOfficeItemCode": "HO5678",
//       "Modifiers": [
//         {"ModifierItemId": "2510", "Quantity": 1, "ModifierGroupId": "2514"}
//       ],
//
//     }
//   ]
// };
