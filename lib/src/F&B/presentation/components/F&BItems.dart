import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/core/theams/Utils.dart';

import '../../../../components/cards/FAndBCard.dart';
import '../../../../components/chips/CustomChoiceChips.dart';
import '../../../../components/shimmerloaders/FAndBListShimmer.dart';
import '../../../../core/resources/enums.dart';
import '../../../../components/chips/CustomChip.dart';
import '../../domain/models/ConcessionCategoryModel.dart';
import '../bloc/F&BBloc.dart';

class FnBItems extends StatefulWidget {
  final String cinemaId;

  const FnBItems({super.key, required this.cinemaId});

  @override
  State<FnBItems> createState() => _FnBItemsState();
}

class _FnBItemsState extends State<FnBItems> {

  @override
  void initState() {
    context.read<FAndBBloc>().add(GetAllFoodAndBevRageEvent(widget.cinemaId));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [


        BlocBuilder<FAndBBloc, FAndBState>(
          builder: (context, fAndBState) {
            if (fAndBState.loading == CurrentAppState.SUCCESS) {

              return    SizedBox(
                  height: context.getScreenHeight(5),
                  child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      final tabsData =  fAndBState.fAndBDataList
                          .where((test) => test.concessionItems!.isNotEmpty)
                          .map((toElement) =>
                          ChoiceChipData<ConcessionCategoryModel>((toElement.vistaConcessionCategoryId as num),toElement.name!,toElement)) .toList()[index];


                      return CustomChip<ConcessionCategoryModel>(
                        data: tabsData,
                        selectedDate: fAndBState.selectedChoiceChipData! ,
                        onPressEvent: (ChoiceChipData<ConcessionCategoryModel> selectedData) {
                          context.read<FAndBBloc>().add(SelectedFAndBCategoryEvent(selectedData));

                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(width: 12,);
                    }, itemCount: fAndBState.fAndBDataList
                      .where((test) => test.concessionItems!.isNotEmpty).length,
                    scrollDirection: Axis.horizontal,
                  )
              );



              return CustomChoiceChips(
                borderColor: context.isDarkMode
                    ? context.colorPalette.accentColor
                    : context.colorPalette.darkGreyColor,
                bgColor: context.colorPalette.backGroundColor,
                selectColor: context.colorPalette.accentColor,
                selectItem: fAndBState.selectedChoiceChipData,
                checkColor: context.colorPalette.darkGreyColor,
                borderRadius: 8,
                textColor: context.colorPalette.darkGreyColor,
                selectedDataOnTap:(ChoiceChipData<ConcessionCategoryModel> selectedData) {
                  context.read<FAndBBloc>().add(SelectedFAndBCategoryEvent(selectedData));
                },
                dataList: fAndBState.fAndBDataList
                    .where((test) => test.concessionItems!.isNotEmpty)
                    .map((toElement) =>
                    ChoiceChipData<ConcessionCategoryModel>(
                        (toElement.vistaConcessionCategoryId as num),
                        toElement.name!,
                        toElement))
                    .toList(),
                width: context.getScreenHeight(100),
                isWrapable: false,
                unSelectedTextColor: context.isDarkMode
                    ? context.colorPalette.accentColor
                    : context.colorPalette.darkGreyColor,
              );
            }

            if (fAndBState.loading == CurrentAppState.ERROR) {
              return const SizedBox.shrink();
            }

            return fAndBTabShimmer(context);
          },
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: BlocBuilder<FAndBBloc, FAndBState>(
            builder: (context, fAndBState) {

              if (fAndBState.loading == CurrentAppState.SUCCESS) {
                if (fAndBState.fAndBConcessionsList.isEmpty) {
                  return const Center(child: Text('No item to select'));
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        // color : Colors.amber,
                        width: context.getScreenWidth(100),
                        child: Wrap(
                          // spacing: context.getScreenWidth(5),
                          runSpacing: context.getScreenWidth(2),
                          alignment: WrapAlignment.spaceBetween,
                          children: List.generate(
                              fAndBState.fAndBConcessionsList.length,(index) {

                               final concessionData = fAndBState.fAndBConcessionsList[index];

                               final quantity = getTotalQuantityForId(
                                fAndBState.addConcessionItemList,
                                concessionData.vistaConcessionId
                                );


                                return FAndBCard(fAndBItem: concessionData, fAndBState: fAndBState, quantity: quantity,);
                              }).toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                );
              }

              if (fAndBState.loading == CurrentAppState.ERROR) {
                return Center(
                    child: Text(fAndBState.appException?.message ?? 'Some error occured'));
              }

              return FAndBListShimmer();
            },
          ),
        ),
      ],
    );
  }
}
