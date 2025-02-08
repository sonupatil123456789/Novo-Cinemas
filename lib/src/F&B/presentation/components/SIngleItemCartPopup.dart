import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/core/theams/Utils.dart';
import '../../../../components/CustomButton.dart';
import '../../../../core/utils/CurrencyFormater.dart';
import '../../domain/models/ConcessionItemModel.dart';
import '../bloc/F&BBloc.dart';
import 'F&BCartPopup.dart';
import 'F&BDetailsPopupModel.dart';


class SingleItemCartPopup extends StatelessWidget {
   final String groupId ;
   const SingleItemCartPopup({super.key , required this.groupId});

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
                      child: Icon(Icons.close, size: context.getScreenWidth(5),
                        color: context.colorPalette.backGroundColor,
                      )),
                )

              ],
            ),
            SizedBox(height: context.getScreenHeight(4)),
            Flexible(
              child: BlocBuilder<FAndBBloc, FAndBState>(
                buildWhen: (previous, current) =>
                previous.addConcessionItemList != current.addConcessionItemList,
                builder: (context, fAndBState) {
              
                  final List<Map<String,dynamic>> singleCartList = fAndBState.addConcessionItemList.where((data)=>data['Id'] == groupId).toList();
              
                  if(singleCartList.isEmpty){
                    Navigator.pop(context);
                  }
              
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: context.colorPalette.reverseBackGroundColor
                                .withOpacity(0.4), width: 0.5)
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: singleCartList.length,
                      itemBuilder: (context, index) {
                        return cartItemCard(context, singleCartList[index]);
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                        ); // This adds a Divider between items
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: context.getScreenHeight(3)),

           BlocBuilder<FAndBBloc, FAndBState>(builder: (BuildContext context, FAndBState fAndBState) {

             final List<Map<String,dynamic>> singleCartList = fAndBState.addConcessionItemList.where((data)=>data['Id'] == groupId).toList();

             if(singleCartList.isEmpty){
               return const SizedBox.shrink();
             }

             return CustomButton(
               height: context.getScreenHeight(6),
               backgroundColor: context.colorPalette.accentColor,
               text: 'Add New Item',
               textColor: context.colorPalette.darkGreyColor,
               onTap: () async {

                 final ConcessionItemModel singleCartList =
                     context.read<FAndBBloc>().state.fAndBConcessionsList.where((data)=>data.vistaConcessionId == groupId).first;

                 final value = await showModalBottomSheet< Map<String, dynamic>>(
                   context: context,
                   isScrollControlled: true,
                   builder: (BuildContext context) {
                     return FAndBPopupModel(fAndBItem: singleCartList);
                   },
                 );

                 if(value != null){
                   context.read<FAndBBloc>()
                       .add(AddConcessionItemWithPriceEvent(
                       addConcession: value,
                       price: calculateItemPrice(value),
                       onItemAdded: (getConcession) {

                       }));
                 }


               },
               width: context.getScreenWidth(100),
             );

            },),


            SizedBox(height: context.getScreenHeight(5)),
          ],
        ),
      ),
    );
  }
}