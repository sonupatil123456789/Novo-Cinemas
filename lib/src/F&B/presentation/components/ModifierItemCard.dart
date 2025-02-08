import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/core/utils/CurrencyFormater.dart';
import 'package:novocinema/src/F&B/domain/models/ModifierItemModel.dart';


class ModifierItemCard extends StatefulWidget {
  ModifierItemModel modifierItem;
  bool disabledAddButton;
  final Function(Map<String, dynamic>, num) onClickPlus;
  final Function(Map<String, dynamic> , num ) onClickMinus;
  // bool resetCounter;

  ModifierItemCard(
      {super.key,
      required this.modifierItem,
      required this.onClickPlus,
      required this.onClickMinus,
      required this.disabledAddButton,
        // this.resetCounter = false
      });

  @override
  State<ModifierItemCard> createState() => _ModifierItemCardState();
}

class _ModifierItemCardState extends State<ModifierItemCard> {

  final BorderRadius borderRadius = BorderRadius.circular(12);
  int _counter = 0;
  // int finalPrice = 0;

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return SizedBox(
        // color: Colors.amber,
        height: context.getScreenHeight(5),
        child: Row(
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: widget.modifierItem.modifierItemName ?? "",
                      style: context.textThemeDecoration.paragraphLarge.copyWith()),
                  const TextSpan(text: "  "),
                  TextSpan(
                      text:
                      "[ ${widget.modifierItem.priceInCents != null ? price(widget.modifierItem.priceInCents!) : ''} ]",
                      style: context.textThemeDecoration.paragraphLarge
                          .copyWith(color: context.colorPalette.accentColor)),
                ],
              ),
            ),
            const Spacer(),
            Container(
              alignment : Alignment.center ,
              height: context.getScreenWidth(9),
              width: context.getScreenWidth(22),
              decoration: BoxDecoration(
                  color: context.colorPalette.accentColor.withOpacity(0.15),
                  borderRadius: borderRadius,
                border: Border.all(color: context.colorPalette.accentColor)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: IgnorePointer(
                      ignoring: _counter == 0 ? true:false,
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (_counter > 0) {
                                _counter--;
                              }
                              Map<String, dynamic> modifierItemData = {
                                "ModifierItemId":widget.modifierItem.vistaModifierId,
                                "SubItemName":widget.modifierItem.modifierItemName,
                                "SubItemPrice":widget.modifierItem.priceInCents,
                                "Quantity": _counter,
                                "ModifierGroupId":widget.modifierItem.fkModifierGroupId
                              };
                              widget.onClickMinus(modifierItemData, widget.modifierItem.priceInCents??0);
                            });
                          },
                          child: Container(
                            height: context.getScreenWidth(9),
                            decoration: BoxDecoration(
                              borderRadius: borderRadius,
                            ),
                            child: Icon(
                              Icons.remove,
                              color: _counter == 0 ? context.colorPalette.reverseBackGroundColor.withOpacity(0.2) :context.colorPalette.reverseBackGroundColor,
                              size: context.getScreenWidth(4),
                            ),
                          )),
                    ),
                  ),
                  Text(
                      '${_counter}',
                      style: context.textThemeDecoration.subTitleLarge.copyWith(
                          color: context.colorPalette.textColor
                      )
                  ),
                  Expanded(
                    child: IgnorePointer(
                      ignoring: widget.disabledAddButton,
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                                _counter++;
                              Map<String, dynamic> modifierItemData = {
                                "ModifierItemId":widget.modifierItem.vistaModifierId,
                                "Quantity": _counter,
                                "SubItemName":widget.modifierItem.modifierItemName,
                                "SubItemPrice":widget.modifierItem.priceInCents,
                                "ModifierGroupId":widget.modifierItem.fkModifierGroupId
                              };

                              widget.onClickPlus(modifierItemData,widget.modifierItem.priceInCents??0);
                            });
                          },
                          child: Container(
                            height: context.getScreenWidth(9),
                            decoration: BoxDecoration(
                              borderRadius:borderRadius ,
                            ),
                            child: Icon(
                              Icons.add,
                              size: context.getScreenWidth(4),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
    );
  }

  String price(int centsPrice) {
    String fnbPrice = '';

    if(centsPrice > 0 ){
      fnbPrice = '${currencyCode()} ${priceConverter(centsPrice).toString()}';
    }else{
      fnbPrice = 'Free';
    }
    return fnbPrice;
  }
}
