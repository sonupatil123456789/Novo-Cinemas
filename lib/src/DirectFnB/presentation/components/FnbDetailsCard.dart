import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/core/utils/CurrencyFormater.dart';
import 'package:novocinema/src/F&B/domain/models/ConcessionItemModel.dart';

import '../../../F&B/presentation/bloc/F&BBloc.dart';
import '../../../F&B/presentation/components/IncDecCounter.dart';

class FnbDetailsCard extends StatelessWidget {
  final Map<String, dynamic> concessionData;

  const FnbDetailsCard({super.key, required this.concessionData});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FAndBBloc, FAndBState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    context.language.getApiText(
                        concessionData['Name'], concessionData['Name']),
                    style: context.textThemeDecoration.subTitleMedium
                        .copyWith(fontSize: 16)),
                IncDecCounter(
                  fontSize: 5,
                  iconSize: 5,
                  disabledAddButton: false,
                  initialCount: concessionData['Quantity'],
                  onClickPlus: (int plus) {
                    context.read<FAndBBloc>().add(
                        IncrementDecrementConcessionItemEvent(
                            concession: concessionData, isIncrement: true));
                  },
                  onClickMinus: (int minus) {
                    context.read<FAndBBloc>().add(
                        IncrementDecrementConcessionItemEvent(
                            concession: concessionData, isIncrement: false));
                  },
                  disabledRemoveButton:
                      concessionData['Quantity'] == 1 ? true : false,
                )
              ],
            ),
            const SizedBox(height: 5),
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Text(
                    '${context.language.getApiText(concessionData['Modifiers'][index]['SubItemName'], concessionData['Modifiers'][index]['SubItemName'])} X ${concessionData['Modifiers'][index]['Quantity']}',
                    style: context.textThemeDecoration.subTitleMedium
                        .copyWith(fontWeight: FontWeight.w400)),
                separatorBuilder: (context, index) => const SizedBox(height: 5),
                itemCount: concessionData['Modifiers'].length),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(context.language.getText('viewDetails'),
                    style: context.textThemeDecoration.subTitleMedium.copyWith(
                        color: context.colorPalette.accentColor,
                        fontWeight: FontWeight.w400)),
                Text(
                    "${currencyCode()} ${priceConverter(concessionData['Price'])}",
                    style: context.textThemeDecoration.subTitleMedium
                        .copyWith(color: context.colorPalette.accentColor)),
              ],
            )
          ],
        );
      },
    );
  }
}
