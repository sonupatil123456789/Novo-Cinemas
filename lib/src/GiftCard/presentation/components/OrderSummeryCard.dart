import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/core/utils/CurrencyFormater.dart';

import '../bloc/GiftCardBloc.dart';

class OrderSummeryCard extends StatelessWidget {
  const OrderSummeryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GiftCardBloc, GiftCardState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color:
              context.colorPalette.transparentColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color:
                  context.colorPalette.accentColor.withOpacity(0.4),
                  width: 0.5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  cardInfoTile(context, 'Purchase For', state.selectedGiftCardType!.title),
                  cardInfoTile(context, 'Name', '${state.sendGiftCardRequest['name']}'),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  cardInfoTile(context, 'Mail id', '${state.sendGiftCardRequest['email']}'),
                  cardInfoTile(context, 'Mobile. No', '${state.sendGiftCardRequest['phoneNumber']}'),
                ],
              ),
              Divider(height: 30, color: context.colorPalette.accentColor.withOpacity(0.6),
                thickness: 0.6,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text('Number of gift cards',
                    style: context.textThemeDecoration.titleSmall.copyWith(fontSize: 14, color: context.colorPalette.textColor.withOpacity(0.4)),),
                  Text(
                    '${state.sendGiftCardRequest['quantity']}', style: context.textThemeDecoration.subTitleLarge.copyWith(fontSize: 14),),

                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text('Total Cost of gift cards',
                    style: context.textThemeDecoration.titleSmall.copyWith(fontSize: 14, color: context.colorPalette.textColor.withOpacity(0.4)),),
                  Text('${currencyCode()} ${priceConverter(state.sendGiftCardRequest['price'])}',
                    style: context.textThemeDecoration.subTitleLarge.copyWith(fontSize: 14),),

                ],
              ),
              const SizedBox(height: 8),
              Text('Note: Details of the gift card will be shared on ${state.sendGiftCardRequest['email']}',
                style: context.textThemeDecoration.paragraphMedium.copyWith(
                    color: context.colorPalette.accentColor
                ),),

            ],
          ),
        );
      },
    );
  }


  Widget cardInfoTile(BuildContext context, String title, String subtitle) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: context.textThemeDecoration.titleSmall.copyWith(
              color: context.colorPalette.textColor.withOpacity(0.4)
          ),),
          const SizedBox(height: 3),
          Text(subtitle, style: context.textThemeDecoration.subTitleMedium,)
        ],
      ),
    );
  }


}
