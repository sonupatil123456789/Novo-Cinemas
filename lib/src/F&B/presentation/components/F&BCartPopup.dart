import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/core/utils/CurrencyFormater.dart';
import 'package:novocinema/src/F&B/presentation/bloc/F&BBloc.dart';
import 'IncDecCounter.dart';

class FnBCartPopup extends StatelessWidget {
  const FnBCartPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final border = BorderSide(
        color: context.colorPalette.reverseBackGroundColor.withOpacity(0.4),
        width: 0.5);

    return Container(
      width: context.getScreenWidth(100),
      color: context.colorPalette.backGroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: context.getScreenHeight(2)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Your order summary",
                  overflow: TextOverflow.ellipsis,
                  style: context.textThemeDecoration.titleLarge,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      width: context.getScreenWidth(9),
                      height: context.getScreenWidth(9),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: context.colorPalette.accentColor,
                      ),
                      child: Icon(
                        Icons.close,
                        size: context.getScreenWidth(5),
                        color: context.colorPalette.backGroundColor,
                      )),
                )
              ],
            ),
            SizedBox(height: context.getScreenHeight(4)),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: context.colorPalette.reverseBackGroundColor
                            .withOpacity(0.4),
                        width: 0.5)),
                child: BlocBuilder<FAndBBloc, FAndBState>(
                  buildWhen: (previous, current) => previous.addConcessionItemList !=current.addConcessionItemList,
                  builder: (context, cartState) {
              
                    if(cartState.addConcessionItemList.isEmpty){
                      Navigator.pop(context);
                    }
              
              
                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: cartState.addConcessionItemList.length,
                      itemBuilder: (context, index) {
                        return cartItemCard(context, cartState.addConcessionItemList[index]);
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(); // This adds a Divider between items
                      },
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: context.getScreenHeight(5)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("TOTAL PRICE",
                      style: context.textThemeDecoration.subTitleLarge),
                  BlocBuilder<FAndBBloc, FAndBState>(
                    builder: (context, state) {
                      return Text(
                          "${currencyCode()} ${priceConverter(getTotalAmount(state.addConcessionItemList ?? []))}",
                          style: context.textThemeDecoration.subTitleLarge
                              .copyWith(
                                  color: context.isDarkMode
                                      ? context.colorPalette.accentColor
                                      : context.colorPalette.blackColor));
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: context.getScreenHeight(5)),
          ],
        ),
      ),
    );
  }
}

Widget cartItemCard(BuildContext context, item) {
  return Container(
    width: context.getScreenWidth(76),
    padding: const EdgeInsets.only(top: 10, left: 10,right: 10,),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // First Column: Name and Modifiers list
        Expanded(
          flex: 2,
          child: ColoredBox(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item['Name'] ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: context.textThemeDecoration.subTitleSmall,
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: (item['Modifiers'] ?? []).length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        "• ${item['Modifiers'][index]['SubItemName']}",
                        overflow: TextOverflow.ellipsis,
                        style: context.textThemeDecoration.paragraphMedium,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),

        // Second Column: Counter and Price
        Container(
          // color: Colors.amberAccent,
          width: context.getScreenWidth(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IncDecCounter(
                fontSize: context.getScreenWidth(4),
                disabledAddButton: false,
                width: 22,
                initialCount: item['Quantity'] ?? 0,
                onClickPlus: (int plus) {
                  context.read<FAndBBloc>().add(
                    IncrementDecrementConcessionItemEvent(
                      concession: item,
                      isIncrement: true,
                    ),
                  );
                },
                onClickMinus: (int minus) {
                  context.read<FAndBBloc>().add(
                    IncrementDecrementConcessionItemEvent(
                      concession: item,
                      isIncrement: false,
                    ),
                  );
                },
                // disabledRemoveButton: item['Quantity'] == 1,
                disabledRemoveButton: false
              ),
              const SizedBox(height: 8),
              Text(
                "${currencyCode()} ${priceConverter(item['Price'] ?? 0)}",
                style: context.textThemeDecoration.subTitleMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        // Third Column: Delete Button
        SizedBox(
          width: context.getScreenWidth(10),
          child: IconButton(
            onPressed: () {
              context.read<FAndBBloc>().add(RemoveConcessionItemEvent(item));
            },
            icon: Icon(
              Icons.delete_outline,
              color: Colors.red,
              size: context.getScreenWidth(6),
            ),
          ),
        ),
      ],
    ),
  );
}

// Widget cartItemCard(
//     BuildContext context,
//     item,
//     ) {
//   return Container(
//     width: context.getScreenWidth(76),
//     padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
//     child: Column(
//       children: [
//         SizedBox(
//           height: context.getScreenHeight(5),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Expanded(
//                 child: Text(
//                   item['Name'] ?? '',
//                   overflow: TextOverflow.ellipsis,
//                   style: context.textThemeDecoration.subTitleSmall,
//                 ),
//               ),
//               SizedBox(
//                 width: context.getScreenWidth(5),
//               ),
//               IncDecCounter(
//                 fontSize: context.getScreenWidth(4),
//                 disabledAddButton: false,
//                 width: 22,
//                 initialCount: item['Quantity'] ?? 0,
//                 onClickPlus: (int plus) {
//                   context.read<FAndBBloc>().add(
//                       IncrementDecrementConcessionItemEvent(
//                           concession: item, isIncrement: true));
//                 },
//                 onClickMinus: (int minus) {
//                   context.read<FAndBBloc>().add(
//                       IncrementDecrementConcessionItemEvent(
//                           concession: item, isIncrement: false));
//                 },
//                 disabledRemoveButton: item['Quantity'] == 1 ? true : false,
//               )
//             ],
//           ),
//         ),
//         const SizedBox(height: 8,),
//         Container(
//           // color: Colors.greenAccent,
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Expanded(
//                 child: ListView(
//                   shrinkWrap: true,
//                   children: List.generate((item['Modifiers'] ?? []).length, (index) {
//                     return Text(
//                       item['Modifiers'][index]['SubItemName'],
//                       overflow: TextOverflow.ellipsis,
//                       style: context.textThemeDecoration.paragraphMedium,
//                     );
//                   }),
//                 ),
//               ),
//               SizedBox(
//                 width: context.getScreenWidth(1),
//               ),
//               Container(
//                   alignment: Alignment.center,
//                   width: context.getScreenWidth(25),
//                   child: Text(
//                       "${currencyCode()} ${priceConverter(item['Price'] ?? 0)}",
//                       style: context.textThemeDecoration.subTitleMedium
//                           .copyWith()))
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }

// Widget cartItemCard(
//   BuildContext context,
//   item,
// ) {
//   return Row(
//     children: [
//       Container(
//         width: context.getScreenWidth(76),
//         padding: const EdgeInsets.only(right: 10, left: 10, top: 2, bottom: 10),
//         child: Column(
//           children: [
//             SizedBox(
//               height: context.getScreenHeight(5),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       item['Name'] ?? '',
//                       overflow: TextOverflow.ellipsis,
//                       style: context.textThemeDecoration.subTitleSmall,
//                     ),
//                   ),
//                   SizedBox(
//                     width: context.getScreenWidth(5),
//                   ),
//                   IncDecCounter(
//                     fontSize: 5,
//                     iconSize: 5,
//                     disabledAddButton: false,
//                     initialCount: item['Quantity'] ?? 0,
//                     onClickPlus: (int plus) {
//                       context.read<FAndBBloc>().add(
//                           IncrementDecrementConcessionItemEvent(
//                               concession: item, isIncrement: true));
//                     },
//                     onClickMinus: (int minus) {
//                       context.read<FAndBBloc>().add(
//                           IncrementDecrementConcessionItemEvent(
//                               concession: item, isIncrement: false));
//                     },
//                     disabledRemoveButton: item['Quantity'] == 1 ? true : false,
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(height: 8,),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Expanded(
//                   child: ListView(
//                     shrinkWrap: true,
//                     children: List.generate((item['Modifiers'] ?? []).length, (index) {
//                       return Text(
//                         item['Modifiers'][index]['SubItemName'],
//                         overflow: TextOverflow.ellipsis,
//                         style: context.textThemeDecoration.paragraphMedium,
//                       );
//                     }),
//                   ),
//                 ),
//                 SizedBox(
//                   width: context.getScreenWidth(1),
//                 ),
//                 Container(
//                     alignment: Alignment.center,
//                     width: context.getScreenWidth(25),
//                     child: Text(
//                         "${currencyCode()} ${priceConverter(item['Price'] ?? 0)}",
//                         style: context.textThemeDecoration.subTitleMedium
//                             .copyWith()))
//               ],
//             ),
//           ],
//         ),
//       ),
//       GestureDetector(
//         onTap: () {
//           context.read<FAndBBloc>().add(RemoveConcessionItemEvent(item));
//         },
//         child: Container(
//           alignment: Alignment.center,
//           // color:Colors.amberAccent,
//           child: Icon(
//             Icons.delete,
//             size: context.getScreenWidth(6),
//           ),
//         ),
//       )
//     ],
//   );
// }

double calculateItemPrice(Map<String, dynamic> concessionItem) {
  var totalPrice = concessionItem['Quantity'] * concessionItem['Price'];

  totalPrice += concessionItem['Modifiers'].fold(0.0,
      (sum, item) => sum + item['SubItemPrice'] * concessionItem['Quantity']);
  return double.parse(totalPrice.toString());
}

double getTotalAmount(List<Map<String, dynamic>> items) {
  double total = 0.0;
  for (var item in items) {
    total += calculateItemPrice(item);
  }
  return total;
}
