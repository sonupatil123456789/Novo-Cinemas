import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/core/utils/CurrencyFormater.dart';
import '../../../../components/CustomButton.dart';
import '../../../../components/cards/FAndBCard.dart';
import '../../../../core/constants/ImageConstants.dart';
import '../../../../core/theams/TextTheamStyle.dart';
import '../../../../core/utils/ListnerUtils.dart';
import '../../domain/models/ConcessionItemModel.dart';
import '../bloc/F&BBloc.dart';
import 'IncDecCounter.dart';
import 'ModifierItemCard.dart';

class FAndBPopupModel extends StatefulWidget {
  ConcessionItemModel fAndBItem;

  FAndBPopupModel({
    super.key,
    required this.fAndBItem,
  });

  @override
  State<FAndBPopupModel> createState() => _FAndBPopupModelState();
}

class _FAndBPopupModelState extends State<FAndBPopupModel> {
  final BorderRadius borderRadius = BorderRadius.circular(12);

  Map<String, dynamic> _selectedModifierItems = {};
  List<Map<String, dynamic>> _concession = [];
  num totalPrice = 0;
  int mainItemCount = 1;
  bool selectMinimumModifier = false;

  @override
  void initState() {
    totalPrice = widget.fAndBItem.priceInCents ?? 0;
    super.initState();
  }



  @override
  Widget build(BuildContext context) {


    print('Set state runned wiedget rebuilde');


    return Container(
      height: context.getScreenHeight(90),
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
      color: context.colorPalette.backGroundColor,
      child: Column(
        children: [
          SizedBox(
            height: context.getScreenHeight(28),
            width: context.getScreenWidth(100),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: borderRadius,
                  child: CachedNetworkImage(
                    imageUrl: widget.fAndBItem.concessionImageUrl ?? '',
                    height: context.getScreenHeight(20),
                    width: context.getScreenWidth(100),
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Image.asset(
                      ImageConstants.fallBackImage,
                      height: context.getScreenHeight(18),
                      width: context.getScreenWidth(100),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.fAndBItem.concessionItemName ?? '',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: context.textThemeDecoration.subTitleLarge),
                        Text(widget.fAndBItem.itemClassCode ?? '',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: context.textThemeDecoration.paragraphLarge.copyWith(
                                color: context.isDarkMode
                                    ? context.colorPalette.lightGreyColor
                                    : context.colorPalette.darkGreyColor)),
                      ],
                    ),
                    SizedBox(
                      child: Text(
                          "${currencyCode()} ${priceConverter(widget.fAndBItem.priceInCents ?? 0)}",
                          style: context.textThemeDecoration.subTitleLarge.copyWith(
                              color: context.isDarkMode
                                  ? context.colorPalette.accentColor
                                  : context.colorPalette.blackColor)),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.fAndBItem.modifierGroups?.length,
              itemBuilder: (BuildContext context, int index) {
                final modifierGroup = widget.fAndBItem.modifierGroups?[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: modifierGroup?.description ?? '',
                              style: context.textThemeDecoration.subTitleLarge.copyWith(fontFamily: TextThemeDecoration.HamburgerFont, fontSize: 14)),
                          const TextSpan(text: "  "),
                          TextSpan(
                              text: 'Select [ ${modifierGroup?.minimumQuantity.toString()} - ${modifierGroup?.maximumQuantity.toString()} ]',
                              style: context.textThemeDecoration.paragraphMedium.copyWith( color: context.isDarkMode? context.colorPalette.lightGreyColor : context.colorPalette.darkGreyColor)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: modifierGroup?.modifierItems?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        final modifierItem = modifierGroup?.modifierItems?[index];
                        return ModifierItemCard(
                          key: ValueKey(modifierItem!.vistaModifierId),
                          modifierItem: modifierItem!,
                          onClickMinus: (Map<String, dynamic> selectedItem, num price) {
                            setState(() {
                              totalPrice = totalPrice - (price * mainItemCount);
                              _updateSelectedModifierItems(
                                  selectedItem,
                                  modifierGroup?.maximumQuantity ?? 0,
                                  modifierGroup?.minimumQuantity ?? 0);
                            });
                          },
                          disabledAddButton: _disableOnClick(
                              existingData: _selectedModifierItems,
                              groupId: modifierGroup?.vistaModifierGroupId ?? ''),
                          onClickPlus: (Map<String, dynamic> selectedItem, num price) {
                            setState(() {
                              selectMinimumModifier = false;
                              totalPrice = totalPrice + (price * mainItemCount);
                              _updateSelectedModifierItems(
                                  selectedItem,
                                  modifierGroup?.maximumQuantity ?? 0,
                                  modifierGroup?.minimumQuantity ?? 0);
                            });
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 4,
                        );
                      },
                    ),
                    // minQtyPrompt(modifierGroup, modifierGroup?.minimumQuantity),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                );
              },
            ),
          ),
          if (selectMinimumModifier)Text("Please Select Modifier",style: context.textThemeDecoration.subTitleMedium.copyWith(color: context.colorPalette.error)),
          SizedBox(
            height: context.getScreenHeight(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: context.getScreenWidth(40),
                  height: context.getScreenHeight(6),
                  alignment: Alignment.center,

                  child: IncDecCounter(
                    disabledAddButton: false,
                    onClickPlus: (int value) {
                      addMainFAndBItem();
                    },
                    initialCount: mainItemCount,
                    onClickMinus: (int value) {
                      removeMainFAndBItem();
                    },
                    disabledRemoveButton: false,
                    // disabledRemoveButton: mainItemCount >= 1 ? false :true,
                  ),
                ),


                CustomButton(
                  height: context.getScreenHeight(6),
                  backgroundColor: context.colorPalette.accentColor,
                  text: '${currencyCode()} ${priceConverter(totalPrice)}',
                  textColor: context.colorPalette.darkGreyColor,
                  onTap: () {
                    _checkMinQty(existingData: _selectedModifierItems);
                    totalItem();
                  },
                  width: context.getScreenWidth(40),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void addMainFAndBItem() {
    setState(() {
      double perItem = totalPrice / mainItemCount;
      totalPrice = totalPrice + perItem;
      mainItemCount = ++mainItemCount;
    });

    print('mainItemCount ${mainItemCount}  totalPrice $totalPrice');
  }

  void removeMainFAndBItem() {
    setState(() {
      double perItem = totalPrice / mainItemCount;
      mainItemCount = --mainItemCount;
      totalPrice = totalPrice - perItem;
      if(mainItemCount == 0){
        Navigator.pop(context);
      }
    });
    print('mainItemCount ${mainItemCount}  totalPrice $totalPrice');
  }

  void totalItem() {
    if (!selectMinimumModifier) {
      final Map<String,dynamic> concession = {
        "Id": widget.fAndBItem.vistaConcessionId,
        "Quantity": mainItemCount,
        "Price": widget.fAndBItem.priceInCents,
        "Name": widget.fAndBItem.concessionItemName,
        "HeadOfficeItemCode": widget.fAndBItem.headOfficeItemCode,
        'Modifiers': _selectedModifierItems.values
            .map((toElement) => toElement['listData'])
            .expand((combine) => combine)
            .toList()
      };
      _concession.add(concession);
      Navigator.pop(context,concession);
    }
  }


  void _updateSelectedModifierItems( Map<String, dynamic> selectedItems, int maxTotalQuantity, int minTotalQuantity) {
    // Create a mutable copy of the current selectedModifierItems
    final updatedSelectedModifierItems = Map<String, dynamic>.from(_selectedModifierItems ?? {});

    if (updatedSelectedModifierItems.containsKey(selectedItems['ModifierGroupId'])) {
      final currentList = List<Map<String, dynamic>>.from(
          updatedSelectedModifierItems[selectedItems['ModifierGroupId']]['listData']);

      // Remove existing item with the same ModifierItemId
      final remainingItemsList = currentList
          .where((item) => item['ModifierItemId'] != selectedItems['ModifierItemId'])
          .toList();

      // Add new item and filter out items with zero quantity
      final updatedList =[...remainingItemsList, selectedItems].where((item) => item['Quantity'] != 0).toList();

      // Update the nested map
      updatedSelectedModifierItems[selectedItems['ModifierGroupId']] = {
        'maxQty': updatedSelectedModifierItems[selectedItems['ModifierGroupId']]['maxQty'] ??maxTotalQuantity,
        'minQty': minTotalQuantity,
        'listData': updatedList
      };

      // Update the entire selectedModifierItems
      _selectedModifierItems = updatedSelectedModifierItems;
    } else {
      // If the key doesn't exist, create a new entry
      updatedSelectedModifierItems[selectedItems['ModifierGroupId']] = {
        'maxQty': maxTotalQuantity,
        'minQty': minTotalQuantity,
        'listData': [selectedItems]
      };

      // Update the entire selectedModifierItems
      _selectedModifierItems = updatedSelectedModifierItems;
    }
  }

  bool _disableOnClick({required Map<String, dynamic> existingData, required String groupId}) {
    // checking if ke exhist
    if (existingData.containsKey(groupId)) {
      // getting total quantity by adding quantity of every map item
      int currentTotalQuantity = (existingData[groupId]['listData'] as List<Map<String, dynamic>>)
          .fold(0, (total, item) => total + (item['Quantity'] as int? ?? 0));
      if (existingData[groupId]['maxQty'] as int == currentTotalQuantity) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  void _checkMinQty({required Map<String, dynamic> existingData}) {
    if (widget.fAndBItem.modifierGroups != null) {
      for (var modifier in widget.fAndBItem.modifierGroups!) {
        if (modifier.minimumQuantity! > 0) {
          if (existingData.containsKey(modifier.vistaModifierGroupId)) {
            // getting total quantity by adding quantity of every map item
            int currentTotalQuantity = (existingData[modifier.vistaModifierGroupId]['listData']
                    as List<Map<String, dynamic>>)
                .fold(0, (total, item) => total + (item['Quantity'] as int? ?? 0));
            if (existingData[modifier.vistaModifierGroupId]['minQty'] as int >
                currentTotalQuantity) {
              setState(() {
                selectMinimumModifier = true;
              });
            }
          } else {
            setState(() {
              selectMinimumModifier = true;
            });
          }
        }
      }
    }
  }
}
