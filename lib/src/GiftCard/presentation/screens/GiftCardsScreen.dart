import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/core/resources/enums.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/GiftCard/presentation/bloc/GiftCardBloc.dart';

import '../../../../components/chips/CustomChoiceChips.dart';
import '../../../../components/chips/CustomChip.dart';
import '../components/GiftCardReceived.dart';
import '../components/GiftCardSent.dart';

final List<Map<String, dynamic>> tabData = [
  {'Id': 0, 'Name': 'Gift Cards Received'},
  {'Id': 1, 'Name': 'Gift Cards Sent'},
];

class GiftCardsScreen extends StatelessWidget {
  const GiftCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GiftCardBloc, GiftCardState>(builder: (context, state) {
      if (state.sendReceivedGiftCardState == CurrentAppState.SUCCESS) {
    return Column(
      children: [
        SizedBox(
            height: context.getScreenHeight(5),
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                final tabsData = tabData[index];
                return CustomChip<Map<String,dynamic>>(
                  data: ChoiceChipData<Map<String,dynamic>>(tabsData['Id'], tabsData['Name'], tabsData),
                  selectedDate: ChoiceChipData<Map<String,dynamic>>(state.selectedGiftsType!['Id'], state.selectedGiftsType!['Name'], state.selectedGiftsType),
                  onPressEvent: (data) {
                    context.read<GiftCardBloc>().add(OnSelectedGiftTypeEvent(data.data ?? <String,dynamic>{}));
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(width: 12,);
              }, itemCount: tabData.length,
              scrollDirection: Axis.horizontal,
            )
        ),
        const SizedBox(height: 20),

        if(state.selectedGiftsType!['Id'] == 0)...[
          ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => GiftCardReceived(
                  data:state.sendReceivedGiftCardsData!.received[index]),
              separatorBuilder: (context, index) =>SizedBox(height: context.getScreenHeight(5)),
              itemCount:state.sendReceivedGiftCardsData!.received.length),

        ]else...[
          ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => GiftCardSent(
                  data: state.sendReceivedGiftCardsData!.sent[index]),
              separatorBuilder: (context, index) =>
                  SizedBox(height: context.getScreenHeight(5)),
              itemCount: state.sendReceivedGiftCardsData!.sent.length),
        ]


      ],
    );
      }if (state.sendReceivedGiftCardState == CurrentAppState.LOADING) {
          return const Center(child: CircularProgressIndicator());
      }
      if (state.sendReceivedGiftCardState == CurrentAppState.ERROR) {
         return Center(
        child: Text(
            state.appException?.message ?? 'Failed to Load Data!!!'));
              }
              return const SizedBox();
            });
  }
}
